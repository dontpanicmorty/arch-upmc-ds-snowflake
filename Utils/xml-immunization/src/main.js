const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

const {stringify} = require('csv-stringify/sync');
const unzipper = require('unzipper');

const {
  parser,
  getFiles,
  outputFolder,
  getBlobClient,
  streamToText
} = require('./utils.js');
let {
  folder,
  azurePrefix,
  storageAccount,
  storageContainer,
  azureOutputPrefix
} = require('./config.js');
const {PassThrough} = require('stream');

// Top-level keys are filenameHash, second-level keys are the filepath, values
// are the streams themselves. Top-level keys make it easier to remove stuff
// when we're done.
const writeStreams = {};

async function closeStreams(filenameHash) {
  for (const key in writeStreams) {
    if (key.indexOf(filenameHash) > -1) {
      writeStreams[key].end();
      delete writeStreams[key];
    }
  }
}

/**
 * Writes `line` to `file`.
 * @param {*} file - a filepath, relative to `outputFolder`
 * @param {*} line - an array of values to be converted to a one-row CSV and
 *  appended to the file
 */
async function writeLine(file, line) {
  // Get the full path
  const fullPath = azurePrefix
    ? path.join(azureOutputPrefix, outputFolder, file)
    : path.join(outputFolder, file);

  // Ensure all folders above this file exist:
  const leafmostFolder = fullPath.substring(0, fullPath.lastIndexOf(path.sep));
  if (!fs.existsSync(leafmostFolder))
    fs.mkdirSync(leafmostFolder, {recursive: true});

  if (!(fullPath in writeStreams)) {
    if (azurePrefix) {
      const containerClient = getBlobClient(storageAccount, storageContainer);
      const blockBlobClient = await containerClient.getBlockBlobClient(
        fullPath
      );
      const writeStream = new PassThrough();
      writeStreams[fullPath] = writeStream;
      blockBlobClient.uploadStream(writeStream);
    }
    // Already threw an error if `folder` wasn't specified
    else {
      writeStreams[fullPath] = fs.createWriteStream(fullPath);
    }
  }

  // Append content
  const data = stringify([line]);
  writeStreams[fullPath].write(data);
}

/**
 * Processes an XML file.
 * @param {*} content - an unparsed (string) XML document
 * @param {*} filename - a unique string for which a distinct set of output CSVs
 *  should be created. Could be for an entire ZIP, could be a single XML file.
 * @returns
 */
async function handleXMLFile(content, filename) {
  let xml;
  try {
    xml = parser.parseFromString(content.toString());
  } catch (err) {
    console.error(err);
    return;
  }

  // For each table:
  for (const table in tableHandlers) {
    // Pass the XML in to the handler.
    const writeValues = tableHandlers[table](xml);

    // Spot-checking return values before we try to write:
    if (!writeValues) continue; // falsy is fine, means nothing was to be written
    if (!Array.isArray(writeValues)) {
      // unexpected
      throw new Error(
        `Handler for table ${table} returned something that was not an array. Please fix this.`
      );
    }
    if (writeValues.length === 0) continue; // means nothing is to be written

    // Spot-checking each array value:
    const lengthSet = new Set(); // Make sure there's only one length for the table
    for (const row of writeValues) {
      lengthSet.add(row.length);
      if (!Array.isArray(row)) {
        // And make sure they're all arrays
        const stringReps = `${row.toString}, ${JSON.stringify(row)}`;
        throw new Error(
          `Array returned by handler for table ${table} contained something that was not an array. One of these should print correctly: ${stringReps}`
        );
      }
    }

    // Unexpected - throw an error if the CSVs will have different lengths
    if (lengthSet.size > 1) {
      throw new Error(
        `Array returned by handler for table ${table} contained all arrays, but of different lengths. Please fix this.`
      );
    }

    // And if we hit this point, we're good to write the values
    const csvFilename = path.join(table, filename + '.csv');
    for (const line of writeValues) await writeLine(csvFilename, line);
  }
}

