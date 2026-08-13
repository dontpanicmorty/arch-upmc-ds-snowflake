/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_DRUG

SELECT 'Updating static data table util.ML_STAGE_DOMAIN';

-- 1: Define table variable
create or replace temporary table util.tmp_ML_STAGE_DOMAIN
(
	ML_STAGE_DOMAIN_KEY NUMBER(38,0) AUTOINCREMENT START 1000 INCREMENT 1 NOT NULL,
  DOMAIN_NAME VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.

INSERT INTO util.tmp_ML_STAGE_DOMAIN (ML_STAGE_DOMAIN_KEY, DOMAIN_NAME)
  VALUES (1, 'claim'), (2, 'pharmacy')
;


-- 3: Insert any new items into the table from the table variable
INSERT INTO util.ML_STAGE_DOMAIN (ML_STAGE_DOMAIN_KEY, DOMAIN_NAME)
SELECT tmp.ML_STAGE_DOMAIN_KEY, tmp.DOMAIN_NAME
FROM util.tmp_ML_STAGE_DOMAIN tmp
    LEFT JOIN util.ML_STAGE_DOMAIN tbl ON tbl.ML_STAGE_DOMAIN_KEY = tmp.ML_STAGE_DOMAIN_KEY
WHERE tbl.ML_STAGE_DOMAIN_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE util.ML_STAGE_DOMAIN live_table
SET
live_table.DOMAIN_NAME = tmp.DOMAIN_NAME
FROM util.tmp_ML_STAGE_DOMAIN tmp
    WHERE live_table.ML_STAGE_DOMAIN_KEY = tmp.ML_STAGE_DOMAIN_KEY
;

SELECT 'Finished updating static data table STAGEDATA.ML_STAGE_DOMAIN';

