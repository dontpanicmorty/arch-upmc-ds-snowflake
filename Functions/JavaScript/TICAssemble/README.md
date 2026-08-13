# UPMC In-Network MRF Exporter

Built as a standalone Node script because Snowflake doesn't support all our prereqs for external functions. This has been added to the Functions App (as you can see from the folder structure) but can also be run manually.

## Development/Configuration

Run `npm install`, no `config.js` shenanigans needed. Sorta.

General running note: you can specify `--date YYYY-MM-DD` to write to a specific date folder in Blob. Otherwise, it'll use the sproc in CMS*PRICING*\* to determine what Snowflake thinks the current date is, usually the closest first of the month to the current date.

### Dev

If you're running this against the dev environment, the prereq is just to be running this on a VM. Via Azure Managed Identities, the Azure team assigned our VMs access to the dev KeyVault and to the `snowflakedatadev` storage container, where we write files while testing. The default configuration will work; you'll be masquerading as a bot user (the username is a UUID and gets printed out early during execution), but that's fine and intended. Run `node driver.js` with the optional `--date` parameter, and you should be fine with no other config.

### Prod

Now, if you're trying to test this against the prod environment, you've got a bit more work to do. Open up `config.js` and you'll notice there are some things you're going to need to replace.

- Because you're running this on your VM and this can't access the prod KeyVault, we can't be the bot user, but we can be _you_. Use the `--username [you]@upmc.edu` parameter, using the username you log into Snowflake with (likely not your `_adm` account).
- Because you're now you, you can't use the default bot user role/warehouse. You'll need to specify `--role DS_ARCHITECT_ROLE` (or `DS_ANALYST_ROLE` if you don't have that) and `--warehouse DS_DEV_M_WH` (or as large as you want to go).
- Because you're on prod, you're also likely gonna want to overwrite the dev defaults for a few parameters, so add `--database CMS_PRICING --storageAccount hpsrpeus2saprdcdn --storageContainer publicweb`. `blobPrefix` gets set automatically when `storageAccount == hpsrpeus2saprdcdn`. The good news is that the VM managed identity also has write access to `hpsrpeus2saprdcdn`, so you don't need to worry about generating a token for that anymore.

The final call should be, for me: `node .\driver.js --database CMS_PRICING --storageAccount hpsrpeus2saprdcdn --storageContainer publicweb --role DS_ARCHITECT_ROLE --warehouse DS_DEV_WH --username horwitzar@upmc.edu`

Note that this can also be used for more niche stuff, like the HealthSparq extract: `node .\driver.js --database CMS_PRICING_HEALTHSPARQ --storageAccount snowflakedatadev --storageContainer outbounddata --blobPrefix healthsparq --role DS_ARCHITECT_ROLE --warehouse DS_DEV_WH --username horwitzar@upmc.edu`

**Note that browser auth in `driver.js` is triggered only and always by specifiying the `--username` property. If you've specified that, it'll assume you're trying to log in as a specific user and not as the default from whatever the access token returns.**

## Code overview

`index.js` is the main entrypoint for Azure Functions, when called through ADF. `driver.js` effectively acts as a way to manually run that from a dev VM.

- `index.js` determines what date we're running on
- `index.js` loads all the in-network-rates files
- `src/files.js:writeInNetworkRatesFile` loads the header info and provider references, then writes those to a file under `data/` with `in_network: [` at the end.
- `src/files.js:writeInNetworkRatesFile` then loads all the in_network objects via a `snowflake-sdk` stream, and writes them all as JSON objects inside the open array from the previou step
- `src/files.js:writeInNetworkRatesFile` caps the array and the top-level object
- `index.js:postProcessFile` streams the file into Blob Storage using the `websolutionsSAS` token

This should all be relatively seamless and change-resistant as long as the views/functions mentioned in `tic-assemble/src/sql.js` stay the same. Goal is just to stream JSON into memory, then directly to Blob. It's slower that way when compared to using the VM this is running on as a stage, but a) we've dug around in the Snowflake code to find the most efficient way to do it, and b) we can't guaranteeably store 1GB files on the Functions VMs, and they have very slow I/O.
