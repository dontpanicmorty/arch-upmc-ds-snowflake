/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.dim_member_demographic

SELECT 'Updating static data table stagedata.dim_member_demographic';

-- 1: Define table variable
create or replace temporary table stagedata.tmp_dim_member_demographic
(
	DIM_MEMBER_DEMOGRAPHIC_KEY INTEGER,
	INSERT_DATETIME TIMESTAMP_TZ(9),
	LAST_UPDATED_DATETIME TIMESTAMP_TZ(9),
	IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
	MEMBER_AGE INTEGER NOT NULL,
	MEMBER_GENDER_CODE VARCHAR NOT NULL,
	ACTUARIAL_AGE_RANGE VARCHAR,
	CLINICAL_AGE_RANGE VARCHAR,
	FINANCIAL_AGE_RANGE VARCHAR,
	MEDICARE_RATE_AGE_RANGE VARCHAR,
	MEDICARE_HCFA_AGE_RANGE VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO STAGEDATA.TMP_dim_member_demographic (DIM_MEMBER_DEMOGRAPHIC_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, MEMBER_AGE, MEMBER_GENDER_CODE, ACTUARIAL_AGE_RANGE, CLINICAL_AGE_RANGE, FINANCIAL_AGE_RANGE, MEDICARE_RATE_AGE_RANGE, MEDICARE_HCFA_AGE_RANGE)
    VALUES (1,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 0, 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown');
INSERT INTO STAGEDATA.TMP_dim_member_demographic (DIM_MEMBER_DEMOGRAPHIC_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, MEMBER_AGE, MEMBER_GENDER_CODE, ACTUARIAL_AGE_RANGE, CLINICAL_AGE_RANGE, FINANCIAL_AGE_RANGE, MEDICARE_RATE_AGE_RANGE, MEDICARE_HCFA_AGE_RANGE)
    VALUES (2,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 0, 'n/a', 'n/a', 'n/a', 'n/a', 'n/a', 'n/a');


-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_member_demographic (DIM_MEMBER_DEMOGRAPHIC_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, MEMBER_AGE, MEMBER_GENDER_CODE, ACTUARIAL_AGE_RANGE, CLINICAL_AGE_RANGE, FINANCIAL_AGE_RANGE, MEDICARE_RATE_AGE_RANGE, MEDICARE_HCFA_AGE_RANGE)
SELECT tmp.DIM_MEMBER_DEMOGRAPHIC_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.MEMBER_AGE, tmp.MEMBER_GENDER_CODE, tmp.ACTUARIAL_AGE_RANGE, tmp.CLINICAL_AGE_RANGE, tmp.FINANCIAL_AGE_RANGE, tmp.MEDICARE_RATE_AGE_RANGE, tmp.MEDICARE_HCFA_AGE_RANGE
FROM stagedata.tmp_dim_member_demographic tmp
    LEFT JOIN dimdata.dim_member_demographic tbl ON tbl.dim_member_demographic_key = tmp.dim_member_demographic_key
WHERE tbl.dim_member_demographic_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_member_demographic live_table
SET
live_table.DIM_MEMBER_DEMOGRAPHIC_KEY = tmp.DIM_MEMBER_DEMOGRAPHIC_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.MEMBER_AGE = tmp.MEMBER_AGE,
live_table.MEMBER_GENDER_CODE = tmp.MEMBER_GENDER_CODE,
live_table.ACTUARIAL_AGE_RANGE = tmp.ACTUARIAL_AGE_RANGE,
live_table.CLINICAL_AGE_RANGE = tmp.CLINICAL_AGE_RANGE,
live_table.FINANCIAL_AGE_RANGE = tmp.FINANCIAL_AGE_RANGE,
live_table.MEDICARE_RATE_AGE_RANGE = tmp.MEDICARE_RATE_AGE_RANGE,
live_table.MEDICARE_HCFA_AGE_RANGE = tmp.MEDICARE_HCFA_AGE_RANGE
FROM stagedata.tmp_dim_member_demographic tmp
    WHERE live_table.dim_member_demographic_KEY = tmp.dim_member_demographic_KEY
;

SELECT 'Finished updating static data table STAGEDATA.dim_member_demographic';