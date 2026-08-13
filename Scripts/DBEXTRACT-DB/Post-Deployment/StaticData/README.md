# UPMC Snowflake static file loader

Upon deployment, we load metadata to the `util.file_loader_control` table, where files coming in through NiFi/ADF get decomposed into specific patterns so we can crosswalk incoming CSV to internal formats. This procedure is designed to load simple delimited and fixed length files, JSON, and XML with an optional header into the IDAP_LAKE database in Snowflake. It does some basic checks on the file, adds load dates, and writes to `LOGDATA.FILE_LOADER_HISTORY` with a `SUCCESS` or `FAIL` status.

## Dev setup

Development work in Snowflake should be done in your personal database. To create your database, using `IDAP_LAKE`, run the following:

`CALL ADMIN.UTIL.SPU_MAKE_MY_DEV_DB('IDAP_LAKE','PRD'); `

Your database will be named `IDAP_LAKE_LOCAL_<UPMC username>`. Switch to your personal database to test your code there.

### Creating a new file load process

To make a new file load using this procedure, here's a basic checklist of the things that need to be completed:

- Snowflake file format for your file
- DDL for your output table
- Add an entry for your table into `UTIL.FILE_LOADER_CONTROL`
- Make sure your file is going to Azure blob storage. This is currently achieved by having Orchestrator move the file to `/mnt1/data` on `sxipcihy1005` with [these naming conventions](https://dev.azure.com/ITPayerApplications/Data%20Services/_wiki/wikis/Data-Services.wiki/3266/Naming-Conventions?anchor=%3Cins%3Efile-load-naming-conventions-for-snowflake-file-loader%3Cins/%3E) (Snowflake direct file load.) NiFi will pick up the file and call the file loader by breaking the filename apart and passing it as parameters.

### File format

In order to select from a file, Snowflake needs to know what its format is (pipe delimited? tab delimited? header? etc.) These file formats are stored in Snowflake. Create these scripts under `Scripts/IDAP_LAKE_DB/Schemas/$dataDomain/FileFormats`.

**IMPORTANT: if your file has a header, you must create 2 formats, one including the header (SKIP_HEADER = 0) and one with SKIP_HEADER = 1.**

The procedure is designed to check the number and names of the fields on the header, but we don't want to load it into the output table.

![image.png](/.attachments/image-8106e3dd-54b1-4aa1-8a05-9e1fb1f699a6.png)

### DDL

Make a sql script containing the DDL for your table with a comment. This should reside in `Scripts/IDAP_LAKE_DB/Schemas/$dataDomain/Tables`. Use the others as an example and be sure to put a comment explaining what the table is.

**IMPORTANT: you must include the `INSERT_DATETIME` and `FILENAME` columns in your DDL. The stored procedure writes data into these fields. If you're importing a file with `dataType='json'`, you must also include `JSON_DATA VARIANT`. A PK field of <TableName>\_KEY must also be created for a PK CONSTRAINT to be included in DDL. **

![image.png](/.attachments/image-3ef7613c-4486-47be-bb3c-69ee909e2574.png)

## Metadata spec

Each file under the `file_loader` follows a specific pattern:

**Filename**:

- The first three underscore-delimited sections are TPA props. For now, this should always be 000001_000001_0001, as it's a holdover from MarkLogic and we don't really use TPA props here.
- The next underscore-delimited section should be data domain. This is also effectively arbitrary, but it is used for disambiguation purposes.
- The rest of the file is the "unique pattern" and may contain any amount of underscores. Given `000001_000001_0001_network_BPL_RIDER_NETWORK_CROSSWALK.json`, this would be `BPL_RIDER_NETWORK_CROSSWALK`.

We use those five components (three TPA props, domain, unique pattern) to look up what format we're working with. The format is specified in the...

**File mapping options:**:
The JSON files get converted to the `FILE_MAPPING` column in `UTIL.FILE_LOADER_CONTROL`, which supports the following properties:

- `outputSchema` [string]: The schema under which the output table was created. Examples: `PROVIDER`, `MEMBER`.
- `outputTable` [string]: The output table. Examples: `HEALTHPLAN_ID_XWALK`, `QUALTRICS_SURVEY_RESPONSE`.
- `fileType` [string]: Type of the input data. Each has different handlers. Currently supported: `fixed`, `delimited`, `json`, `xml`.
- `hasHeader` [**optional** boolean]: Set to true if the input file is table-like (delimited, fixed) and has a header. Defaults to false.
- `hasTrailer` [**optional** boolean]: Set to true if the input file is table-like (delimited, fixed) and has a trailer. Defaults to false. **Currently unsupported.**
- `fileFormat` [string]: The name of a file format registered under `outputSchema` corresponding to the body input. See parent page for instructions on creating this. Example: `HEALTHPLAN_ID_XWALK_FILE_FORMAT`.
- `headerFormat` [**optional** string]: The name of a file format registered under `outputSchema` corresponding to the header input. See parent page for instructions on creating this. Example: `HEALTHPLAN_ID_XWALK_FILE_FORMAT_HEADER`.
- `truncReload` [boolean]: If truthy, will truncate the table before reloading.

For `fileType`s `fixed` and `delimited`, the following options are supported:

- `mappingTypes` [object]: For right now, all `mappingTypes` must have an immediate `all` child, signifying that all data uses this handler. This is being left in place for files like the ESI deliveries, where a single file could contain multiple formats. `all` must contain a `mappingContents` array of objects with the following properties:
  - `columnOrder` [integer]: 1-indexed column number, because Snowflake doesn't always treat arrays with respect in memory
  - `inputField` [string]: header name from the source file
  - `outputField` [string]: column name in the destination table

For `fileType` json, the following options are supported:

- `jsonBasePath` [string]: Colon-delimited (like Snowflake's `JSON_PATH` syntax) series of levels to traverse to find the objects that should be written to `JSON_DATA` columns.

### Local dev

If you are the kind of person who wants to run this prior to release (and we like those kinds of people), you can run the following block in a PowerShell terminal. It requires `snowsql` to be installed, which should have been included with the repo setup instructions (and we like people who follow those).

```ps1
icm {snowsql @args} -Args @(
  '-a', 'upmchp.east-us-2.azure',  # account name
  '-u', 'USERNAME@upmc.edu', # username, change this
  '-d', 'DATABASE_NAME', # database you're running against, change this
  '-s', 'util', # effectively arbitrary because we scope schema, but better to be safe
  '-r', 'ds_architect_role', # role you're running as, change if needed
  '-w', 'ds_dev_wh', # warehouse you're using, probably don't need to change
  '--authenticator', 'externalbrowser', # will use login info from your default browser, likely Edge
  '--variable', 'buildnumber=123456', # arbitrary, used to create temp tables. can replace 123456 with whatever you want
  '--variable', 'publish_deploy_path=C:\PATH\TO\IDAP_LAKE-DB\Post-Deployment\', # path to your copy of this repo, change this
  '-f', './util.file_loader_control.staticdata.sql', # the file to run
  '-o', 'log_level=DEBUG', '-o', 'echo=true' # debugging options, can remove if you don't want them
)
```

(If you are the kind of person who wants to know why that looks so stupid [and we like those kinds of people], Powershell has atrocious support for splitting long commands over multiple lines, and invoking the module [icm] is actually the easiest way to run that. Go figure.)

## Troubleshooting

### Blob storage

Blob storage for file loads in dev is here:
`azure://snowflakedatadev.blob.core.windows.net/fileloaddata`

You can look for your file in stage for your file by running this:
`LIST @UTIL.SNOWFLAKEDATA_FILELOADDATA PATTERN = 'filename.txt'`

### Loads

Look in the LOGDATA schema of the given database (IDAP_LAKE_DEV / IDAP_LAKE / etc) and find the FILE_LOADER_HISTORY table to see the results of your execution(s) of SPU_FILE_LOADER, including error messages.
![image.png](/.attachments/image-96e888b5-339a-4f28-a19d-6a564b0ded06.png)
