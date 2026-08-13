/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_not_covered_reason

SELECT 'Updating static data table dimdata.dim_not_covered_reason';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_not_covered_reason
(
    DIM_NOT_COVERED_REASON_KEY INTEGER NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    NOT_COVERED_REASON_CODE VARCHAR NOT NULL,
    NOT_COVERED_REASON_TYPE VARCHAR NOT NULL,
    LINE_OF_BUSINESS_CODE VARCHAR NOT NULL,
    NOT_COVERED_REASON_DESC VARCHAR,
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
INSERT INTO dimdata.tmp_dim_not_covered_reason (DIM_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, NOT_COVERED_REASON_CODE, NOT_COVERED_REASON_TYPE, LINE_OF_BUSINESS_CODE, NOT_COVERED_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'Unknown', 'Unknown','Unknown', 'Unknown', NULL, NULL, NULL);
INSERT INTO dimdata.tmp_dim_not_covered_reason (DIM_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, NOT_COVERED_REASON_CODE, NOT_COVERED_REASON_TYPE, LINE_OF_BUSINESS_CODE, NOT_COVERED_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'n/a', 'n/a','n/a','n/a', NULL, NULL, NULL);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_not_covered_reason (DIM_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, NOT_COVERED_REASON_CODE, NOT_COVERED_REASON_TYPE, LINE_OF_BUSINESS_CODE, NOT_COVERED_REASON_DESC, HIPAA_277_CODE, HIPAA_835_CODE)
SELECT tmp.DIM_NOT_COVERED_REASON_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_TPA_HIERARCHY_KEY, tmp.DATA_SOURCE_NAME, tmp.NOT_COVERED_REASON_CODE, tmp.NOT_COVERED_REASON_TYPE,  tmp.LINE_OF_BUSINESS_CODE, tmp.NOT_COVERED_REASON_DESC, tmp.HIPAA_277_CODE, tmp.HIPAA_835_CODE
FROM dimdata.tmp_dim_not_covered_reason tmp
    LEFT JOIN dimdata.dim_not_covered_reason tbl ON tbl.DIM_NOT_COVERED_REASON_KEY = tmp.DIM_NOT_COVERED_REASON_KEY
WHERE tbl.DIM_NOT_COVERED_REASON_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_not_covered_reason live_table
SET
live_table.DIM_NOT_COVERED_REASON_KEY = tmp.DIM_NOT_COVERED_REASON_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_TPA_HIERARCHY_KEY = tmp.DIM_TPA_HIERARCHY_KEY,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.NOT_COVERED_REASON_CODE = tmp.NOT_COVERED_REASON_CODE,
live_table.NOT_COVERED_REASON_TYPE = tmp.NOT_COVERED_REASON_TYPE,
live_table.LINE_OF_BUSINESS_CODE = tmp.LINE_OF_BUSINESS_CODE,
live_table.NOT_COVERED_REASON_DESC = tmp.NOT_COVERED_REASON_DESC,
live_table.HIPAA_277_CODE = tmp.HIPAA_277_CODE,
live_table.HIPAA_835_CODE = tmp.HIPAA_835_CODE
FROM dimdata.tmp_dim_not_covered_reason tmp
    WHERE live_table.dim_not_covered_reason_key = tmp.dim_not_covered_reason_key
;

SELECT 'Finished updating static data table dimdata.dim_processing_reason';