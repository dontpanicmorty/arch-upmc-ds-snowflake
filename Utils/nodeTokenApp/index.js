const fs = require('fs');
const express = require('express');
const app = express();

// Don't change this - greenlit in app registration as a page we can request
// tokens from. If you're running MarkLogic at the same time, consider using the
// oauthToken service, or stop the Docker image for the meantime.
const port = 8012;

const page = fs.readFileSync('./getToken.html');
app.get('/', (req, res) => {
  res.setHeader('Content-Type', 'text/html')
  res.send(page)
})

app.listen(port, () => {
  console.log(`App listening. Navigate to http://localhost:${port}/ in your browser.`)
})