const path = require('path');

const {setConfig, resetConfig} = require('./src/config.js');

const {writeInNetworkRatesFile} = require(path.join(
  __dirname,
  'src',
  'files.js'
));
const connection = require(path.join(__dirname, 'src', 'snowflake.js'));
const sql = require(path.join(__dirname, 'src', 'sql.js'));

const DEFAULT_DATE = 'XXXX-XX-XX';
const params = {
  PRICING_FILE_KEY: '', // from Snowflake
  URL: '', // from Snowflake
  date: DEFAULT_DATE // date for folders in Blob
};

// How individual files come in when this is used as an external function
async function writeFile(context, url, sourceView, whereClause) {
  let filepath;
  if (sourceView === 'IN_NETWORK_FILE_JSON_VW') {
    filepath = await writeInNetworkRatesFile(
      context,
      url,
      whereClause,
      params.date
    );
  }

  return filepath;
}

// Context is first param, `body` is input params
module.exports = async function (context, body) {
  if (context && context.log) {
    console.log = context.log;
    console.error = context.error;
  }

  // Grab params from request body
  for (const param in params) {
    const newVal = body[param];
    if (newVal) params[param] = newVal;

    if (!params[param]) {
      context.status = 400;
      context.body = `TICAssemble function requires ${param} parameter; no value found.`;
    }
  }

  // Incorporate config overrides
  resetConfig(); // because Functions is weird and maintains values
  connection.resetConnections();

  for (const param in body) {
    if (param in params) continue; // ignore these
    const newVal = body[param];
    setConfig(param, newVal);
  }

  context.log(`TICAssemble running with params:`);
  context.log(JSON.stringify(params));
  context.log(`TICAssemble running with input body:`);
  context.log(JSON.stringify(body));

  // If no manual date was provided, get the default from the DB
  if (params.date === DEFAULT_DATE) {
    const ticDate = await connection.execute(
      {
        sqlText: sql.GET_TIC_DATE()
      },
      'XS'
    );
    params.date = ticDate[0].TIC_DATE;
    context.log(`Using ${params.date} as date, pulled automatically.`);
  } else {
    if (!params.date.match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/)) {
      throw new Error(
        `TICAssemble function 'date' parameter must match YYYY-MM-DD.`
      );
    }

    context.log(`Using ${params.date} as date, provided manually.`);
  }

  try {
    // URL comes from query, hardcode the view, make the whereClause
    const url = params.URL.replace('XXXX-XX-XX', params.date);
    const whereClause = `WHERE PRICING_FILE_KEY = ${params.PRICING_FILE_KEY};`;
    await writeFile(context, url, 'IN_NETWORK_FILE_JSON_VW', whereClause);

    context.log(`Upload complete.`);
    context.status = 200;
    context.res = {body: 'Success.'};
  } catch (err) {
    context.status = 500;
    context.res = {body: err};
    context.log(err);
  }

  context.log(context.res);
};
