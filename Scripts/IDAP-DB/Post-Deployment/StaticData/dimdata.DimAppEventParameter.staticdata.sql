/***************************************
***   Static data management script  ***
***************************************/
-- This script will manage the static data from for stagedata.DIM_APP_EVENT_PARAMETER

SELECT 'Updating static data table DIMDATA.DIM_APP_EVENT_PARAMETER';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE DIMDATA.TMP_DIM_APP_EVENT_PARAMETER
(
    DIM_APP_EVENT_PARAMETER_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    EVENT_PARAMETER_NAME VARCHAR NOT NULL,
    EVENT_PARAMETER_VALUE VARCHAR NOT NULL,
    CONSTRAINT PK_DIM_APP_EVENT_PARAMETER PRIMARY KEY (DIM_APP_EVENT_PARAMETER_KEY),
    CONSTRAINT UK_APP_EVENT_PARAMETER UNIQUE(EVENT_PARAMETER_NAME, EVENT_PARAMETER_VALUE)
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_APP_EVENT_PARAMETER (DIM_APP_EVENT_PARAMETER_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, EVENT_PARAMETER_NAME, EVENT_PARAMETER_VALUE)
	VALUES(1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(),'Unknown', 'Unknown');

-- 3: Insert any new items into the table from the table variable
INSERT INTO DIMDATA.DIM_APP_EVENT_PARAMETER (DIM_APP_EVENT_PARAMETER_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, EVENT_PARAMETER_NAME, EVENT_PARAMETER_VALUE)
SELECT tmp.DIM_APP_EVENT_PARAMETER_KEY,tmp.INSERT_DATETIME,tmp.LAST_UPDATED_DATETIME,tmp.EVENT_PARAMETER_NAME,tmp.EVENT_PARAMETER_VALUE
FROM DIMDATA.TMP_DIM_APP_EVENT_PARAMETER tmp
    LEFT JOIN DIMDATA.DIM_APP_EVENT_PARAMETER tbl ON tbl.DIM_APP_EVENT_PARAMETER_KEY = tmp.DIM_APP_EVENT_PARAMETER_KEY
WHERE tbl.DIM_APP_EVENT_PARAMETER_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

-- 4: Update any modified values with the values from the table variable
UPDATE DIMDATA.DIM_APP_EVENT_PARAMETER live_table
SET
live_table.INSERT_DATETIME=tmp.INSERT_DATETIME, live_table.LAST_UPDATED_DATETIME=tmp.LAST_UPDATED_DATETIME, 
live_table.EVENT_PARAMETER_NAME=tmp.EVENT_PARAMETER_NAME, live_table.EVENT_PARAMETER_VALUE=tmp.EVENT_PARAMETER_VALUE
FROM DIMDATA.TMP_DIM_APP_EVENT_PARAMETER tmp
    WHERE live_table.DIM_APP_EVENT_PARAMETER_KEY = tmp.DIM_APP_EVENT_PARAMETER_KEY
;

SELECT 'Finished updating static data table DIMDATA.DIM_APP_EVENT_PARAMETER';