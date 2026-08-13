/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_DRUG

SELECT 'Updating static data table util.ML_STAGE_DOMAIN_TO_ENTITY';

-- 1: Define table variable
create or replace temporary table util.tmp_ML_STAGE_DOMAIN_TO_ENTITY
(
  ML_STAGE_DOMAIN_TO_ENTITY_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
  ML_STAGE_DOMAIN_KEY NUMBER(38,0) NOT NULL,
  ML_STAGE_ENTITY_KEY NUMBER(38,0) NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.

INSERT INTO util.tmp_ML_STAGE_DOMAIN_TO_ENTITY (ML_STAGE_DOMAIN_TO_ENTITY_KEY, ML_STAGE_DOMAIN_KEY, ML_STAGE_ENTITY_KEY)
  VALUES 
  -- Note that the key values actually are keys in the other StaticData load
  -- procedures. Reference those as you need.
    (1, 1, 1),
    (2, 1, 2),
    (3, 1, 3),
    (4, 1, 4),
    (5, 1, 5),
    (6, 1, 6),
    (7, 1, 7),
    (8, 1, 8),
    (9, 1, 9),
    (10, 2, 10),
    (11, 2, 11),
    (12, 2, 12),
    (13, 1, 13)
;

-- 3: Insert any new items into the table from the table variable
INSERT INTO util.ML_STAGE_DOMAIN_TO_ENTITY (ML_STAGE_DOMAIN_TO_ENTITY_KEY, ML_STAGE_DOMAIN_KEY, ML_STAGE_ENTITY_KEY)
SELECT tmp.ML_STAGE_DOMAIN_TO_ENTITY_KEY, tmp.ML_STAGE_DOMAIN_KEY, tmp.ML_STAGE_ENTITY_KEY
FROM util.tmp_ML_STAGE_DOMAIN_TO_ENTITY tmp
    LEFT JOIN util.ML_STAGE_DOMAIN_TO_ENTITY tbl ON tbl.ML_STAGE_DOMAIN_TO_ENTITY_KEY = tmp.ML_STAGE_DOMAIN_TO_ENTITY_KEY
WHERE tbl.ML_STAGE_DOMAIN_TO_ENTITY_KEY IS NULL 
;
-- 4: Update any modified values with the values from the table variable
UPDATE util.ML_STAGE_DOMAIN_TO_ENTITY live_table
SET
live_table.ML_STAGE_DOMAIN_KEY = tmp.ML_STAGE_DOMAIN_KEY,
live_table.ML_STAGE_ENTITY_KEY = tmp.ML_STAGE_ENTITY_KEY
FROM util.tmp_ML_STAGE_DOMAIN_TO_ENTITY tmp
WHERE live_table.ML_STAGE_DOMAIN_TO_ENTITY_KEY = tmp.ML_STAGE_DOMAIN_TO_ENTITY_KEY
;

SELECT 'Finished updating static data table STAGEDATA.ML_STAGE_DOMAIN_TO_ENTITY';

