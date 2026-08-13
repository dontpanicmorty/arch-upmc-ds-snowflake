/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_place_of_service

SELECT 'Updating static data table dimdata.dim_place_of_service';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_place_of_service
(
    DIM_PLACE_OF_SERVICE_KEY INTEGER,
    INSERT_DATETIME TIMESTAMP_TZ(9),
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9),
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_TPA_HIERARCHY_KEY INTEGER NOT NULL,
    PLACE_OF_SERVICE_CODE VARCHAR NOT NULL,
    PLACE_OF_SERVICE_DESC VARCHAR,
    SERVICE_TYPE_CODE VARCHAR NOT NULL,
    SERVICE_TYPE_DESC VARCHAR,
    LOCATION_CODE VARCHAR NOT NULL,
    LOCATION_DESC VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_place_of_service (DIM_PLACE_OF_SERVICE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, PLACE_OF_SERVICE_CODE, PLACE_OF_SERVICE_DESC, SERVICE_TYPE_CODE, SERVICE_TYPE_DESC, LOCATION_CODE, LOCATION_DESC)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'Unknown', NULL, 'Unknown', NULL, 'Unknown', NULL);
INSERT INTO dimdata.TMP_dim_place_of_service (DIM_PLACE_OF_SERVICE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, PLACE_OF_SERVICE_CODE, PLACE_OF_SERVICE_DESC, SERVICE_TYPE_CODE, SERVICE_TYPE_DESC, LOCATION_CODE, LOCATION_DESC)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', '1000', 'n/a', NULL, 'n/a', NULL, 'n/a', NULL);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_place_of_service (DIM_PLACE_OF_SERVICE_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_TPA_HIERARCHY_KEY, PLACE_OF_SERVICE_CODE, PLACE_OF_SERVICE_DESC, SERVICE_TYPE_CODE, SERVICE_TYPE_DESC, LOCATION_CODE, LOCATION_DESC)
SELECT tmp.DIM_PLACE_OF_SERVICE_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_TPA_HIERARCHY_KEY, tmp.PLACE_OF_SERVICE_CODE, tmp.PLACE_OF_SERVICE_DESC, tmp.SERVICE_TYPE_CODE, tmp.SERVICE_TYPE_DESC, tmp.LOCATION_CODE, tmp.LOCATION_DESC
FROM dimdata.tmp_dim_place_of_service tmp
    LEFT JOIN dimdata.dim_place_of_service tbl ON tbl.dim_place_of_service_key = tmp.dim_place_of_service_key
WHERE tbl.dim_place_of_service_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_place_of_service live_table
SET
live_table.DIM_PLACE_OF_SERVICE_KEY = tmp.DIM_PLACE_OF_SERVICE_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_TPA_HIERARCHY_KEY = tmp.DIM_TPA_HIERARCHY_KEY,
live_table.PLACE_OF_SERVICE_CODE = tmp.PLACE_OF_SERVICE_CODE,
live_table.PLACE_OF_SERVICE_DESC = tmp.PLACE_OF_SERVICE_DESC,
live_table.SERVICE_TYPE_CODE = tmp.SERVICE_TYPE_CODE,
live_table.SERVICE_TYPE_DESC = tmp.SERVICE_TYPE_DESC,
live_table.LOCATION_CODE = tmp.LOCATION_CODE,
live_table.LOCATION_DESC = tmp.LOCATION_DESC
FROM dimdata.tmp_dim_place_of_service tmp
    WHERE live_table.dim_place_of_service_KEY = tmp.dim_place_of_service_KEY
;

SELECT 'Finished updating static data table dimdata.dim_place_of_service';