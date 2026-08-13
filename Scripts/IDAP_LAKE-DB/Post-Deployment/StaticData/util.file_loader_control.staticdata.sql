/***************************************
***   Static data management script  ***
***************************************/
!set variable_substitution=true;

-- This script will manage the static data for util.file_loader_control

SELECT 'Updating static data table util.file_loader_control';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE UTIL.TMP_FILE_LOADER_CONTROL
(
    FILE_LOADER_CONTROL_KEY INTEGER,
    TPA_CLIENT_ID VARCHAR NOT NULL,
    TPA_ID VARCHAR NOT NULL,
    TPA_DIV_ID VARCHAR NOT NULL,
    DATA_DOMAIN VARCHAR NOT NULL,
    UNIQUE_FILENAME_PATTERN VARCHAR NOT NULL,
    FILE_MAPPING VARIANT NOT NULL
)
;

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.

-- Because of how much data we keep in the file_loader, this is a bit of an
-- exception. Commands below documented inline.
--------

-- Create a temp stage for this build
!define stage_name=UTIL.FILE_LOADER_STAGE_&buildnumber;
CREATE OR REPLACE TEMPORARY STAGE &stage_name
    -- Uses the JSON format so we can call `parse_json` without issue
    FILE_FORMAT = UTIL.FILE_LOADER_FILE_FORMAT;

-- PUT (copy from local to stage) all JSON files under the `file_loader` folder
-- If you're running this manually, use `--variable drop_file_location=C:\PATH\TO\IDAP_LAKE-DB\Post-Deployment\`
PUT file:///&drop_file_location\StaticData\file_loader\*.json
    @&stage_name
    AUTO_COMPRESS = false 
    OVERWRITE = true;


-- Copy stuff out of the temp stage into the temp table, so we can continue as normal
INSERT INTO util.tmp_file_loader_control (
    TPA_CLIENT_ID,
    TPA_ID,
    TPA_DIV_ID,
    DATA_DOMAIN,
    UNIQUE_FILENAME_PATTERN,
    FILE_MAPPING 
)
-- Split filenames into components
SELECT SPLIT_FILENAME[0] AS TPA_CLIENT_ID,
    SPLIT_FILENAME[1] AS TPA_ID,
    SPLIT_FILENAME[2] AS TPA_DIV_ID,
    SPLIT_FILENAME[3] AS DATA_DOMAIN,
    -- Breathe, it's not too complicated
    REPLACE(
        ARRAY_TO_STRING(
            ARRAY_SLICE(
                -- Take everything after the 4th section (data_domain)
                SPLIT_FILENAME, 
                4, 
                ARRAY_SIZE(SPLIT_FILENAME)
            ),
            -- Rejoin all the components on `_` to recreate all underscores in the pattern component
            '_'
        ),
        -- Remove the extension
        '.json',
        ''
    ) AS UNIQUE_FILENAME_PATTERN,
    FILE_MAPPING
FROM (
    -- Internal table to not have to call SPLIT seven times
    SELECT SPLIT(METADATA$FILENAME, '_') AS SPLIT_FILENAME, 
        PARSE_JSON($1) AS FILE_MAPPING
    FROM @&stage_name
);

-- Remove the stage now that we've unloaded from it
DROP STAGE &stage_name;

-- 3: Insert any new items into the table from the table variable
INSERT INTO UTIL.FILE_LOADER_CONTROL (
    TPA_CLIENT_ID,
    TPA_ID,
    TPA_DIV_ID,
    DATA_DOMAIN,
    UNIQUE_FILENAME_PATTERN,
    FILE_MAPPING) 
SELECT 
    tmp.TPA_CLIENT_ID,
    tmp.TPA_ID,
    tmp.TPA_DIV_ID,
    tmp.DATA_DOMAIN,
    tmp.UNIQUE_FILENAME_PATTERN,
    tmp.FILE_MAPPING
FROM UTIL.TMP_FILE_LOADER_CONTROL tmp
    LEFT JOIN UTIL.FILE_LOADER_CONTROL tbl 
    ON 
    tmp.TPA_CLIENT_ID = tbl.TPA_CLIENT_ID 
    AND tmp.TPA_ID = tbl.TPA_ID 
    AND tmp.TPA_DIV_ID = tbl.TPA_DIV_ID 
    AND tmp.DATA_DOMAIN = tbl.DATA_DOMAIN 
    AND tmp.UNIQUE_FILENAME_PATTERN = tbl.UNIQUE_FILENAME_PATTERN 
WHERE tbl.FILE_LOADER_CONTROL_KEY IS NULL
;

-- 4: Update any modified values with the values from the table variable
UPDATE UTIL.FILE_LOADER_CONTROL Live_table
SET
    live_table.FILE_MAPPING = tmp.FILE_MAPPING
FROM UTIL.TMP_FILE_LOADER_CONTROL tmp
    WHERE 
    live_table.TPA_CLIENT_ID = tmp.TPA_CLIENT_ID
    AND live_table.TPA_ID = tmp.TPA_ID
    AND live_table.TPA_DIV_ID = tmp.TPA_DIV_ID
    AND live_table.DATA_DOMAIN = tmp.DATA_DOMAIN
    AND live_table.UNIQUE_FILENAME_PATTERN = tmp.UNIQUE_FILENAME_PATTERN
;

SELECT 'Finished updating static data table UTIL.FILE_LOADER_CONTROL.';
!set variable_substitution=false;