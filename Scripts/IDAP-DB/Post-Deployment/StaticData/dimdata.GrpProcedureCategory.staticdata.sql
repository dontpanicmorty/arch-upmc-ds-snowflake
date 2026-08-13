/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.grp_procedure_category

SELECT 'Updating static data table dimdata.grp_procedure_category';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_grp_procedure_category
(
    GRP_PROCEDURE_CATEGORY_KEY NUMBER(38,0) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    DIM_PROCEDURE_CATEGORY_KEY INTEGER NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_grp_procedure_category (GRP_PROCEDURE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_PROCEDURE_CATEGORY_KEY)
    VALUES (1,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 1);
INSERT INTO dimdata.TMP_grp_procedure_category (GRP_PROCEDURE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_PROCEDURE_CATEGORY_KEY)
    VALUES (2,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 2);	

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.grp_procedure_category (GRP_PROCEDURE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, DIM_PROCEDURE_CATEGORY_KEY)
SELECT tmp.GRP_PROCEDURE_CATEGORY_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.DIM_PROCEDURE_CATEGORY_KEY
FROM dimdata.tmp_grp_procedure_category tmp
    LEFT JOIN dimdata.grp_procedure_category tbl ON tbl.grp_procedure_category_key = tmp.grp_procedure_category_key
WHERE tbl.grp_procedure_category_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.grp_procedure_category live_table
SET
live_table.GRP_PROCEDURE_CATEGORY_KEY = tmp.GRP_PROCEDURE_CATEGORY_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.DIM_PROCEDURE_CATEGORY_KEY = tmp.DIM_PROCEDURE_CATEGORY_KEY
FROM dimdata.tmp_grp_procedure_category tmp
    WHERE live_table.grp_procedure_category_KEY = tmp.grp_procedure_category_KEY
;

SELECT 'Finished updating static data table dimdata.grp_procedure_category';