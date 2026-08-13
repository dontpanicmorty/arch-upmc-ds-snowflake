const {setConfig, resetConfig} = require('./src/config.js');

// Context is first param, `body` is input params
module.exports = async function (context, body) {
  if (context && context.log) {
    console.log = context.log;
    console.error = context.error;
  }

  // Incorporate config overrides
  resetConfig(); // because Functions is weird and maintains values
  for (const param in body) {
    const newVal = body[param];
    setConfig(param, newVal);
  }

  context.log(`HealthSparqExport running with input body:`);
  context.log(JSON.stringify(body));

  // Run `require` here after all the config gets set
  const {process} = require('./src/main.js');
  await process();
};
