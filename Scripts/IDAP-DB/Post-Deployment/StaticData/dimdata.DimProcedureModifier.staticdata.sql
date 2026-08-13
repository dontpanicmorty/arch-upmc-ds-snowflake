/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_procedure_modifier

SELECT 'Updating static data table dimdata.dim_procedure_modifier';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_procedure_modifier
(
	DIM_PROCEDURE_MODIFIER_KEY INTEGER ,
	INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
	LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
	IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
	DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
	DATA_SOURCE_NAME VARCHAR,
	PROCEDURE_MODIFIER_CODE VARCHAR,
	PROCEDURE_MODIFIER_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_procedure_modifier (DIM_PROCEDURE_MODIFIER_KEY,	INSERT_DATETIME, LAST_UPDATED_DATETIME,	IS_LOGICAL_DELETE_FLAG,	DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_MODIFIER_CODE, PROCEDURE_MODIFIER_DESC)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'Unknown', NULL, NULL);
INSERT INTO dimdata.TMP_dim_procedure_modifier (DIM_PROCEDURE_MODIFIER_KEY,	INSERT_DATETIME, LAST_UPDATED_DATETIME,	IS_LOGICAL_DELETE_FLAG,	DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_MODIFIER_CODE, PROCEDURE_MODIFIER_DESC)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'n/a', NULL, NULL);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_procedure_modifier (DIM_PROCEDURE_MODIFIER_KEY,	INSERT_DATETIME, LAST_UPDATED_DATETIME,	IS_LOGICAL_DELETE_FLAG,	DIM_TPA_HIERARCHY_KEY, DATA_SOURCE_NAME, PROCEDURE_MODIFIER_CODE, PROCEDURE_MODIFIER_DESC)
SELECT tmp.DIM_PROCEDURE_MODIFIER_KEY,	tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME,	tmp.IS_LOGICAL_DELETE_FLAG,	tmp.DIM_TPA_HIERARCHY_KEY, tmp.DATA_SOURCE_NAME, tmp.PROCEDURE_MODIFIER_CODE, tmp.PROCEDURE_MODIFIER_DESC
FROM dimdata.tmp_dim_procedure_modifier tmp
    LEFT JOIN dimdata.dim_procedure_modifier tbl ON tbl.dim_procedure_modifier_key = tmp.dim_procedure_modifier_key
WHERE tbl.dim_procedure_modifier_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_procedure_modifier live_table
SET
live_table.DIM_PROCEDURE_MODIFIER_KEY = tmp.DIM_PROCEDURE_MODIFIER_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_TPA_HIERARCHY_KEY = tmp.DIM_TPA_HIERARCHY_KEY,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.PROCEDURE_MODIFIER_CODE = tmp.PROCEDURE_MODIFIER_CODE,
live_table.PROCEDURE_MODIFIER_DESC = tmp.PROCEDURE_MODIFIER_DESC
FROM dimdata.tmp_dim_procedure_modifier tmp
    WHERE live_table.dim_procedure_modifier_KEY = tmp.dim_procedure_modifier_KEY
;

SELECT 'Finished updating static data table dimdata.dim_procedure_modifier';