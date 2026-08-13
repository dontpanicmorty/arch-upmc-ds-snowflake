/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_processing_reason

SELECT 'Updating static data table dimdata.dim_processing_reason';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_processing_reason
(
    DIM_PROCESSING_REASON_KEY INTEGER NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    CODE_POSITION NUMBER(38,0) NOT NULL,
    PROCESSING_REASON_TYPE_CODE VARCHAR NOT NULL,
    PROCESSING_REASON_CODE VARCHAR NOT NULL,
    PROCESSING_REASON_DESC VARCHAR,
    HIPAA_277_CODE VARCHAR,
    HIPAA_835_CODE VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_processing_reason (DIM_PROCESSING_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, CODE_POSITION, PROCESSING_REASON_TYPE_CODE, PROCESSING_REASON_CODE, PROCESSING_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'Unknown', 1,'Unknown','Unknown', NULL, NULL, NULL);
INSERT INTO dimdata.TMP_dim_processing_reason (DIM_PROCESSING_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, CODE_POSITION, PROCESSING_REASON_TYPE_CODE, PROCESSING_REASON_CODE, PROCESSING_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'n/a', 1,'n/a','n/a', NULL, NULL, NULL);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_processing_reason (DIM_PROCESSING_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, CODE_POSITION, PROCESSING_REASON_TYPE_CODE, PROCESSING_REASON_CODE, PROCESSING_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
SELECT tmp.DIM_PROCESSING_REASON_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_TPA_HIERARCHY_KEY, tmp.DATA_SOURCE_NAME, tmp.CODE_POSITION, tmp.PROCESSING_REASON_TYPE_CODE, tmp.PROCESSING_REASON_CODE, tmp.PROCESSING_REASON_DESC, tmp.HIPAA_277_CODE, tmp.HIPAA_835_CODE
FROM dimdata.tmp_dim_processing_reason tmp
    LEFT JOIN dimdata.dim_processing_reason tbl ON tbl.dim_processing_reason_key = tmp.dim_processing_reason_key
WHERE tbl.dim_processing_reason_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_processing_reason live_table
SET
live_table.DIM_PROCESSING_REASON_KEY = tmp.DIM_PROCESSING_REASON_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_TPA_HIERARCHY_KEY = tmp.DIM_TPA_HIERARCHY_KEY,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.CODE_POSITION = tmp.CODE_POSITION,
live_table.PROCESSING_REASON_TYPE_CODE = tmp.PROCESSING_REASON_TYPE_CODE,
live_table.PROCESSING_REASON_CODE = tmp.PROCESSING_REASON_CODE,
live_table.PROCESSING_REASON_DESC = tmp.PROCESSING_REASON_DESC,
live_table.HIPAA_277_CODE = tmp.HIPAA_277_CODE,
live_table.HIPAA_835_CODE = tmp.HIPAA_835_CODE
FROM dimdata.tmp_dim_processing_reason tmp
    WHERE live_table.dim_processing_reason_KEY = tmp.dim_processing_reason_KEY
;

SELECT 'Finished updating static data table dimdata.dim_processing_reason';