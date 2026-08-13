# SendEmail function

It's a proxy to Nodemailer. That's it. Takes a JSON object with two properties:

- `env`: the ADF_ENV value, `DEV`/`TST`/`PRD`; the user/fake email reflects which environment it was sent from, and if it's `PRD`, the IDAPAdmins email group gets copied.
- `nodemailerConfig`: use [these docs](https://nodemailer.com/message/) to determine how you should be formatting what you send.

There's a ton of formatting checks in the function that'll make sure you're doing things correctly, and worst case you get a proxied error from Nodemailer showing what you did wrong. You'll likely be using this from ADF, which means it'll auto-populate the `env` unless you want something for debugging.

If you're running it manually in ADF, you're gonna want the default value for Env, and something like this for `nodemailerConfig`:

```json
{
  "to": "horwitzar@upmc.edu",
  "replyTo": "horwitzar@upmc.edu",
  "subject": "Test email",
  "text": "Test text"
}
```
