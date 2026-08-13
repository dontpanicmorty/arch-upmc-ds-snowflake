/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_REVENUE_PROCEDURE

SELECT 'Updating static data table dimdata.DIM_REVENUE_PROCEDURE';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_REVENUE_PROCEDURE
(
	DIM_REVENUE_PROCEDURE_KEY NUMBER(38,0),
	INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	IS_LOGICAL_DELETE_FLAG BOOLEAN DEFAULT FALSE NOT NULL,
	REVENUE_CODE VARCHAR NOT NULL,
	REVENUE_CODE_SHORT_DESC VARCHAR NOT NULL,
	REVENUE_CODE_LONG_DESC VARCHAR,
	REVENUE_CODE_SPANISH_DESC VARCHAR
)
;
	
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.tmp_DIM_REVENUE_PROCEDURE (DIM_REVENUE_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, REVENUE_CODE, REVENUE_CODE_SHORT_DESC, REVENUE_CODE_LONG_DESC, REVENUE_CODE_SPANISH_DESC)
    VALUES	(1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 'Unknown', 'Unknown', 'Unknown', 'Unknown'),
    		(2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), FALSE, 'n/a', 'n/a', 'n/a', 'n/a');
-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_REVENUE_PROCEDURE (DIM_REVENUE_PROCEDURE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, REVENUE_CODE, REVENUE_CODE_SHORT_DESC, REVENUE_CODE_LONG_DESC, REVENUE_CODE_SPANISH_DESC) 
SELECT tmp.DIM_REVENUE_PROCEDURE_KEY,tmp.INSERT_DATETIME,tmp.LAST_UPDATED_DATETIME,tmp.IS_LOGICAL_DELETE_FLAG, tmp.REVENUE_CODE, tmp.REVENUE_CODE_SHORT_DESC, tmp.REVENUE_CODE_LONG_DESC, tmp.REVENUE_CODE_SPANISH_DESC
FROM dimdata.tmp_DIM_REVENUE_PROCEDURE tmp
    LEFT JOIN dimdata.DIM_REVENUE_PROCEDURE tbl ON tbl.DIM_REVENUE_PROCEDURE_KEY = TMP.DIM_REVENUE_PROCEDURE_KEY
WHERE tbl.DIM_REVENUE_PROCEDURE_KEY IS NULL;

-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_REVENUE_PROCEDURE';
