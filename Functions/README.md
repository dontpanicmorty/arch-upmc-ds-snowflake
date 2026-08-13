# UPMC Data Solutions Azure Functions resources

This folder contains two Azure Function Apps that contains various Functions used to support Snowflake. **Note that, for now, we can't use these as Snowflake External Functions as Snowflake doesn't support setting up API Gateways, which we require due to security constraints.**

The Python and JavaScript apps are separate because each Function App can have one and only one language. Make sure each function you create is well-documented.

## Development instructions

Because we have two separate Function Apps, the VSCode extension sometimes doesn't work that well. You'll have to set a default (or select which one you're working with) if you're using the UI.

Setting default also updates `.vscode/settings.json`; I've set it to JS for now, but we may eventually pivot back to Python. This actually makes a bit of sense to update with the most recently active Functions App, as people are going to be testing the active one in PRs.

### Prereqs:

- [AZ CLI installation](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- Run `az login` and follow instructions for your \_adm account
- [Azure Function extension for VSCode](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)
- [Azure Functions local dev tools](https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local)

### To run:

- `func start` in one terminal window. (or `npm run start`)
- Go to the VSCode Azure Functions extension pane.
- Right-click the function you want to run and click "Execute Function Now", then drop JSON in.

### To deploy:

Both of these are aliased as `npm run deploy` in their respective folders.

- JavaScript app: `func azure functionapp publish hpd-ea-func-hpds-dev-nsa --javascript` to deploy
- Python app: `func azure functionapp publish hpd-ea-func-hpds-dev-nsapy --python` to deploy

## Debugging notes

- For info on durable functions in ADF, http://datanrg.blogspot.com/2020/10/using-durable-functions-in-azure-data.html was what I used
- If you get a "Error calling sync triggers (BadRequest)" error, make sure the Function App is turned on.
