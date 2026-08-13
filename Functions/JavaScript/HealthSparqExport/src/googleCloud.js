const fs = require('fs');
const path = require('path');

const archiver = require('archiver');
const {Storage} = require('@google-cloud/storage');
const {SecretClient} = require('@azure/keyvault-secrets');
const {DefaultAzureCredential} = require('@azure/identity');

const {getConfig, setConfig} = require('./config.js');

// The ID of your GCS bucket
const bucketName = 'upmc-ingress.nophi.kyruushsq.com';

async function getStorage() {
  // cached
  if (getConfig('storage')) return getConfig('storage');

  // Unpack the URL
  const keyVaultSecretURL = getConfig('keyVaultSecretURL');
  const urlRegex = /https:\/\/([^.]+).vault.azure.net\/secrets\/([^/]+)/;
  const urlRegexMatches = keyVaultSecretURL.match(urlRegex);

  if (urlRegexMatches.length !== 3) {
    throw new Error(
      `The KeyVault secret URL provided did not match the expected regex. Please update the Function code or the parameter, and try again.
        URL: ${keyVaultSecretURL}
        Expected regex: ${urlRegex}`
    );
  }

  keyVault = urlRegexMatches[1];
  clientSecretName = urlRegexMatches[2];

  // First, create a secret client pointing to the relevant keyvault
  const managedIdentity = getConfig('managedIdentity');
  const secretClient = new SecretClient(
    `https://${keyVault}.vault.azure.net/`,
    new DefaultAzureCredential({
      managedIdentityClientId: managedIdentity
    })
  );

  // Then get the secret we specifically needed
  const secret = await secretClient.getSecret(clientSecretName);
  setConfig('storage', new Storage({credentials: JSON.parse(secret.value)}));
  return getConfig('storage');
}

function getOutputLocation(blobName) {
  blobName = blobName.replace(/^\//, ''); // remove leading slashes so we know where we're at
  const prefix = getConfig('adfEnv') === 'PRD' ? 'prd' : 'test';
  const output = `${prefix}/${blobName}`; // where we're eventually writing to

  // Return the folder
  console.log(`Writing ${blobName} to ${output}`);
  return output;
}

/**
 * Gets a write stream for the Google Cloud blob at `outputLocation`
 * @param {*} outputLocation
 * @returns
 */
async function getWriteStream(outputLocation) {
  const storage = await getStorage();
  const bucket = storage.bucket(bucketName);
  const blob = bucket.file(outputLocation);
  const blobStream = blob.createWriteStream();

  blobStream.on('error', (err) => {
    throw err;
  });

  return blobStream;
}

/**
 * Writes (without zipping) the `stream` representing `blobName` to its
 * destination in Google Cloud
 * @param {*} blobName
 * @param {*} stream
 */
async function writeFile(blobName, stream) {
  const outputLocation = getOutputLocation(blobName);
  const writeStream = await getWriteStream(outputLocation);
  stream.pipe(writeStream);
  await new Promise((resolve, reject) => writeStream.on('finish', resolve));
}

/**
 * Writes (with zipping) the `stream` representing `blobName` to its
 * destination in Google Cloud
 * @param {*} blobName
 * @param {*} stream
 */
async function zipFile(blobName, stream) {
  const outputLocation = getOutputLocation(blobName) + '.zip';
  const writeStream = await getWriteStream(outputLocation);

  // Set up archive and stream output
  const archive = archiver('zip');
  archive.append(stream, {name: blobName});
  archive.pipe(writeStream);

  // Final output
  archive.finalize(function (err, bytes) {
    console.log(bytes + ' total bytes; zip complete');
  });

  // Wait for the write stream to finish
  await new Promise((resolve, reject) => writeStream.on('finish', resolve));
}

module.exports = {writeFile, zipFile};
