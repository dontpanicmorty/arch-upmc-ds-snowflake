/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_data_source

SELECT 'Updating static data table dimdata.dim_data_source';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_data_source
(
    DIM_DATA_SOURCE_KEY INTEGER NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    DATA_SOURCE_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_data_source (DIM_DATA_SOURCE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DATA_SOURCE_NAME, DATA_SOURCE_DESC)
    VALUES (1,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 'Unknown', NULL);
INSERT INTO dimdata.TMP_dim_data_source (DIM_DATA_SOURCE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DATA_SOURCE_NAME, DATA_SOURCE_DESC)
    VALUES (2,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 'n/a', NULL);	

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_data_source (DIM_DATA_SOURCE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DATA_SOURCE_NAME, DATA_SOURCE_DESC)
SELECT tmp.DIM_DATA_SOURCE_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DATA_SOURCE_NAME, tmp.DATA_SOURCE_DESC
FROM dimdata.tmp_dim_data_source tmp
    LEFT JOIN dimdata.dim_data_source tbl ON tbl.dim_data_source_key = tmp.dim_data_source_key
WHERE tbl.dim_data_source_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_data_source live_table
SET
live_table.DIM_DATA_SOURCE_KEY = tmp.DIM_DATA_SOURCE_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.DATA_SOURCE_DESC = tmp.DATA_SOURCE_DESC
FROM dimdata.tmp_dim_data_source tmp
    WHERE live_table.dim_data_source_KEY = tmp.dim_data_source_KEY
;

SELECT 'Finished updating static data table dimdata.dim_data_source';