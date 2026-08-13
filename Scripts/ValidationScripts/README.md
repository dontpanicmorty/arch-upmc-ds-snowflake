# Validation Scripts folder

Currently only the CodeReview setup.

## CodeReview/Setup.sql

The main `CodeReview.sql` file contains a series of tests that each validate a different style convention with regards to naming DB objects, columns, and constraints. The `CodeReviewSetup.sql` file automatically loads all objects we could be testing, with a generalized set of columns, and considers specific inclusions/exceptions to the process.Each subsection here describes a piece of maintenance that you may have been tasked with completing.

If you are the kind of person who wants to run this prior to the automated PR validation (and we like those kinds of people), you can run the following block in a PowerShell terminal. It requires `snowsql` to be installed, which should have been included with the repo setup instructions (and we like people who follow those).

```ps1
icm {snowsql @args} -Args @(
  '-a', 'upmchp.east-us-2.azure',  # account name
  '-u', 'USERNAME@upmc.edu', # username, change this
  '-d', 'DATABASE_NAME', # database you're running against, change this
  '-s', 'public', # schema in which the temp structures will be created, arbitrary because every object is temporary
  '-r', 'ds_architect_role', # role you're running as, change if needed
  '-w', 'ds_dev_wh', # warehouse you're using, probably don't need to change
  '--authenticator', 'externalbrowser', # will use login info from your default browser, likely Edge
  '--variable', 'buildnumber=123456', # arbitrary, used to create temp tables. can replace 123456 with whatever you want
  '--variable', 'workinglocation=C:\PATH\TO\Snowflake', # path to your copy of this repo, change this
  '-f', './CodeReview.sql', # file to run, the main code review script
  '-o', 'log_level=DEBUG', '-o', 'echo=true' # debugging options, can remove if you don't want them
)
```

(If you are the kind of person who wants to know why that looks so stupid [and we like those kinds of people], Powershell has atrocious support for splitting long commands over multiple lines, and invoking the module [icm] is actually the easiest way to run that. Go figure.)

### Maintaining CodeReviewSetup.sql

There's a lot of complex code in there, but the idea is:

- Get the full list of objects from the DB, and map them to `[CATALOG].[SCHEMA].[NAME]` strings.
- By default, use a `%.%.%` rule to include specific objects, or use `%`-based patterns from the `rules/*/includes` folders to specify which catalogs/schemas/objects we want to include; include any object that matches any pattern.
- Use `%`-based patterns from the `rules/*/excludes` folders to specify which catalogs/schemas/objects we want to exclude; exclude any object that matches any pattern.
- Use the `FILTERED_OBJECTS_VW` view to get all combinations of rules and objects, then restrict down to "for a given rule, which objects match the inclusion patterns and do not match the exclusion patterns."

The code is fairly deeply commented in-line, and looks far more complex than it actually is. The goal was to keep this solely in SQL to avoid having to dump a stored procedure somewhere or rely on an external script for code reviews.

### Adding a new rule for CodeReviewSetup.sql to ingest

Rules can either be _inclusions_, specifying which catalogs/schemas/objects a test should apply to, or _exclusions_, specifying which catalogs/schemas/objects a test should not apply to. By default, if no inclusion rules are specified, the code review script will default to including anything that matches `%.%.%`, and will default to no exclusions, so all objects will be processed.

The folder structure is entirely arbitrary and is solely for cleanliness' sake. If you add more rules, it'd be better if you followed the following conventions, though they're _technically_ not necessary:

- Top-level folders should be prefixed with the test index and contain a description of the rule.
- Second-level folders should be "include" or "exclude" and only contain rules of those types.
  - **NOTE:** if you don't do second-level folders, the PUT command will fail because it doesn't support glob patterns yet, but there's a feature request in with Snowflake for this.
- Individual rule filenames should be prefixed with "include" or "exclude" and contain a description of what is being included/excluded.

Each file **must** have the following properties:

```json
{
  "CATALOG_PATTERN": "database name, supports % as wildcard",
  "SCHEMA_PATTERN": "schema name, supports % as wildcard",
  "OBJECT_PATTERN": "object name (table, procedure, etc.), supports % as wildcard",
  "TEST_INDEX": 1, // Integer referring to the test index as enumerated in CodeReview.sql
  "INCLUDE": 1 // If set to 1, things matching this pattern will be tested; if set to 0, things matching this pattern will not be tested
}
```

For example, if you added a new test that you specifically wanted to apply to only the `FAKE_SCHEMA` schema, but not the `FAKE_TABLE` table, you'd add two files. Because there is an `include` rule, we will use it instead of the default `%.%.%` pattern, and it'll only return objects in `FAKE_SCHEMA`. The `FAKE_TABLE` object name will then be excluded if one is found inside `FAKE_SCHEMA`.

```json
{
  "CATALOG_PATTERN": "%",
  "SCHEMA_PATTERN": "FAKE_SCHEMA",
  "OBJECT_PATTERN": "%",
  "TEST_INDEX": 999,
  "INCLUDE": 1
}
```

```json
{
  "CATALOG_PATTERN": "%",
  "SCHEMA_PATTERN": "%",
  "OBJECT_PATTERN": "FAKE_TABLE",
  "TEST_INDEX": 999,
  "INCLUDE": 0
}
```

### Adding a new test to CodeReview.sql

- Describe it with a comment starting with `Test N:`, referred to in this documentation as the "test index."
- Update the `test_count` variable at the top of the script to be the largest test index.
- Ensure that the objects you're testing against (tables, procedures, constraints, etc.) are included in the `FILTERED_OBJECTS_VW` view from `CodeReviewSetup.sql`.
  - If your tests relies on something that is not the object catalog/schema/name, follow the pattern from test 1 where we join back to `INFORMATION_SCHEMA.TABLES` to get the `COMMENT` column.
- For each object that does not pass the test you're writing, `INSERT` a new row into `CODE_REVIEW_LOG_TMP` using the same strategy as the other tests, with a `FIX` column describing what should be done to make the object pass the test.
