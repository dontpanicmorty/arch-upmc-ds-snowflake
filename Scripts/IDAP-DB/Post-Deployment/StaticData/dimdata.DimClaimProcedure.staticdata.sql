/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_claim_procedure

SELECT 'Updating static data table dimdata.dim_claim_procedure';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_claim_procedure
(
    DIM_CLAIM_PROCEDURE_KEY INTEGER NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    PROCEDURE_CODE VARCHAR NOT NULL,
    PROCEDURE_CODE_SHORT_DESC VARCHAR,
    PROCEDURE_CODE_LONG_DESC VARCHAR,
    PROCEDURE_CODE_SPANISH_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_claim_procedure (DIM_CLAIM_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_CODE, PROCEDURE_CODE_SHORT_DESC, PROCEDURE_CODE_LONG_DESC, PROCEDURE_CODE_SPANISH_DESC)
    VALUES (1,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'Unknown', 'Unknown',NULL, NULL, NULL);
INSERT INTO dimdata.TMP_dim_claim_procedure (DIM_CLAIM_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_CODE, PROCEDURE_CODE_SHORT_DESC, PROCEDURE_CODE_LONG_DESC, PROCEDURE_CODE_SPANISH_DESC)
    VALUES (2,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'n/a', 'n/a',NULL, NULL, NULL);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_claim_procedure (DIM_CLAIM_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_CODE, PROCEDURE_CODE_SHORT_DESC, PROCEDURE_CODE_LONG_DESC, PROCEDURE_CODE_SPANISH_DESC)
SELECT tmp.DIM_CLAIM_PROCEDURE_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_TPA_HIERARCHY_KEY, tmp.DATA_SOURCE_NAME, tmp.PROCEDURE_CODE, tmp.PROCEDURE_CODE_SHORT_DESC, tmp.PROCEDURE_CODE_LONG_DESC, tmp.PROCEDURE_CODE_SPANISH_DESC
FROM dimdata.tmp_dim_claim_procedure tmp
    LEFT JOIN dimdata.dim_claim_procedure tbl ON tbl.dim_claim_procedure_key = tmp.dim_claim_procedure_key
WHERE tbl.dim_claim_procedure_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_claim_procedure live_table
SET
live_table.DIM_CLAIM_PROCEDURE_KEY = tmp.DIM_CLAIM_PROCEDURE_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_TPA_HIERARCHY_KEY = tmp.DIM_TPA_HIERARCHY_KEY,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.PROCEDURE_CODE = tmp.PROCEDURE_CODE,
live_table.PROCEDURE_CODE_SHORT_DESC = tmp.PROCEDURE_CODE_SHORT_DESC,
live_table.PROCEDURE_CODE_LONG_DESC = tmp.PROCEDURE_CODE_LONG_DESC,
live_table.PROCEDURE_CODE_SPANISH_DESC = tmp.PROCEDURE_CODE_SPANISH_DESC
FROM dimdata.tmp_dim_claim_procedure tmp
    WHERE live_table.dim_claim_procedure_KEY = tmp.dim_claim_procedure_KEY
;

SELECT 'Finished updating static data table dimdata.dim_claim_procedure';