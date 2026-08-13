/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.grp_icd_diagnosis

SELECT 'Updating static data table dimdata.grp_icd_diagnosis';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_grp_icd_diagnosis
(
    GRP_ICD_DIAGNOSIS_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_ICD_DIAGNOSIS_KEY INTEGER NOT NULL,
    ICD_POSITION_NBR INTEGER NOT NULL,
    POA_CODE VARCHAR NOT NULL,
    ICD_QUALIFIER_CODE VARCHAR NOT NULL,
    ICD_QUALIFIER_DESC VARCHAR,
    PRIMARY_DIAGNOSIS_IND VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_grp_icd_diagnosis (GRP_ICD_DIAGNOSIS_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_DIAGNOSIS_KEY, ICD_POSITION_NBR, POA_CODE, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC, PRIMARY_DIAGNOSIS_IND)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1', '0', 'Unknown','Unknown', 'Unknown', 'Unknown');
	INSERT INTO dimdata.TMP_grp_icd_diagnosis (GRP_ICD_DIAGNOSIS_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_DIAGNOSIS_KEY, ICD_POSITION_NBR, POA_CODE, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC, PRIMARY_DIAGNOSIS_IND)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '2', '0', 'n/a','n/a', 'n/a', 'n/a');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.grp_icd_diagnosis (GRP_ICD_DIAGNOSIS_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_ICD_DIAGNOSIS_KEY, ICD_POSITION_NBR, POA_CODE, ICD_QUALIFIER_CODE, ICD_QUALIFIER_DESC, PRIMARY_DIAGNOSIS_IND)
SELECT tmp.GRP_ICD_DIAGNOSIS_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_ICD_DIAGNOSIS_KEY, tmp.ICD_POSITION_NBR, tmp.POA_CODE, tmp.ICD_QUALIFIER_CODE, tmp.ICD_QUALIFIER_DESC, tmp.PRIMARY_DIAGNOSIS_IND
FROM dimdata.tmp_grp_icd_diagnosis tmp
    LEFT JOIN dimdata.grp_icd_diagnosis tbl ON tbl.grp_icd_diagnosis_key = tmp.grp_icd_diagnosis_key
WHERE tbl.grp_icd_diagnosis_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.grp_icd_diagnosis live_table
SET
live_table.GRP_ICD_DIAGNOSIS_KEY = tmp.GRP_ICD_DIAGNOSIS_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_ICD_DIAGNOSIS_KEY = tmp.DIM_ICD_DIAGNOSIS_KEY,
live_table.ICD_POSITION_NBR = tmp.ICD_POSITION_NBR,
live_table.POA_CODE = tmp.POA_CODE,
live_table.ICD_QUALIFIER_CODE = tmp.ICD_QUALIFIER_CODE,
live_table.ICD_QUALIFIER_DESC = tmp.ICD_QUALIFIER_DESC,
live_table.PRIMARY_DIAGNOSIS_IND = tmp.PRIMARY_DIAGNOSIS_IND
FROM dimdata.tmp_grp_icd_diagnosis tmp
    WHERE live_table.grp_icd_diagnosis_KEY = tmp.grp_icd_diagnosis_KEY
;

SELECT 'Finished updating static data table dimdata.grp_icd_diagnosis';