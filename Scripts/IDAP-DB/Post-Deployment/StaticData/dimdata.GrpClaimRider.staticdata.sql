/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.grp_claim_rider

SELECT 'Updating static data table dimdata.grp_claim_rider';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_grp_claim_rider
(
    GRP_CLAIM_RIDER_KEY NUMBER(38,0) NOT NULL,
    DIM_RIDER_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_grp_claim_rider (GRP_CLAIM_RIDER_KEY, DIM_RIDER_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG)
    VALUES (1, 1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False');
INSERT INTO dimdata.TMP_grp_claim_rider (GRP_CLAIM_RIDER_KEY, DIM_RIDER_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG)
    VALUES (2, 2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.grp_claim_rider (GRP_CLAIM_RIDER_KEY, DIM_RIDER_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG)
SELECT tmp.GRP_CLAIM_RIDER_KEY, tmp.DIM_RIDER_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG
FROM dimdata.tmp_grp_claim_rider tmp
    LEFT JOIN dimdata.grp_claim_rider tbl ON tbl.grp_claim_rider_key = tmp.grp_claim_rider_key
WHERE tbl.grp_claim_rider_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.grp_claim_rider live_table
SET
live_table.GRP_CLAIM_RIDER_KEY = tmp.GRP_CLAIM_RIDER_KEY,
live_table.DIM_RIDER_KEY = tmp.DIM_RIDER_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG
FROM dimdata.tmp_grp_claim_rider tmp
    WHERE live_table.grp_claim_rider_KEY = tmp.grp_claim_rider_KEY
;

SELECT 'Finished updating static data table dimdata.grp_claim_rider';