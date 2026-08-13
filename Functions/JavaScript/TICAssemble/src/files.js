const path = require('path');
const {PassThrough} = require('node:stream');

const connection = require(path.join(__dirname, 'snowflake.js'));
const sql = require(path.join(__dirname, 'sql.js'));
const {getBlobClient, formatSize, WATERMARK} = require(path.join(
  __dirname,
  'utils.js'
));

const {getConfig} = require(path.join(__dirname, 'config.js'));

async function writeInNetworkRatesFile(context, url, whereClause, date) {
  // Prep stream resources
  const startTime = new Date().getTime();

  const writeStream = new PassThrough({
    highWaterMark: WATERMARK
  });

  // Prep Azure resources
  const storageAccount = getConfig('storageAccount');
  const storageContainer = getConfig('storageContainer');
  const blobPrefix = getConfig('blobPrefix');
  const containerClient = getBlobClient(storageAccount, storageContainer);
  let blobName = blobPrefix + url;

  // If blobPrefix is an empty string, the beginning `/` on URL will trigger an
  // empty top-level folder in Blob, which we don't want, because that'll affect
  // the URL. Remove it.
  if (blobName.startsWith('/')) blobName = blobName.slice(1);

  const blockBlobClient = containerClient.getBlockBlobClient(blobName);
  context.log(`Writing to ${storageAccount}:${storageContainer}/${blobName}`);
  const blobUploadPromise = blockBlobClient.uploadStream(
    writeStream, // content
    16 * 1024 * 1024, // block size
    4, // concurrency
    {
      // With each block completion:
      onProgress: (ev) => {
        const loadedSize = formatSize(ev.loadedBytes);
        const secondsElapsed = (new Date().getTime() - startTime) / 1000;
        const speed = formatSize(ev.loadedBytes / secondsElapsed) + '/s';

        // Print diag
        context.log(
          `Uploaded ${loadedSize} (${speed}, ${secondsElapsed} seconds elapsed).`
        );
      }
    }
  );

  let fileBase = await connection.execute(
    {
      sqlText: sql.IN_NETWORK_FILE_BASE_SELECT_VW(whereClause)
    },
    'XS'
  );
  fileBase = fileBase[0];
  if (!fileBase) {
    throw new Error(
      `IN_NETWORK_FILE_BASE_SELECT_VW query failed with '${whereClause}' - this probably means that the query that seeded the Azure Functions ` +
        `calls was performed on a different database than the script is running against.`
    );
  }
  context.log(`File base received.`);

  // Replace XXXX-XX-XX in the provider references with the current date
  const provRefJson = JSON.stringify(
    fileBase.PRICING_PROVIDER_REFERENCE_JSON
  ).replace(/XXXX-XX-XX/g, date);

  // Convert to a string and write up to where the in_network array starts
  let fileBaseString = JSON.stringify({
    reporting_entity_name: fileBase.REPORTING_ENTITY_NAME,
    reporting_entity_type: fileBase.REPORTING_ENTITY_TYPE,
    last_updated_on: fileBase.LAST_UPDATED_ON_DATE,
    version: fileBase.VERSION,
    provider_references: JSON.parse(provRefJson),
    in_network: []
  }).replace(/\]\}$/, '');
  writeStream.write(fileBaseString);
  context.log('Initial part written.');

  let idx = 0;
  function rowHandler(row) {
    // valid JSON requires correct commas
    let toWrite = JSON.stringify(row.IN_NETWORK_JSON);
    if (idx > 0) toWrite = ',' + toWrite;
    writeStream.write(toWrite);

    idx++;
    if (idx % 1000 === 0) {
      context.log(`    ${idx} rows processed.`);
    }
  }

  await connection.stream(
    {
      sqlText: sql.IN_NETWORK_BASE(whereClause)
    },
    'L',
    rowHandler
  );

  // Add what we removed before and end things
  await writeStream.end(']}');
  await blobUploadPromise;
  context.log('Complete.');
}

module.exports = {
  writeInNetworkRatesFile
};
