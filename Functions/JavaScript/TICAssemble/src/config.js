// This gets required multiple times but only executed once
const yargs = require('yargs/yargs');

// Set up default config values
const baseConfig = {
  // Azure props:
  keyVaultSecretURL:
    'https://hpd-ea-kv-hpds-dev-df.vault.azure.net/secrets/ADF-SF-ClientSecret/?api-version=7.0', // globalParameters.AzKeyVaultSFClientSecret
  tokenUrl:
    'https://login.microsoftonline.com/8b3dd73e-4e72-4679-b191-56da1588712b/oauth2/v2.0/token', //hardcoded
  adfClientID: '3be305ff-41c2-4be3-a73e-a8085d30f71d', // globalParameters.AzADFAppRegistrationClientID,
  sfScope: 'https://upmchs.onmicrosoft.com/upmchp.snowflake/.default', // hardcoded
  storageAccount: 'snowflakedatadev', // passed in
  storageContainer: 'cmspricing', // passed in
  blobPrefix: 'publicweb', // passed in; folder flexibility because snowflakedatadev:cmspricing/publicweb = hpsrpeus2saprdcdn:publicweb
  // SF connection props:
  database: 'CMS_PRICING_DEV', // passed in, can't use local DBs since ADF user can't access them
  role: 'DS_ADF_DEV_ROLE', // globalParameters.ADF_ROLE
  account: 'upmchp.east-us-2.azure', // hardcoded
  warehouse: 'DS_DEV_LOAD_L_WH', // globalParameters.ADF_ENV, passed in
  username: '' // defaults to being pulled from the access token generated from the keyVault secret. if provided, will be treated as a browser login
};

let argv = yargs(process.argv.slice(2))
  .command(
    'index.js <url>',
    'assembles all TiC in-network files from Snowflake ',
    (yargs) => {
      yargs.positional('url', {
        describe: 'URL to load',
        type: 'string'
      });
    }
  )
  .option('date', {
    description: `date to be used in blob URLs and to replace in all provider-reference URLs; defaults to pulling from DB`,
    type: 'string',
    default: null
  });

for (const prop in baseConfig)
  argv = argv.option(prop, {
    type: 'string', // sets up merge between config file and args correctly
    description:
      'overwrite/alternate for the config property with the same name'
  });

argv = argv.argv;

// Assign all args to config object
const config = {};
config.url = argv._[0];
Object.assign(config, argv);

// Because we need to dynamically set properties in some cases
function getConfig(prop) {
  return config[prop];
}

function setConfig(prop, val) {
  // One thing we know we need to do, since blobPrefix likely won't get passed in:
  if (prop === 'blobPrefix' && config.storageAccount === 'hpsrpeus2saprdcdn')
    val = '';

  config[prop] = val;
}

function resetConfig() {
  for (const prop in baseConfig) {
    setConfig(prop, baseConfig[prop]);
  }
}

module.exports = {getConfig, setConfig, resetConfig};
