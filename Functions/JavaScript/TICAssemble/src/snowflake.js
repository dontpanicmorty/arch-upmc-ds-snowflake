const path = require('path');

const axios = require('axios');
const snowflake = require('snowflake-sdk');

const {getConfig} = require(path.join(__dirname, 'config.js'));
const {wait, getSecret, SF_WATERMARk} = require(path.join(
  __dirname,
  'utils.js'
));

// Technically max statements against a single table but it's hard to track what
// exactly we're touching at any given time. Not a huge concern after pivoting to
// the CSV implementation, but we don't want to risk it.
const MAX_STATEMENTS = 20;

const APPLICATION_NAME = 'UPMC_CMS_PRICING_REINGEST';
class ConnectionManager {
  constructor() {
    this.statementCount = 0;

    // Reused across pools
    this.accessToken = null;

    // Dynamic connections because we'll need a large+ for some things, but don't
    // want to use them if we don't need to.
    this.connections = {};

    this.username = getConfig('username');
  }

  //Clear out all old connections and access token.
  resetConnections() {
    this.accessToken = null;
    this.connections = {};
  }

  async generateAccessToken() {
    if (this.accessToken) return;

    console.log('Generating access token for Snowflake.');

    let keyVault = getConfig('keyVault');
    let clientSecretName = getConfig('clientSecretName');
    let keyVaultSecretURL = getConfig('keyVaultSecretURL');

    // Unpack the URL into the two parameters we need, if it was provided
    if (keyVaultSecretURL) {
      const urlRegex = /https:\/\/([^.]+).vault.azure.net\/secrets\/([^/]+)/;
      const urlRegexMatches = keyVaultSecretURL.match(urlRegex);

      if (urlRegexMatches.length !== 3) {
        throw new Error(
          `The KeyVault secret URL provided did not match the expected regex. Please update the Function code or the parameter, and try again.
          URL: ${keyVaultSecretURL}
          Expected regex: ${urlRegex}`
        );
      }

      keyVault = urlRegexMatches[1];
      clientSecretName = urlRegexMatches[2];
    }

    let tokenUrl = getConfig('tokenUrl');
    let adfClientID = getConfig('adfClientID');
    let sfScope = getConfig('sfScope');

    // First create a secret client pointing to the relevant keyvault
    const secret = await getSecret(keyVault, clientSecretName);
    const sfClientSecret = secret.value;

    // Then use that to get a token we can auth against Snowflake with
    const tokenResponse = await axios.post(
      tokenUrl,
      new URLSearchParams({
        client_id: adfClientID,
        client_secret: sfClientSecret,
        grant_type: 'client_credentials',
        scope: sfScope
      }).toString()
    );
    this.accessToken = tokenResponse.data.access_token;

    // Parse the username out of the token claims so we don't have to provide it
    // manually
    const tokenClaims = JSON.parse(
      Buffer.from(this.accessToken.split('.')[1], 'base64')
    );
    this.username = tokenClaims.sub;
  }

  async createConnection(size) {
    // If the warehouse for this size has been created, return it
    if (size in this.connections) return this.connections[size];

    // Otherwise, unpack config
    let account = getConfig('account');
    let role = getConfig('role');
    let database = getConfig('database');

    // Use the config warehouse as a pattern
    const warehouseBase = getConfig('warehouse');
    const warehouse = warehouseBase.replace(/_[A-Z+]_WH$/, `_${size}_WH`);

    let poolOptions = {
      role,
      database,
      account,
      warehouse,
      application: APPLICATION_NAME,
      rowStreamHighWaterMark: SF_WATERMARk
    };

    // If we specified a username in the config, we want to use browser auth
    let configUsername = getConfig('username');
    if (configUsername) {
      this.username = configUsername;
      poolOptions.authenticator = 'EXTERNALBROWSER';
    }
    // Otherwise, we need to get a token from the key vault and use the token's
    // username
    else {
      await this.generateAccessToken(); // no-op if already generated
      poolOptions.authenticator = 'OAUTH';
      poolOptions.token = this.accessToken;
    }

    poolOptions.username = this.username;

    console.log(
      `Creating connection pool for size ${size}, (db: ${database}, username ${this.username}).`
    );

    this.connections[size] = snowflake.createConnection(poolOptions);
    // connectAsync is the only one that'll work for browser
    if (configUsername) await this.connections[size].connectAsync();
    // And gotta set up a promise for regular connections
    else {
      await new Promise((resolve, reject) => {
        this.connections[size].connect(function (err, conn) {
          if (err) {
            console.log(err);
            reject('Unable to connect to Snowflake: ' + err.message);
          } else {
            resolve(conn.getId());
          }
        });
      });
    }

    return this.connections[size];
  }

  /**
   * Async wrapper for connection.execute. Will resolve to `rows` and will reject
   * on `err`. Do not call this with a `complete` option, as it'll be overwritten.
   *
   * @param {*} options
   */
  execute(options, size = 'L') {
    if (!options || !options.sqlText)
      throw new Error('Requires options.sqlText');

    const self = this;

    // The actual function that processes the data. We need to be able to rerun
    // this, so it's segmented out.
    async function process(resolve, reject) {
      const connection = await self.createConnection(size);
      while (self.statementCount > MAX_STATEMENTS) {
        await wait(500);
      }

      options.complete = (err, stmt, rows) => {
        self.statementCount--;
        if (rows) resolve(rows);
        if (err) reject(err);
      };

      self.statementCount++;
      connection.execute(options);
    }

    // Standardized way of printing an error
    async function stringError(err) {
      console.log(
        `During execution of:\n${
          options.sqlText
        }\n\nWith binds:${JSON.stringify(options.binds)}\n\n${err}`
      );
    }

    // Start a promise with the data
    return new Promise(async (resolve, reject) => {
      // Try to process once
      new Promise(process)
        // If it was successful, return the results
        .then((data) => resolve(data))
        // But if it errored...
        .catch((err) => {
          // ...and it was because of a terminated connection...
          if (err.message.indexOf('terminated connection') > -1) {
            console.log(
              'Encountered a terminated connection error; recreating pool and running again'
            );
            // Delete the connection pool and try again, it'll be re-created
            delete self.connections[size];
            new Promise(process)
              // If that worked, return the data
              .then((data) => resolve(data))
              // If that didn't work, print an error and fail
              .catch((err) => reject(stringError(err)));
          }
          // If we had any other error, print and fail
          else reject(stringError(err));
        });
    });
  }

  /**
   * Async wrapper for connection.execute, with streaming. Takes a function to be
   * called on each row as the second parameter. Not used here anymore because we
   * try not to have data in memory, but retained in case.
   *
   * @param {*} options
   */
  async stream(options, size, rowHandler) {
    if (!options || !options.sqlText || !rowHandler)
      throw new Error('Requires options.sqlText and rowHandler.');

    let self = this;
    return new Promise(async (resolve, reject) => {
      const connection = await self.createConnection(size);

      while (this.statementCount > MAX_STATEMENTS) {
        await wait(500);
      }

      options.complete = function (err, stmt, rows) {
        const stream = stmt.streamRows();

        stream.on('error', function (err) {
          reject(
            `During execution of:\n${
              options.sqlText
            }\n\nWith binds:${JSON.stringify(options.binds)}\n\n${err}`
          );
        });

        stream.on('data', rowHandler);

        stream.on('end', function (row) {
          self.statementCount--;
          resolve();
        });
      };

      self.statementCount++;
      connection.execute(options);
    });
  }
}

let connectionManager = new ConnectionManager();
module.exports = connectionManager;
