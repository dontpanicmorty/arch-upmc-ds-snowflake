const {listBlobs, getBlobStream} = require('./blob.js');
const {writeFile, zipFile} = require('./googleCloud.js');

module.exports.process = async function () {
  let controlFileName, controlFileBlobname;
  for await (const blobName of listBlobs()) {
    // Get the filename component
    const filename = blobName.match(/[^/]*$/)[0];

    // Save the control file, has to go last
    if (filename.indexOf('CONTROL_FILE') > -1) {
      controlFileName = filename;
      controlFileBlobname = blobName;
      continue;
    }

    // Get a stream for everything else
    const stream = await getBlobStream(blobName);

    // If it's a HealthSparq schema file, just write it, don't zip it
    if (filename.startsWith('UPMC_')) {
      await writeFile(filename, stream);
    }

    // Otherwise, zip all the MRF files
    else {
      await zipFile(filename, stream);
    }
  }

  // Finally, write the control file at the end to trigger the load
  const controlFileStream = await getBlobStream(controlFileBlobname);
  await writeFile(controlFileName, controlFileStream);
};
