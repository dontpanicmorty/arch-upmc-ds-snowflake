/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.provider_ods_data_source

SELECT 'Updating static data table stagedata.provider_ods_data_source';

-- 1: Define table variable
create or replace temporary table stagedata.tmp_provider_ods_data_source
(
data_source_key INT NOT NULL,
data_source_name VARCHAR NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO stagedata.tmp_provider_ods_data_source (data_source_key, data_source_name)
VALUES 
(1, 'Cactus')
,(2, 'NVA')
,(3, 'MMO')
,(4, 'Dentemax')
,(5, 'CCBH')
,(6, 'ESI')
,(7, 'Envolve')
,(8, 'Avesis')
,(9, 'Cigna')
,(10, 'MC400Upm')
;

-- 3: Insert any new items into the table from the table variable
INSERT INTO stagedata.provider_ods_data_source (data_source_key, data_source_name)
SELECT tmp.data_source_key, tmp.data_source_name
FROM stagedata.tmp_provider_ods_data_source tmp
    LEFT JOIN stagedata.provider_ods_data_source tbl ON tbl.data_source_key = tmp.data_source_key
WHERE tbl.data_source_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE stagedata.provider_ods_data_source live_table
SET
live_table.data_source_name = tmp.data_source_name
FROM stagedata.tmp_provider_ods_data_source tmp
    WHERE live_table.data_source_key = tmp.data_source_key
;

SELECT 'Finished updating static data table STAGEDATA.PROVIDER_ODS_DATA_SOURCE';