// Keys are table names, values are functions to pull rows from a given XML file.
const tableHandlers = {};
async function loadTableHandlers() {
  for await (const f of getFiles(path.join('.', 'table-handlers'))) {
    // Skip any non-JS files
    if (!f.endsWith('.js')) continue;

    // Get the filename and remove the extension to get the table name
    const splitFilename = f.split(path.sep);
    const tableName = splitFilename[splitFilename.length - 1].replace(
      '.js',
      ''
    );

    // Assign the handler
    const mod = require(f);
    if (!(typeof mod.handler === 'function')) {
      throw new Error(
        `Table handler ${tableName} does not export a function named "handler." Please fix this.`
      );
    }
    tableHandlers[tableName] = require(f).handler;
  }
}

// Handles a zip stream and yields a processXMLFile per entry
async function handleZIPStream(stream, filename, filenameHash) {
  // Set up diagnostics
  console.log('Handling zip:', filename);

  let entryCount = 0;
  let startTime = new Date().getTime();
  const diag = (content) => {
    const elapsed = (new Date().getTime() - startTime) / 1000;
    console.log(`    Zip ${filename}: ${content} (elapsed: ${elapsed}s)`);
  };

  const zip = stream.pipe(unzipper.Parse({forceStream: true}));
  for await (const entry of zip) {
    // Internal diag
    entryCount++;
    diag(`Handling entry #${entryCount}: ${entry.path}`);

    // Copy content into memory
    let content;
    await new Promise((resolve) => {
      entry.on('data', (chunk) => (content += chunk));
      entry.on('end', resolve);
    });

    // Close entry pointer
    entry.autodrain();

    // Process it
    await handleXMLFile(content, filenameHash);
  }

  // Note that we're done:
  diag('Finished.');
  console.log('\n'); // to be replaced by the diag() line skip
}

// Generator that returns objects with `filename` and `content` properties, which
// then get forwarded on to processXMLFile with common logic.
async function loadFSFiles() {
  for await (const filename of getFiles(folder)) {
    // Get a hash of the filename to separate stuff out in the output folder
    const filenameHash = crypto
      .createHash('md5')
      .update(filename)
      .digest('hex');

    // Single XML files
    if (filename.endsWith('xml')) {
      console.log(`Handling standalone XML: ${filename}`);
      const file = fs.readFileSync(filename);
      await handleXMLFile(file, filenameHash);
    }
    // Zips of XML files - proxy the objects returned by handleZIPStream
    else if (filename.endsWith('zip')) {
      const stream = fs.createReadStream(filename);
      await handleZIPStream(stream, filename, filenameHash);
    }

    await closeStreams(filenameHash);
  }
}

async function loadAzureFiles() {
  const containerClient = getBlobClient(storageAccount, storageContainer);
  let blobs = containerClient.listBlobsFlat({prefix: azurePrefix});
  for await (const blob of blobs) {
    const filename = blob.name;
    // Get a hash of the filename to separate stuff out in the output folder
    const filenameHash = crypto
      .createHash('md5')
      .update(filename)
      .digest('hex');

    const blockBlobClient = containerClient.getBlockBlobClient(filename);
    // Single XML files
    if (filename.endsWith('xml')) {
      console.log(`Handling standalone XML: ${filename}`);
      const downloadBlockBlobResponse = await blockBlobClient.download(0);
      const content = await streamToText(
        downloadBlockBlobResponse.readableStreamBody
      );

      await handleXMLFile(content, filenameHash);
    }
    // Zips of XML files - proxy the objects returned by handleZIPStream
    else if (filename.endsWith('zip')) {
      const downloadBlockBlobResponse = await blockBlobClient.download(0);
      const stream = downloadBlockBlobResponse.readableStreamBody;
      await handleZIPStream(stream, filename, filenameHash);
    }
    await closeStreams(filenameHash);
  }
}

async function process() {
  await loadTableHandlers();

  // Handle all files in the specified manner
  let handler;
  if (azurePrefix) {
    await loadAzureFiles();
  } else if (folder) {
    await loadFSFiles();
  } else throw new Error('Either --azurePrefix or --folder must be specified.');

  console.log(Object.keys(writeStreams).length, 'streams remaining');
}

module.exports = {process};
