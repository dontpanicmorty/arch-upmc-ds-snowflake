/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_PROVIDER_IDENTIFIER

SELECT 'Updating static data table dimdata.DIM_PROVIDER_IDENTIFIER';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_PROVIDER_IDENTIFIER
(DIM_PROVIDER_IDENTIFIER_KEY INTEGER NOT NULL , 
MD5_VALUE_TEXT VARCHAR NOT NULL,
INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL, 
LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL, 
IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
DIM_PROVIDER_KEY INTEGER NOT NULL, 
IDENTIFIER_NAME VARCHAR NOT NULL, 
IDENTIFIER_NBR VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.tmp_DIM_PROVIDER_IDENTIFIER (
DIM_PROVIDER_IDENTIFIER_KEY,
MD5_VALUE_TEXT,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
DIM_PROVIDER_KEY,
IDENTIFIER_NAME, 
IDENTIFIER_NBR
)
VALUES (
1,
'Unknown',
CURRENT_TIMESTAMP(),
CURRENT_TIMESTAMP(),
FALSE,
1,
'Unknown',
'Unknown'
)
;

INSERT INTO dimdata.tmp_DIM_PROVIDER_IDENTIFIER (
DIM_PROVIDER_IDENTIFIER_KEY,
MD5_VALUE_TEXT,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
DIM_PROVIDER_KEY,
IDENTIFIER_NAME, 
IDENTIFIER_NBR
)
VALUES (
2,
'n/a',
CURRENT_TIMESTAMP(),
CURRENT_TIMESTAMP(),
FALSE,
1,
'n/a',
'n/a'
)
;

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_PROVIDER_IDENTIFIER (
DIM_PROVIDER_IDENTIFIER_KEY,
MD5_VALUE_TEXT,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
DIM_PROVIDER_KEY,
IDENTIFIER_NAME, 
IDENTIFIER_NBR
)

SELECT tmp.DIM_PROVIDER_IDENTIFIER_KEY,
tmp.MD5_VALUE_TEXT,
tmp.INSERT_DATETIME,
tmp.LAST_UPDATED_DATETIME,
tmp.IS_LOGICAL_DELETE_FLAG,
tmp.DIM_PROVIDER_KEY,
tmp.IDENTIFIER_NAME, 
tmp.IDENTIFIER_NBR
FROM dimdata.tmp_DIM_PROVIDER_IDENTIFIER tmp
    LEFT JOIN dimdata.DIM_PROVIDER_IDENTIFIER tbl ON tbl.DIM_PROVIDER_IDENTIFIER_key = tmp.DIM_PROVIDER_IDENTIFIER_key
WHERE tbl.DIM_PROVIDER_IDENTIFIER_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.DIM_PROVIDER_IDENTIFIER live_table
SET
live_table.DIM_PROVIDER_IDENTIFIER_KEY = tmp.DIM_PROVIDER_IDENTIFIER_KEY,
live_table.MD5_VALUE_TEXT = tmp.MD5_VALUE_TEXT,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_PROVIDER_KEY = tmp.DIM_PROVIDER_KEY,
live_table.IDENTIFIER_NAME = tmp.IDENTIFIER_NAME,
live_table.IDENTIFIER_NBR = tmp.IDENTIFIER_NBR

FROM dimdata.tmp_DIM_PROVIDER_IDENTIFIER tmp
    WHERE live_table.DIM_PROVIDER_IDENTIFIER_KEY = tmp.DIM_PROVIDER_IDENTIFIER_KEY
;

SELECT 'Finished updating static data table STAGEDATA.DIM_PROVIDER_IDENTIFIER';