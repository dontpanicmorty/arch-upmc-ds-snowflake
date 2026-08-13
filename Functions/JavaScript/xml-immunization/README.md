# CCHIE HL7 ingest script

This is currently a one-off script used for converting XML files to CSV by running specific XPaths on them, transpiled from T-SQL. It's a bit annoying to do in Snowflake, so we set it up in JS to be pivoted to Azure Functions. Project was spearheaded by Akira, and Eric Howard knows a bit more detail on it as well, if clarification is needed.

To run:

- `npm install`
- `node index.js --folder path/to/folder`

Any XML files (or XML files in ZIP files) anywhere recursively under path/to/folder will be processed, with one output CSV under `/Utils/xml-immunization/output/` being created per ZIP/orphan XML. Those CSVs can then be loaded into whatever table Eric created. Check the call to `writeLine` for what the columns in the CSV are.

### Dev notes

The base NodeJS `xpath` module only supports XPath 1.0 and is a bit glitchy, so we use FontoXML's module instead, which supports 3.1. Andrew's worked directly with Fonto in the past and trusts them to maintain that module well and in a generic way, so don't worry about it having fewer overall downloads.
