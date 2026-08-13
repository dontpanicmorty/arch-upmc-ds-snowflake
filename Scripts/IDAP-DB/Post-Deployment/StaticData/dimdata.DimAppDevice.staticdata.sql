/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_APP_DEVICE

SELECT 'Updating static data table dimdata.DIM_APP_DEVICE';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_DIM_APP_DEVICE
(
	DIM_APP_DEVICE_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    APP_PRODUCT_NAME VARCHAR NOT NULL,
    DEVICE_OS_PLATFORM_NAME VARCHAR NOT NULL,
    DEVICE_OS_VERSION_NBR VARCHAR NOT NULL,
    DEVICE_MODEL_NAME VARCHAR NOT NULL    
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_APP_DEVICE (DIM_APP_DEVICE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, APP_PRODUCT_NAME, DEVICE_OS_PLATFORM_NAME, DEVICE_OS_VERSION_NBR, DEVICE_MODEL_NAME)
	VALUES(1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'Mobile', 'Unknown','Unknown', 'Unknown');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.DIM_APP_DEVICE (DIM_APP_DEVICE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, APP_PRODUCT_NAME, DEVICE_OS_PLATFORM_NAME, DEVICE_OS_VERSION_NBR, DEVICE_MODEL_NAME)
SELECT tmp.DIM_APP_DEVICE_KEY,tmp.INSERT_DATETIME,tmp.LAST_UPDATED_DATETIME,tmp.APP_PRODUCT_NAME,tmp.DEVICE_OS_PLATFORM_NAME,tmp.DEVICE_OS_VERSION_NBR, tmp.DEVICE_MODEL_NAME
FROM dimdata.tmp_DIM_APP_DEVICE tmp
    LEFT JOIN dimdata.DIM_APP_DEVICE tbl ON tbl.DIM_APP_DEVICE_key = tmp.DIM_APP_DEVICE_key
WHERE tbl.DIM_APP_DEVICE_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_APP_DEVICE';