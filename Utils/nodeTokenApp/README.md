# Snowflake SQL API tokens

## Production: getting a token for an application service principal

**Prerequisite:** create an app registration in Azure for your enterprise application. This will likely require contacting Zenia's team to set up the required resources.

The steps to set up programmatic access are as follows:

1. **You** should create a Production Support Cherwell ticket that:

- Describes your planned use for Snowflake data.
- Includes the "Object ID" for your app registration, visible on the "Overview" page under the "Essentials" section on Azure.

2. **We** will create a user in Snowflake corresponding to the Object ID, as well as the requested role.
3. **We** will duplicate the role definition in the "Health Plan IDAP Snowflake OAuth Resource" Azure application registration in a place where you can find it.
4. Upon confirmation that the above two steps have been completed, **you** should open up the App Registration and:

- Go to "API permissions" in the sidebar.
- Click "Add a permission" under the "Configured Permission" section.
- Click the "My APIs" tab on the popover sidebar.
- Select the "Health Plan IDAP Snowflake OAuth Resource" app.
- Click the "Application permissions" button on the new page.
- Select the requested role.

5. At this point, **Directory Services** will provide admin consent, as app-to-app communications require it.

Once the admins have signed off on this, you can then make requests for a token using the `.default` scope, which should return the specific Snowflake role you requested. To do this in NodeJS, you can run:

```js
const msal = require('@azure/msal-node');

(async function () {
  const clientConfig = {
    auth: {
      knownAuthorities: [
        'https://login.microsoftonline.com/8b3dd73e-4e72-4679-b191-56da1588712b' // UPMCHP tenant
      ],
      clientId: 'df41a9e4-3382-4c85-8204-1d17f309d799', // "Application (client) ID" from the App Registration overview page
      authority:
        'https://login.microsoftonline.com/8b3dd73e-4e72-4679-b191-56da1588712b', // Also the UPMCHP tenant
      clientSecret: '________________' // or a certificate, managed under "Certificates & Secrets" on the App Registration page
    }
  };
  const pca = new msal.ConfidentialClientApplication(clientConfig);
  const res = await pca.acquireTokenByClientCredential({
    scopes: [
      'https://upmchs.onmicrosoft.com/upmchp.snowflake/.default' // Use this scope verbatim
    ]
  });
  console.log(res); // access_token property here, as well as other things
})();
```

In the C#/.NET libraries, you'll need a connection string like:

```
`$"account=upmchp;host=upmchp.east-us-2.azure.snowflakecomputing.com;user=_______@upmc.edu;role=_____ROLE;authenticator=oauth;token={token};db=idap;schema=dimdata;"`
```

## Development: getting a token for yourself

This is kept in as a backup for when app registrations aren't set up yet and development work needs to continue. Your UPMC account should already have development access to Snowflake under a certain role. Ask us to add the role you're using in Snowflake as a scope to our enterprise app registration, then use this app to get yourself an OAuth token you can use to auth against Snowflake for developing applications that make SQL queries.

In production, you **must** use the service account strategy detailed above.

To run this:

```sh
npm install # to load any deps
node index.js # to turn on the server
```

...Then navigate to `http://localhost:8012/` and follow instructions there.

Use the token (starting with `ey...`) with the following headers on requests to Snowflake:

```
POST https://upmchp.east-us-2.azure.snowflakecomputing.com/api/statements


User-Agent: '[YOUR CLIENT NAME, ARBITRARY]',
Authorization: Bearer ey...
X-Snowflake-Authorization-Token-Type: OAUTH
```

https://docs.snowflake.com/en/developer-guide/sql-api/index.html

### Notes

Base code HIDEOUSLY stolen from "Update 2" on this StackOverflow page, which I can
not thank enough:

https://stackoverflow.com/questions/63347299/unable-to-acquire-token-silently-or-via-redirect-using-msal-browser

Other resources that might help you if we ever need to do anything else:
https://github.com/AzureAD/microsoft-authentication-library-for-js/tree/dev/lib/msal-node
https://docs.microsoft.com/en-us/azure/active-directory/develop/msal-authentication-flows#usernamepassword
https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth-ropc
https://login.microsoftonline.com/8b3dd73e-4e72-4679-b191-56da1588712b/v2.0/.well-known/openid-configuration

https://upmchs.onmicrosoft.com/upmchp.snowflake/user with a scope of https://upmchs.onmicrosoft.com/upmchp.snowflake/user/session:scope:DS_Analyst
