const fs = require('fs');
const path = require('path');

const {DefaultAzureCredential} = require('@azure/identity');
const {SecretClient} = require('@azure/keyvault-secrets');
const {BlobServiceClient} = require('@azure/storage-blob');

// Converts bytes to human-readable MB
function formatSize(bytes) {
  return Math.floor(bytes / 1000000) + 'MB';
}

const isAzure = fs.existsSync(path.join('D:\\', 'home'));

function getBlobClient(account, container) {
  const serviceClient = new BlobServiceClient(
    `https://${account}.blob.core.windows.net`,
    new DefaultAzureCredential({
      managedIdentityClientId: 'bac06a40-dd31-4b52-9027-2f064a3eb5d2'
    })
  );

  return serviceClient.getContainerClient(container);
}

let sc; // in case we need to use the backup
async function getSecret(vault, secretName) {
  // Try the main MI
  sc = new SecretClient(
    `https://${vault}.vault.azure.net/`,
    new DefaultAzureCredential({
      managedIdentityClientId: 'bac06a40-dd31-4b52-9027-2f064a3eb5d2'
    })
  );

  const secret = await sc.getSecret(secretName);
  return secret;
}

// Common handler for waiting a certain amount of time
async function wait(ms) {
  await new Promise((resolve) => setTimeout(resolve, ms));
}

// Blob stream consts
const BLOCK_SIZE = 16 * 1024 * 1024;
const CONCURRENCY = 4;
const WATERMARK = BLOCK_SIZE * CONCURRENCY;
const SF_WATERMARk = 5; // max rows to return at once in a stream

module.exports = {
  isAzure,
  getBlobClient,
  getSecret,
  wait,
  formatSize,

  BLOCK_SIZE,
  CONCURRENCY,
  WATERMARK,
  SF_WATERMARk
};
