//
//needs to access src/config then src/utils to access xml files on test-data
//

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

  context.log(`xml-immunization running with input body:`);
  context.log(JSON.stringify(body));

  try {
    //TODO: do what you need, likely just run `process()` since the config is in place
    const {process} = require('./src/main.js');
    await process();

    context.status = 200;
    context.res = {body: 'Success.'};
  } catch (err) {
    context.status = 500;
    context.res = {body: err};
    context.log(err);
  }

  context.log(context.res);
};
