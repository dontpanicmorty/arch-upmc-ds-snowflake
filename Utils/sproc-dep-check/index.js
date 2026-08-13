const fs = require('fs');
const path = require('path');
const {format} = require('prettier');
const parserBabel = require('prettier/parser-babel.js');

// Get input folder
if (process.argv.length === 2) {
  throw new Error(
    `Must specify folder as a command-line parameter. Usage: node index.js path/to/folder`
  );
}

const folder = process.argv[2];

// Prep output folder
const outputFolder = path.join('.', 'output');
if (!fs.existsSync(outputFolder)) {
  fs.mkdirSync(outputFolder);
}

// https://stackoverflow.com/questions/5827612/node-js-fs-readdir-recursive-directory-search
async function* getFiles(dir) {
  const dirents = await fs.readdirSync(dir, {withFileTypes: true});
  for (const dirent of dirents) {
    const res = path.resolve(dir, dirent.name);
    if (dirent.isDirectory()) {
      yield* getFiles(res);
    } else {
      yield res;
    }
  }
}

// Set up the Prettier parser
const myCustomPlugin = {
  parsers: {
    'strip-comments': {
      parse(text) {
        const ast = parserBabel.parsers.babel.parse(text);
        delete ast.comments;
        return ast;
      },
      astFormat: 'estree'
    }
  }
};

const linkCache = {
  // top-level keys are DB names, top-level values are objects:
  // - second-level keys are source of the link
  // - second-level values are arrays of destinations of the link
};

(async function () {
  for await (const file of getFiles(folder)) {
    // These are problematic.
    if (file.endsWith('Publish.sql')) continue;

    // Load each file and see if it calls another sproc. We don't restrict to
    // StoredProcedures folders because a) people could typo and b) tasks can
    // call sprocs
    let content = fs.readFileSync(file).toString();
    if (content.indexOf('CALL ') === -1) continue;

    // To find the DB name from the filepath, because regexes work weird with
    // Windows slashes. This will inevitably error at some point due to someone
    // typoing.
    const scriptsFolder = `Scripts${path.sep}`;
    if (file.indexOf(scriptsFolder) === -1) continue;

    const dbName = file.split(scriptsFolder)[1].split('-')[0].toUpperCase();

    // Look for the local name at the top; skip if there's no `CREATE OR REPLACE`
    const localNameSearch = content.match(
      /CREATE (OR REPLACE)? ([A-Z]+) ([^( ]+)[( ]/
    );
    if (!localNameSearch || localNameSearch.length !== 4) {
      continue;
    }
    const localName = localNameSearch[3].trim();

    // Look for the language before we isolate the actual code
    const langSearch = content.match(/LANGUAGE ([^\s]+)/);

    // Isolate the code
    if (content.indexOf('$$') > -1) content = content.split('$$')[1];

    // If we're in JS, strip comments:
    if (langSearch && langSearch[1].toUpperCase() === 'JAVASCRIPT') {
      content = format(content, {
        parser: 'strip-comments',
        plugins: [myCustomPlugin]
      });
    }
    // Normalize the whitespace
    content = content.replace(/(\s)+/gi, ' ');

    // Look for all `CALL` calls
    const callSearch = content.match(/CALL ([^(]+)/g);
    console.log(callSearch);
    const sprocs = Array.from(new Set(callSearch))
      .map(
        (a) =>
          a
            .replace(/^CALL /, '') // Remove the `CALL` bit
            .toUpperCase() // Normalize
            .replace(dbName + '.', '') // Remove this DB identifier
            .replace(/&\{(.*)\}/g, '$1_*') // Replace `&{IDAP_LAKE}` with `IDAP_LAKE_*` for clarity
      )
      .sort(); // alphabetize

    console.log(`${file}: found ${sprocs.length} unique dependencies.`);

    // Put alphabetically-sorted lists of deps in the cache
    if (!(dbName in linkCache)) linkCache[dbName] = {};
    const dbCache = linkCache[dbName];

    // If we already have this localName in, it likely means it's a signature
    // override. In that case, append the list of things and re-sort
    if (localName in dbCache) {
      dbCache[localName] = Array.from(
        new Set(dbCache[localName].concat(sprocs))
      ).sort();
    }

    // Otherwise, seed the array; we've already sorted it
    else dbCache[localName] = sprocs;
  }

  // For each DB
  for (const db in linkCache) {
    // Set up the graph
    const outputContent = [`::: mermaid`, 'graph LR;'];

    // Append all the links
    for (const src in linkCache[db]) {
      for (const dest of linkCache[db][src])
        outputContent.push(`${src} --> ${dest}`);
    }

    // Close the graph
    outputContent.push(':::');

    // Write a file
    fs.writeFileSync(
      path.join(outputFolder, db + '.mermaid'),
      outputContent.join('\n')
    );
  }
})();
