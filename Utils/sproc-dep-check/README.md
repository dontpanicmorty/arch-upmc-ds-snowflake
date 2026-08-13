# Stored Procedure dep check

- `npm install`
- `node index.js path/to/parent/folder` (you should default to `Scripts`)

Will find all .sql-like files under that point (including .sqlproc), get the DB name and the name of the current object, then find all `CALL ________` calls mentioned within it, and turn them into Mermaid diagrams.

The diagrams are segmented out by DB name and put under the "output" folder under `/Utils/sproc-dep-check`, and can be copied from there into, for example, Wiki pages.
