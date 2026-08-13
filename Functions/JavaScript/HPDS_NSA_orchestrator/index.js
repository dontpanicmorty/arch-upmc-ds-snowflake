const df = require('durable-functions');

// Orchestrates individual calls to TICAssemble. Could take a set of N URL/key
// tuples and yield all of them, but prod supported wanted that logic in ADF.
module.exports = df.orchestrator(function* (context) {
  const outputs = [];

  // Quad-stacked object is actually how deep the input object is here
  let input = context.bindings.context.input;

  // Comes in from ADF as a string
  if (typeof input === 'string') input = JSON.parse(input);

  if (!input.functionName) {
    throw new Error(
      `functionName property must be present on body passed through to orchestrator.`
    );
  }

  outputs.push(yield context.df.callActivity(input.functionName, input));

  return outputs;
});
