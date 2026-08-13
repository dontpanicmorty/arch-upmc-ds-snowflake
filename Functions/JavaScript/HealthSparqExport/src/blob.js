const {BlobServiceClient} = require('@azure/storage-blob');
const {DefaultAzureCredential} = require('@azure/identity');

const {getConfig, setConfig} = require('./config.js');

/**
 * Gets the container client reference specified in the config
 */
async function getContainerClient() {
  if (getConfig('cc')) return getConfig('cc');

  const storageAccount = getConfig('storageAccount');
  const storageContainer = getConfig('storageContainer');
  const managedIdentity = getConfig('managedIdentity');

  const serviceClient = new BlobServiceClient(
    `https://${storageAccount}.blob.core.windows.net`,
    new DefaultAzureCredential({
      managedIdentityClientId: managedIdentity
    })
  );

  setConfig('cc', serviceClient.getContainerClient(storageContainer));
  return getConfig('cc');
}

/**
 * Generator for blobs in the `blobPrefix` folder.
 */
async function* listBlobs() {
  const blobPrefix = getConfig('blobPrefix');
  if (!blobPrefix) {
    throw new Error(
      `blobPrefix config option did not have a value. Please provide one and try again.`
    );
  }
  const containerClient = await getContainerClient();
  let blobs = containerClient.listBlobsFlat({prefix: blobPrefix});
  for await (const blob of blobs) {
    // Don't need allowed-amounts files
    if (blob.name.indexOf('allowed-amounts') > -1) continue;
    yield blob.name;
  }
}

/**
 * Returns a download stream for a given blobName
 * @param {*} blobName
 * @returns
 */
async function getBlobStream(blobName) {
  const containerClient = await getContainerClient();
  const blockBlobClient = containerClient.getBlockBlobClient(blobName);
  const downloadBlockBlobResponse = await blockBlobClient.download(0);
  return downloadBlockBlobResponse.readableStreamBody;
}

module.exports = {listBlobs, getBlobStream};
