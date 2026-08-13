const path = require('path');

const ticAssemble = require(path.join(__dirname, 'index.js'));

const connection = require(path.join(__dirname, 'src', 'snowflake.js'));
const sql = require(path.join(__dirname, 'src', 'sql.js'));
const {resetConfig} = require(path.join(__dirname, 'src', 'config.js'));

(async function () {
  resetConfig();
  const inNetworkFiles = await connection.execute(
    {
      sqlText: sql.IN_NETWORK_RATES_FILES()
    },
    'XS'
  );
  console.log(`${inNetworkFiles.length} total in-network files to write.`);
  for (const inNetworkFile of inNetworkFiles) {
    console.log(`Loading data for file ${inNetworkFile.PRICING_FILE_KEY}...`);

    // Azure requires we use `context.log` instead of `console.log`; this shims
    // that so all `context.log` calls print out to the command line
    const context = {
      log: console.log
    };
    await ticAssemble(context, {
      PRICING_FILE_KEY: inNetworkFile.PRICING_FILE_KEY,
      URL: inNetworkFile.URL
    });
  }
})()
  .then((diag) => console.log(diag))
  .catch((err) => console.error(err));
