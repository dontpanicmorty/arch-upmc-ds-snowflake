/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.GROUP_CARRIER_PRICE_GROUP

SELECT 'Updating static data table stagedata.GROUP_CARRIER_PRICE_GROUP';


-- 1: Define table variable
create or replace temporary table stagedata.tmp_GROUP_CARRIER_PRICE_GROUP
(	
  GROUP_CARRIER_PRICE_GROUP_KEY INT NOT NULL,
  GROUP_CARRIER_PRICE_GROUP_CODE VARCHAR NOT NULL
)
;

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO stagedata.tmp_GROUP_CARRIER_PRICE_GROUP (GROUP_CARRIER_PRICE_GROUP_KEY, GROUP_CARRIER_PRICE_GROUP_CODE)
VALUES (
  1, 
  'FED65'
);

INSERT INTO stagedata.tmp_GROUP_CARRIER_PRICE_GROUP (GROUP_CARRIER_PRICE_GROUP_KEY, GROUP_CARRIER_PRICE_GROUP_CODE)
VALUES (
  2, 
  'NoValue'
);

-- 3: Insert any new items into the table from the table variable
INSERT INTO stagedata.GROUP_CARRIER_PRICE_GROUP (GROUP_CARRIER_PRICE_GROUP_KEY, GROUP_CARRIER_PRICE_GROUP_CODE)
SELECT tmp.GROUP_CARRIER_PRICE_GROUP_KEY, tmp.GROUP_CARRIER_PRICE_GROUP_CODE
FROM stagedata.tmp_GROUP_CARRIER_PRICE_GROUP tmp
    LEFT JOIN stagedata.GROUP_CARRIER_PRICE_GROUP tbl ON tbl.GROUP_CARRIER_PRICE_GROUP_KEY = tmp.GROUP_CARRIER_PRICE_GROUP_KEY
WHERE tbl.GROUP_CARRIER_PRICE_GROUP_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE stagedata.GROUP_CARRIER_PRICE_GROUP live_table
SET live_table.GROUP_CARRIER_PRICE_GROUP_CODE = tmp.GROUP_CARRIER_PRICE_GROUP_CODE
FROM stagedata.tmp_GROUP_CARRIER_PRICE_GROUP tmp
    WHERE live_table.GROUP_CARRIER_PRICE_GROUP_KEY = tmp.GROUP_CARRIER_PRICE_GROUP_KEY
;

-- 5: Delete any missing records from the target

/* commented out for now since it doesn't work quite right
	DELETE FROM stagedata.GROUP_CARRIER_PRICE_GROUP LiveTable
	LEFT JOIN stagedata.GROUP_CARRIER_PRICE_GROUP tmp ON LiveTable.GROUP_CARRIER_PRICE_GROUP_KEY = tmp.GROUP_CARRIER_PRICE_GROUP_KEY
	WHERE tmp.GROUP_CARRIER_PRICE_GROUP_KEY IS NULL;
*/



SELECT 'Finished updating static data table stagedata.GROUP_CARRIER_PRICE_GROUP';