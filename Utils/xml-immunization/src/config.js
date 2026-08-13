// This gets required multiple times but only executed once
const yargs = require('yargs/yargs');

// Set up default config values
const config = {
  // Azure props:
  storageAccount: 'snowflakedatadev', // passed in
  storageContainer: 'oracle', // passed in
  azureOutputPrefix: 'cchie', // for output, will append `output/[timestamp]/`
  managedIdentity: 'bac06a40-dd31-4b52-9027-2f064a3eb5d2' // default for the Functions app, works from VMs too
};

let argv = yargs(process.argv.slice(2))
  .command(
    'index.js [--folder ____] [--azurePrefix ____]',
    'processes a given HL2 XML file (or ZIP of XML files) for the CCHIE Oracle tables'
  )
  .option('folder', {
    description: `filesystem folder to pull from; will also write output to local 'output' folder`,
    type: 'string',
    default: null
  })
  .option('azurePrefix', {
    description: `Azure prefix to match blobs from; will also write output to Azure`,
    type: 'string',
    default: null
  });

for (const prop in config)
  argv = argv.option(prop, {
    type: 'string', // sets up merge between config file and args correctly
    description:
      'overwrite/alternate for the config property with the same name'
  });

argv = argv.argv;

// Assign all args to config object
Object.assign(config, argv);

// Because Windows does this
if (config.folder) config.folder = config.folder.replace(/"/g, '');

module.exports = config;
