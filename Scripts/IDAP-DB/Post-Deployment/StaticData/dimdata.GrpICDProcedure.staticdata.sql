/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.grp_icd_procedure

SELECT 'Updating static data table dimdata.grp_icd_procedure';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_grp_icd_procedure
(
    GRP_ICD_PROCEDURE_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_ICD_PROCEDURE_KEY INTEGER NOT NULL,
    ICD_POSITION_NBR INTEGER NOT NULL,
    ICD_QUALIFIER_CODE VARCHAR NOT NULL,
    ICD_QUALIFIER_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_grp_icd_procedure (GRP_ICD_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_PROCEDURE_KEY, ICD_POSITION_NBR, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 1, 0, 'Unknown', 'Unknown');
INSERT INTO dimdata.TMP_grp_icd_procedure (GRP_ICD_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_PROCEDURE_KEY, ICD_POSITION_NBR, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 2, 0, 'n/a', 'n/a');


-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.grp_icd_procedure (GRP_ICD_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_PROCEDURE_KEY, ICD_POSITION_NBR, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC)
SELECT tmp.GRP_ICD_PROCEDURE_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_ICD_PROCEDURE_KEY, tmp.ICD_POSITION_NBR, tmp.ICD_QUALIFIER_CODE, tmp.ICD_QUALIFIER_DESC
FROM dimdata.tmp_grp_icd_procedure tmp
    LEFT JOIN dimdata.grp_icd_procedure tbl ON tbl.grp_icd_procedure_key = tmp.grp_icd_procedure_key
WHERE tbl.grp_icd_procedure_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.grp_icd_procedure live_table
SET
live_table.GRP_ICD_PROCEDURE_KEY = tmp.GRP_ICD_PROCEDURE_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table. LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_ICD_PROCEDURE_KEY = tmp.DIM_ICD_PROCEDURE_KEY,
live_table.ICD_POSITION_NBR = tmp.ICD_POSITION_NBR,
live_table.ICD_QUALIFIER_CODE = tmp.ICD_QUALIFIER_CODE,
live_table.ICD_QUALIFIER_DESC = tmp.ICD_QUALIFIER_DESC
FROM dimdata.tmp_grp_icd_procedure tmp
    WHERE live_table.grp_icd_procedure_KEY = tmp.grp_icd_procedure_KEY
;

SELECT 'Finished updating static data table dimdata.grp_icd_procedure';