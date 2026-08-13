/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_PROVIDER_TAXONOMY

SELECT 'Updating static data table dimdata.DIM_PROVIDER_TAXONOMY';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_PROVIDER_TAXONOMY
(DIM_PROVIDER_TAXONOMY_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN DEFAULT FALSE NOT NULL,
    TAXONOMY_CODE VARCHAR NOT NULL,
    TAXONOMY_TYPE VARCHAR,
    TAXONOMY_CLASS VARCHAR,
    TAXONOMY_SPECIALIZATION VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.tmp_DIM_PROVIDER_TAXONOMY (DIM_PROVIDER_TAXONOMY_KEY,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
TAXONOMY_CODE,
TAXONOMY_TYPE ,
TAXONOMY_CLASS,
TAXONOMY_SPECIALIZATION
)
    VALUES (1,
CURRENT_TIMESTAMP(),
CURRENT_TIMESTAMP(),
'False',
'Unknown',
NULL,
NULL,
NULL
);
INSERT INTO dimdata.tmp_DIM_PROVIDER_TAXONOMY (DIM_PROVIDER_TAXONOMY_KEY,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
TAXONOMY_CODE,
TAXONOMY_TYPE ,
TAXONOMY_CLASS,
TAXONOMY_SPECIALIZATION
)
    VALUES (2,
CURRENT_TIMESTAMP(),
CURRENT_TIMESTAMP(),
'False',
'n/a',
NULL,
NULL,
NULL
);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_PROVIDER_TAXONOMY (DIM_PROVIDER_TAXONOMY_KEY,
INSERT_DATETIME,
LAST_UPDATED_DATETIME,
IS_LOGICAL_DELETE_FLAG,
TAXONOMY_CODE,
TAXONOMY_TYPE ,
TAXONOMY_CLASS,
TAXONOMY_SPECIALIZATION)

SELECT tmp.DIM_PROVIDER_TAXONOMY_KEY,
tmp.INSERT_DATETIME,
tmp.LAST_UPDATED_DATETIME,
tmp.IS_LOGICAL_DELETE_FLAG,
tmp.TAXONOMY_CODE,
tmp.TAXONOMY_TYPE ,
tmp.TAXONOMY_CLASS,
tmp.TAXONOMY_SPECIALIZATION
FROM dimdata.tmp_DIM_PROVIDER_TAXONOMY tmp
    LEFT JOIN dimdata.DIM_PROVIDER_TAXONOMY tbl ON tbl.DIM_PROVIDER_TAXONOMY_key = tmp.DIM_PROVIDER_TAXONOMY_key
WHERE tbl.DIM_PROVIDER_TAXONOMY_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.DIM_PROVIDER_TAXONOMY live_table
SET
live_table.DIM_PROVIDER_TAXONOMY_KEY = tmp.DIM_PROVIDER_TAXONOMY_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.TAXONOMY_CODE = tmp.TAXONOMY_CODE,
live_table.TAXONOMY_TYPE = tmp.TAXONOMY_TYPE,
live_table.TAXONOMY_CLASS = tmp.TAXONOMY_CLASS,
live_table.TAXONOMY_SPECIALIZATION = tmp.TAXONOMY_SPECIALIZATION

FROM dimdata.tmp_DIM_PROVIDER_TAXONOMY tmp
    WHERE live_table.DIM_PROVIDER_TAXONOMY_KEY = tmp.DIM_PROVIDER_TAXONOMY_KEY
;

SELECT 'Finished updating static data table STAGEDATA.DIM_PROVIDER_TAXONOMY';