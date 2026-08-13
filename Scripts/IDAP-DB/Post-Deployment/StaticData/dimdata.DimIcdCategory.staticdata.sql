/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_ICD_CATEGORY

SELECT 'Updating static data table dimdata.DIM_ICD_CATEGORY';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_ICD_CATEGORY
(
    DIM_ICD_CATEGORY_KEY INTEGER AUTOINCREMENT START 1000 INCREMENT 1 NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN DEFAULT FALSE NOT NULL,
    DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    ICD_VERSION_NBR VARCHAR NOT NULL,
    ICD_CATEGORY_CODE VARCHAR NOT NULL,
    ICD_CATEGORY_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_ICD_CATEGORY (DIM_ICD_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, ICD_VERSION_NBR, ICD_CATEGORY_CODE, ICD_CATEGORY_DESC)
	VALUES(1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 1, 'Unknown', 'Unknown', 'Unknown', 'Unknown');
INSERT INTO DIMDATA.TMP_DIM_ICD_CATEGORY (DIM_ICD_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, ICD_VERSION_NBR, ICD_CATEGORY_CODE, ICD_CATEGORY_DESC)
	VALUES(2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 1, 'n/a', 'n/a', 'n/a', 'n/a');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_ICD_CATEGORY (DIM_ICD_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, ICD_VERSION_NBR, ICD_CATEGORY_CODE, ICD_CATEGORY_DESC)
SELECT tmp.DIM_ICD_CATEGORY_KEY,tmp.INSERT_DATETIME,tmp.LAST_UPDATED_DATETIME,tmp.IS_LOGICAL_DELETE_FLAG,tmp.DIM_TPA_HIERARCHY_KEY,tmp.DATA_SOURCE_NAME,tmp.ICD_VERSION_NBR,tmp.ICD_CATEGORY_CODE,tmp.ICD_CATEGORY_DESC
FROM dimdata.tmp_DIM_ICD_CATEGORY tmp
    LEFT JOIN dimdata.DIM_ICD_CATEGORY tbl ON tbl.DIM_ICD_CATEGORY_key = tmp.DIM_ICD_CATEGORY_key
WHERE tbl.DIM_ICD_CATEGORY_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_ICD_CATEGORY';