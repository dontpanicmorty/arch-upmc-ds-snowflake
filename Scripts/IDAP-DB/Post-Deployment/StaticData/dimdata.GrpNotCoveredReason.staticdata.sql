/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.grp_not_covered_reason

SELECT 'Updating static data table dimdata.grp_not_covered_reason';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_grp_not_covered_reason
(
	GRP_NOT_COVERED_REASON_KEY NUMBER(38,0),
	INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
	LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
	IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
	DIM_NOT_COVERED_REASON_KEY NUMBER(38,0),
	NOT_COVERED_REASON_POSITION_NBR NUMBER(38,0)
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_grp_not_covered_reason (GRP_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_NOT_COVERED_REASON_KEY, NOT_COVERED_REASON_POSITION_NBR)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 1, 0);
INSERT INTO dimdata.TMP_grp_not_covered_reason (GRP_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_NOT_COVERED_REASON_KEY, NOT_COVERED_REASON_POSITION_NBR)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 2, 0);


-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.grp_not_covered_reason (GRP_NOT_COVERED_REASON_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_NOT_COVERED_REASON_KEY, NOT_COVERED_REASON_POSITION_NBR)
SELECT tmp.GRP_NOT_COVERED_REASON_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_NOT_COVERED_REASON_KEY, tmp.NOT_COVERED_REASON_POSITION_NBR
FROM dimdata.tmp_grp_not_covered_reason tmp
    LEFT JOIN dimdata.grp_not_covered_reason tbl ON tbl.grp_not_covered_reason_key = tmp.grp_not_covered_reason_key
WHERE tbl.grp_not_covered_reason_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.grp_not_covered_reason live_table
SET
live_table.GRP_NOT_COVERED_REASON_KEY = tmp.GRP_NOT_COVERED_REASON_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_NOT_COVERED_REASON_KEY = tmp.DIM_NOT_COVERED_REASON_KEY,
live_table.NOT_COVERED_REASON_POSITION_NBR = tmp.NOT_COVERED_REASON_POSITION_NBR
FROM dimdata.tmp_grp_not_covered_reason tmp
    WHERE live_table.grp_not_covered_reason_KEY = tmp.grp_not_covered_reason_KEY
;

SELECT 'Finished updating static data table dimdata.grp_not_covered_reason';