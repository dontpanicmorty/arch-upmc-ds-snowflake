/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_DRUG

SELECT 'Updating static data table util.ML_STAGE_ENTITY';

-- 1: Define table variable
create or replace temporary table util.tmp_ML_STAGE_ENTITY
(
  ML_STAGE_ENTITY_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
  SCHEMA_NAME VARCHAR NOT NULL,
  TABLE_NAME VARCHAR NOT NULL,
  ENTITY_NAME VARCHAR NOT NULL,
  JSON_PATH VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO util.tmp_ML_STAGE_ENTITY (ML_STAGE_ENTITY_KEY, SCHEMA_NAME, TABLE_NAME, ENTITY_NAME, JSON_PATH)
  VALUES 
    (1, 'STAGEDATA','DELETED_DOCUMENT','deletedDocument',':envelope:instance:deletedDocument'),
    (2, 'STAGEDATA','CLAIM_DETAIL','claimDetail',''),
    (3, 'STAGEDATA','CLAIM_HEADER','claimHeader',''),
    (4, 'STAGEDATA','DATA_SOURCE','dataSource',''),
    (5, 'STAGEDATA','MEMBER_DEMOGRAPHIC','memberDemographic',''),
    (6, 'STAGEDATA','PROVIDER_ADDRESS','providerAddress',''),
    (7, 'STAGEDATA','PROVIDER_DETAIL','providerDetail',''),
    (8, 'STAGEDATA','REFERENCE_DATA_SINGULAR','referenceDataSingular',''),
    (9, 'STAGEDATA','DIAGNOSIS_RELATED_GROUP','diagnosisRelatedGroup',''),
    (10, 'STAGEDATA','PHARMACY_CLAIM_DETAIL','pharmacyClaimDetail',''),
    (11, 'STAGEDATA','PHARMACY_CLAIM_HEADER','pharmacyClaimHeader',''),
    (12, 'STAGEDATA','DRUG','drug',''),
    (13, 'STAGEDATA','RIDER','rider','')
;


-- 3: Insert any new items into the table from the table variable
INSERT INTO util.ML_STAGE_ENTITY (ML_STAGE_ENTITY_KEY, SCHEMA_NAME, TABLE_NAME, ENTITY_NAME, JSON_PATH)
SELECT tmp.ML_STAGE_ENTITY_KEY, tmp.SCHEMA_NAME, tmp.TABLE_NAME, tmp.ENTITY_NAME, tmp.JSON_PATH
FROM util.tmp_ML_STAGE_ENTITY tmp
    LEFT JOIN util.ML_STAGE_ENTITY tbl ON tbl.ML_STAGE_ENTITY_KEY = tmp.ML_STAGE_ENTITY_KEY
WHERE tbl.ML_STAGE_ENTITY_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE util.ML_STAGE_ENTITY live_table
SET
live_table.SCHEMA_NAME = tmp.SCHEMA_NAME,
live_table.TABLE_NAME = tmp.TABLE_NAME,
live_table.ENTITY_NAME = tmp.ENTITY_NAME,
live_table.JSON_PATH = tmp.JSON_PATH
FROM util.tmp_ML_STAGE_ENTITY tmp
    WHERE live_table.ML_STAGE_ENTITY_KEY = tmp.ML_STAGE_ENTITY_KEY
;

SELECT 'Finished updating static data table STAGEDATA.ML_STAGE_ENTITY';