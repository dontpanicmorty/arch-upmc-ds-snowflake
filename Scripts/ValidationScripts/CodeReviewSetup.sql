/*
SQL used to set up temporary structures/data needed for the main code review
script. This has been broken out just for cleanliness' sake, and should not
need to be touched given the new JSON structure for specifying rule inclusions/
exclusions.
*/

-- Exceptions table
CREATE OR REPLACE TEMPORARY TABLE CODE_REVIEW_EXCEPTIONS (
    CATALOG_PATTERN VARCHAR,
    SCHEMA_PATTERN VARCHAR,
    OBJECT_PATTERN VARCHAR,
    TEST_INDEX NUMBER NOT NULL,
    INCLUDE TINYINT NOT NULL
);

-- Create a temp stage for this build
!define stage_name=CODE_REVIEW_STAGE_&build_number;
CREATE OR REPLACE TEMPORARY STAGE &stage_name
    -- Inline JSON format so we can call `parse_json` without issue
    FILE_FORMAT = (
        TYPE = JSON,
        COMPRESSION = NONE
    );

-- PUT (copy from local to stage) all JSON files under the `file_loader` folder
PUT file:///&reporoot\Scripts\ValidationScripts\rules\*\*\*.json
    @&stage_name
    AUTO_COMPRESS = false 
    OVERWRITE = true;

-- Copy data from the loaded JSON into the exceptions table
INSERT INTO CODE_REVIEW_EXCEPTIONS (CATALOG_PATTERN, SCHEMA_PATTERN, OBJECT_PATTERN, TEST_INDEX, INCLUDE)
    SELECT $1:CATALOG_PATTERN, $1:SCHEMA_PATTERN, $1:OBJECT_PATTERN, $1:TEST_INDEX, $1:INCLUDE
    FROM @&stage_name;

-- Drop the stage
DROP STAGE &stage_name;

-- Makes fully-qualified patterns from all include exceptions, defaulting to 
-- '%.%.%' when nothing is specified
CREATE OR REPLACE TEMPORARY VIEW CONFIG_INCLUDE_VW AS (
    -- If a pattern has been specified for the test index, we use that, otherwise
    -- default to `%.%.%` ("include all") if nothing is specified
    SELECT COALESCE(CODE_REVIEW_EXCEPTIONS.PATTERN, '%.%.%') AS PATTERN,
        1 AS INCLUDE,
        ALL_INDEXES.TEST_INDEX AS TEST_INDEX
    
    -- Start with a table that has a row per possible TEST_INDEX, specified
    -- using the `test_count` variable from the top of the parent script
    FROM (
        SELECT seq4() AS TEST_INDEX 
        FROM TABLE(GENERATOR(ROWCOUNT => &test_count))
    ) ALL_INDEXES

    -- Then, join in the JSON rules we got from the folder. The COALESCEs above
    -- will take these values if they exist
    LEFT JOIN
    (
        SELECT CONCAT(CATALOG_PATTERN, '.', SCHEMA_PATTERN, '.', OBJECT_PATTERN) AS PATTERN,
            TEST_INDEX
        FROM CODE_REVIEW_EXCEPTIONS
        WHERE INCLUDE = 1
    ) CODE_REVIEW_EXCEPTIONS ON ALL_INDEXES.TEST_INDEX = CODE_REVIEW_EXCEPTIONS.TEST_INDEX
    ORDER BY TEST_INDEX
);

-- Makes fully-qualified patterns from all exclude exceptions. Much easier
-- because we don't have to worry about default values.
CREATE OR REPLACE TEMPORARY VIEW CONFIG_EXCLUDE_VW AS (
    SELECT CONCAT(CATALOG_PATTERN, '.', SCHEMA_PATTERN, '.', OBJECT_PATTERN) AS PATTERN,
        INCLUDE,
        TEST_INDEX
    FROM CODE_REVIEW_EXCEPTIONS
    WHERE INCLUDE = 0
);

-- Filters tables by what should be included/excluded, using the above
CREATE OR REPLACE TEMPORARY VIEW FILTERED_OBJECTS_VW AS (
    SELECT OBJECT_SCHEMA,
        OBJECT_NAME,
        OBJECT_TYPE,
        CONFIG_INCLUDE_VW.TEST_INDEX,   

        -- Make a fully qualified version of the object name that we can match against...     
        CONCAT(OBJECT_CATALOG, '.', OBJECT_SCHEMA, '.', OBJECT_NAME) AS FULLY_QUALIFIED_TABLE_NAME,

        -- ...the patterns from the two views above. If anything matches, it's 
        -- included or excluded, hence we...
        MAX(CASE WHEN FULLY_QUALIFIED_TABLE_NAME LIKE CONFIG_INCLUDE_VW.PATTERN THEN 1 ELSE 0 END) AS INCLUDE_TABLE,
        MAX(CASE WHEN FULLY_QUALIFIED_TABLE_NAME LIKE CONFIG_EXCLUDE_VW.PATTERN THEN 1 ELSE 0 END) AS EXCLUDE_TABLE
    FROM (
        SELECT TABLE_CATALOG AS OBJECT_CATALOG,
            TABLE_SCHEMA AS OBJECT_SCHEMA,
            TABLE_NAME AS OBJECT_NAME,
            TABLE_TYPE AS OBJECT_TYPE
        FROM INFORMATION_SCHEMA.TABLES
        UNION
        SELECT CONSTRAINT_CATALOG AS OBJECT_CATALOG,
            CONSTRAINT_SCHEMA AS OBJECT_SCHEMA,
            CONSTRAINT_NAME AS OBJECT_NAME,
            'REFERENTIAL_CONSTRAINT' AS OBJECT_TYPE
        FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
        UNION
        SELECT FUNCTION_CATALOG AS OBJECT_CATALOG,
            FUNCTION_SCHEMA AS OBJECT_SCHEMA,
            FUNCTION_NAME AS OBJECT_NAME,
            'FUNCTION' AS OBJECT_TYPE
        FROM INFORMATION_SCHEMA.FUNCTIONS
        UNION
        SELECT PROCEDURE_CATALOG AS OBJECT_CATALOG,
            PROCEDURE_SCHEMA AS OBJECT_SCHEMA,
            PROCEDURE_NAME AS OBJECT_NAME,
            'PROCEDURE' AS OBJECT_TYPE
        FROM INFORMATION_SCHEMA.PROCEDURES
    ) OBJECTS
    -- ...Cartesian join everything in (on a given rule), and...
    LEFT JOIN CONFIG_INCLUDE_VW ON 1=1
    -- TODO: can this AND be removed?
    LEFT JOIN CONFIG_EXCLUDE_VW ON 1=1 AND CONFIG_INCLUDE_VW.TEST_INDEX = CONFIG_EXCLUDE_VW.TEST_INDEX

    -- ...group by the all components we need from the base table...
    GROUP BY OBJECT_SCHEMA, OBJECT_NAME, OBJECT_TYPE,
        CONFIG_INCLUDE_VW.TEST_INDEX, 
        FULLY_QUALIFIED_TABLE_NAME

    -- ...and find the things that have any inclusion and no exclusions.
    HAVING INCLUDE_TABLE = 1 AND EXCLUDE_TABLE = 0
);
