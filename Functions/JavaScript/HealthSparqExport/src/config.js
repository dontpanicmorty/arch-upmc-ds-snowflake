// This gets required multiple times but only executed once
const yargs = require('yargs/yargs');

// Set up default config values
const baseConfig = {
  // Azure props:
  adfEnv: 'DEV', // globalParameters.ADF_ENV
  keyVaultSecretURL:
    'https://hpd-ea-kv-hpds-dev-df.vault.azure.net/secrets/upmc-1789-GCS/?api-version=7.0', // globalparametrs.HealthsparqCredsSecret
  tokenUrl:
    'https://login.microsoftonline.com/8b3dd73e-4e72-4679-b191-56da1588712b/oauth2/v2.0/token', // hardcoded
  storageAccount: 'snowflakedatadev', // passed in, source account
  storageContainer: 'outbounddata', // passed in, source container
  blobPrefix: '', // passed in, we DO NOT contact Snowflake here, so this should include the date folder. (healthsparq/2023-03-01, for an example)
  managedIdentity: 'bac06a40-dd31-4b52-9027-2f064a3eb5d2', // default Functions MI

  // Persistent things that should get reset each round:
  cc: null, // blob container client
  storage: null // Google Cloud storage reference
};

let argv = yargs(process.argv.slice(2)).command(
  'index.js',
  `copies all files from storageAccount:storageContainer/blobPrefix to HealthSparq's Google Cloud bucket`
);

for (const prop in baseConfig)
  argv = argv.option(prop, {
    type: 'string', // sets up merge between config file and args correctly
    description:
      'overwrite/alternate for the config property with the same name'
  });

argv = argv.argv;

const config = {};

// Because we need to dynamically set properties in some cases
function getConfig(prop) {
  return config[prop];
}

function setConfig(prop, val) {
  config[prop] = val;
}

function resetConfig() {
  for (const prop in baseConfig) {
    setConfig(prop, baseConfig[prop]);
  }

  // Assign all args to config object
  Object.assign(config, argv);
}

module.exports = {getConfig, setConfig, resetConfig};
