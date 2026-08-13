A new file should be put in this folder for each table we're writing. It should export a single function named `handle`, which should take a single parsed XML document as a parameter.

That function can return one of three things:

- `undefined`/`null`/something `false`y, which means nothing is to be written.
- an empty array, which means nothing is to be written.
- an array of arrays, where each sub-array is a set of values to write as a line in the CSV.

Any XPaths should be put in the lookup in `utils.js` so they can be reused across multiple table handlers.
