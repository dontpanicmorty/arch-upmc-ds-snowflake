/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.PRICING_NETWORK

SELECT 'Updating static data table stagedata.PRICING_NETWORK';


-- 1: Define table variable
create or replace temporary table stagedata.tmp_PRICING_NETWORK
(
    PRICING_NETWORK_KEY     INT  NOT NULL,
    PRICING_NETWORK_NAME    VARCHAR NOT NULL,
    LAST_UPDATED_DATETIME   DATETIME NOT NULL,
    LAST_UPDATED_USER_NAME  VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (1,'PARTNER', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (2,'SELECT', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (3,'STANDARD', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (4,'PREMIUM', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (5,'ENHANCED ACCESS', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (6,'TOTAL ADVANTAGE', CURRENT_TIMESTAMP(), 'SMITHWP');
INSERT INTO stagedata.tmp_PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)    VALUES (7,'UPMC EMPLOYEES', CURRENT_TIMESTAMP(), 'SMITHWP');

-- 3: Insert any new items into the table from the table variable
INSERT INTO stagedata.PRICING_NETWORK (PRICING_NETWORK_KEY, PRICING_NETWORK_NAME, LAST_UPDATED_DATETIME, LAST_UPDATED_USER_NAME)
SELECT tmp.PRICING_NETWORK_KEY, tmp.PRICING_NETWORK_NAME, tmp.LAST_UPDATED_DATETIME, tmp.LAST_UPDATED_USER_NAME
FROM stagedata.tmp_PRICING_NETWORK tmp
    LEFT JOIN stagedata.PRICING_NETWORK tbl ON tbl.PRICING_NETWORK_KEY = tmp.PRICING_NETWORK_KEY
WHERE tbl.PRICING_NETWORK_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE stagedata.PRICING_NETWORK live_table
SET
live_table.PRICING_NETWORK_NAME=tmp.PRICING_NETWORK_NAME
,live_table.LAST_UPDATED_DATETIME=tmp.LAST_UPDATED_DATETIME
,live_table.LAST_UPDATED_USER_NAME=tmp.LAST_UPDATED_USER_NAME
FROM stagedata.tmp_PRICING_NETWORK tmp
    WHERE live_table.PRICING_NETWORK_KEY = tmp.PRICING_NETWORK_KEY
;

-- 5: Delete any missing records from the target

/* commented out for now since it doesn't work quite right
	DELETE FROM stagedata.PRICING_NETWORK FROM stagedata.PRICING_NETWORK LiveTable
	LEFT JOIN stagedata.tmp_PRICING_NETWORK tmp ON LiveTable.PRICING_NETWORK_KEY = tmp.PRICING_NETWORK_KEY
	WHERE tmp.PRICING_NETWORK_KEY IS NULL;
*/



SELECT 'Finished updating static data table stagedata.PRICING_NETWORK';