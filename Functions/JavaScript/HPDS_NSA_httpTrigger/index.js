const df = require('durable-functions');

// HTTP trigger that calls TICAssembleOrchestrator
module.exports = async function (context, req) {
  const client = df.getClient(context);
  if (!req.body.functionName) req.body.functionName = req.params.functionName;
  const instanceId = await client.startNew(
    req.params.functionName,
    undefined,
    req.body
  );

  context.log(
    `Started ${req.params.functionName} orchestration with ID = '${instanceId}'.`
  );

  return client.createCheckStatusResponse(context.bindingData.req, instanceId);
};
