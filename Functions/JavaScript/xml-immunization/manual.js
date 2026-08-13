const {resetConfig} = require('./src/config.js');

(async function () {
  resetConfig(); // because Functions is weird and maintains values
  const {process} = require('./src/main.js');
  await process();
})();
