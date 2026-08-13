const nodemailer = require('nodemailer');

module.exports = async function (context, req) {
  try {
    // create reusable transporter object using the default SMTP transport
    let mailTransport = nodemailer.createTransport({
      host: 'smtprelay.upmc.edu',
      port: 25,
      secure: false // true for 465, false for other ports
    });

    // Because ADF doesn't handle JSON objects that cleanly and sometimes sends them
    // in very string-ey ways despite HTTP headers, make sure it's parsed into JSON
    if (typeof req.body === 'string') {
      try {
        req.body = JSON.parse(req.body);
      } catch (err) {
        context.res = {
          status: 400,
          body: `Request body was not valid JSON: ${req.body}`
        };
        return;
      }
    }

    let {env, nodemailerConfig} = req.body;

    const errors = [];
    // Must have `env`
    if (!env || typeof env !== 'string') {
      errors.push(
        'env parameter must exist as a string, and should be proxied from ADF_ENV global parameter.'
      );
    }
    // Must have `to`
    if (!nodemailerConfig.to) {
      errors.push(`to parameter must exist.`);
    }
    // Must have replyTo
    if (
      !nodemailerConfig.replyTo ||
      typeof nodemailerConfig.replyTo !== 'string'
    ) {
      errors.push('replyTo parameter must exist as a string.');
    }
    // Must have subject
    if (
      !nodemailerConfig.subject ||
      typeof nodemailerConfig.subject !== 'string'
    ) {
      errors.push('subject parameter must exist as a string.');
    }
    // Must have either `text` or `html`
    if (
      !(
        (nodemailerConfig.text && typeof nodemailerConfig.text === 'string') ||
        (nodemailerConfig.html && typeof nodemailerConfig.html === 'string')
      )
    ) {
      errors.push('text or html parameter must exist as a string.');
    }
    // Must not have `from`
    if (nodemailerConfig.from) {
      errors.push('`from` will be overwritten, use `replyTo` instead.');
    }

    // If any errors were generated, return them and stop
    if (errors.length > 0) {
      context.res = {
        status: 400,
        body:
          'Please fix the following errors and try again:\n  ' +
          errors.join('\n  ')
      };
      return;
    }

    // Take out the env
    env = env.toLowerCase();

    // Set up a standard email address
    nodemailerConfig.from = [
      {
        name: `Data Solutions ADF (${env})`,
        address: `hp-ds-adf-${env}@upmc.edu`
      }
    ];

    // If we're in prod, CC the IDAPAdmins address
    if (env === 'prd') {
      nodemailerConfig.cc = 'IDAPAdmins@upmc.edu';
    }

    try {
      const info = await new Promise((resolve, reject) => {
        mailTransport.sendMail(nodemailerConfig, function (err, info) {
          context.log(err, info);
          if (err) {
            reject(err);
          }

          resolve(info);
        });
      });

      context.res = {
        status: 200,
        body: info.response
      };
    } catch (err) {
      context.log(err);
      context.res = {
        status: 400,
        body: 'Nodemailer returned the following error: ' + err.message
      };
    }
  } catch (err) {
    context.log(err);
    context.res = {
      status: 500,
      body: 'Internal error: ' + JSON.stringify(err)
    };
  }
};
