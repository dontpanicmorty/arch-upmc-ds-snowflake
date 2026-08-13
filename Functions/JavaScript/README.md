# UPMC Data Solutions JavaScript Functions

The only notes here are that `npm run deploy` and `npm run start` are set up to proxy to the Azure Functions CLI in this parent directory. As you create new functions to be uploaded, copy the `package.json` scripts block from TICAssemble, as `npm run deploy/start` there are set up to proxy to this project and also run the Azure Functions CLI scripts.

You can use the Managed Identity `bac06a40-dd31-4b52-9027-2f064a3eb5d2` for authing with Azure services in Node. You can get it assigned to your VM in Azure.

To fiddle with memory management stuff, we have the `languageworkers:node:arguments` application setting set to `--max-old-space-size=[memory in MB]`. 8GB should hopefully be enough?
