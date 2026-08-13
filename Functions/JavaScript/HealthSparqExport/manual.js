const {process} = require('./src/main.js');
const {resetConfig} = require('./src/config.js');

(async function () {
  resetConfig(); // because Functions is weird and maintains values
  await process();
})();
