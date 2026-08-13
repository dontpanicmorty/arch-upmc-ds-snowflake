/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_APP_EVENT

SELECT 'Updating static data table dimdata.DIM_APP_EVENT';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_APP_EVENT
(
	DIM_APP_EVENT_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    APP_PRODUCT_NAME VARCHAR NOT NULL,
    EVENT_NAME VARCHAR NOT NULL,
    EVENT_VALUES VARIANT NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_APP_EVENT (DIM_APP_EVENT_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, APP_PRODUCT_NAME, EVENT_NAME, EVENT_VALUES)
SELECT
1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'Mobile', 'Unknown',PARSE_JSON('[]')
;

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_APP_EVENT (DIM_APP_EVENT_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, APP_PRODUCT_NAME, EVENT_NAME, EVENT_VALUES)
SELECT tmp.DIM_APP_EVENT_KEY,tmp.INSERT_DATETIME,tmp.LAST_UPDATED_DATETIME,tmp.APP_PRODUCT_NAME,tmp.EVENT_NAME,tmp.EVENT_VALUES
FROM dimdata.tmp_DIM_APP_EVENT tmp
    LEFT JOIN dimdata.DIM_APP_EVENT tbl ON tbl.DIM_APP_EVENT_key = tmp.DIM_APP_EVENT_key
WHERE tbl.DIM_APP_EVENT_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_APP_EVENT';