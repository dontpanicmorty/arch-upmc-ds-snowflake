/***************************************
***   Static data management script  *** 
***************************************/

-- This script will manage the static data from for dimdata.dim_financial_service_category

SELECT 'Updating static data table dimdata.dim_financial_service_category';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_financial_service_category
(
    DIM_FINANCIAL_SERVICE_CATEGORY_KEY INTEGER,
    INSERT_DATETIME TIMESTAMP_TZ(9),
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9),
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    CONTROLLABLE_EXPENSE_CODE VARCHAR NOT NULL,
    FINANCIAL_SERVICE_DECISION_STEP VARCHAR NOT NULL,
    FINANCIAL_SERVICE_GROUP_CODE VARCHAR NOT NULL,
    FINANCIAL_SERVICE_GROUP_DESC VARCHAR NOT NULL,
    FINANCIAL_SERVICE_SUBGRP_CODE VARCHAR NOT NULL,
    FINANCIAL_SERVICE_SUBGRP_DESC VARCHAR NOT NULL,
    UNIT_MEASURE_CODE VARCHAR NOT NULL,
    CLOSING_CATEGORY_DESC VARCHAR NOT NULL

)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_financial_service_category (DIM_FINANCIAL_SERVICE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, CONTROLLABLE_EXPENSE_CODE, FINANCIAL_SERVICE_DECISION_STEP, FINANCIAL_SERVICE_GROUP_CODE, FINANCIAL_SERVICE_GROUP_DESC, FINANCIAL_SERVICE_SUBGRP_CODE, FINANCIAL_SERVICE_SUBGRP_DESC, UNIT_MEASURE_CODE, CLOSING_CATEGORY_DESC)
    VALUES (1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 'Unknown', 'Unknown', 'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
INSERT INTO dimdata.TMP_dim_financial_service_category (DIM_FINANCIAL_SERVICE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, CONTROLLABLE_EXPENSE_CODE, FINANCIAL_SERVICE_DECISION_STEP, FINANCIAL_SERVICE_GROUP_CODE, FINANCIAL_SERVICE_GROUP_DESC, FINANCIAL_SERVICE_SUBGRP_CODE, FINANCIAL_SERVICE_SUBGRP_DESC, UNIT_MEASURE_CODE, CLOSING_CATEGORY_DESC)
    VALUES (2, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), 'False', 'n/a', 'n/a', 'n/a','n/a','n/a','n/a','n/a','n/a');

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_financial_service_category (DIM_FINANCIAL_SERVICE_CATEGORY_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_LOGICAL_DELETE_FLAG, CONTROLLABLE_EXPENSE_CODE, FINANCIAL_SERVICE_DECISION_STEP, FINANCIAL_SERVICE_GROUP_CODE, FINANCIAL_SERVICE_GROUP_DESC, FINANCIAL_SERVICE_SUBGRP_CODE, FINANCIAL_SERVICE_SUBGRP_DESC, UNIT_MEASURE_CODE, CLOSING_CATEGORY_DESC)
SELECT tmp.DIM_FINANCIAL_SERVICE_CATEGORY_KEY, tmp.INSERT_DATETIME, tmp.LAST_UPDATED_DATETIME, tmp.IS_LOGICAL_DELETE_FLAG, tmp.CONTROLLABLE_EXPENSE_CODE, tmp.FINANCIAL_SERVICE_DECISION_STEP, tmp.FINANCIAL_SERVICE_GROUP_CODE, tmp.FINANCIAL_SERVICE_GROUP_DESC, tmp.FINANCIAL_SERVICE_SUBGRP_CODE, tmp.FINANCIAL_SERVICE_SUBGRP_DESC, tmp.UNIT_MEASURE_CODE, tmp.CLOSING_CATEGORY_DESC
FROM dimdata.tmp_dim_financial_service_category tmp
    LEFT JOIN dimdata.dim_financial_service_category tbl ON tbl.dim_financial_service_category_key = tmp.dim_financial_service_category_key
WHERE tbl.dim_financial_service_category_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_financial_service_category live_table
SET
live_table.DIM_FINANCIAL_SERVICE_CATEGORY_KEY = tmp.DIM_FINANCIAL_SERVICE_CATEGORY_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.CONTROLLABLE_EXPENSE_CODE = tmp.CONTROLLABLE_EXPENSE_CODE,
live_table.FINANCIAL_SERVICE_DECISION_STEP = tmp.FINANCIAL_SERVICE_DECISION_STEP,
live_table.FINANCIAL_SERVICE_GROUP_CODE = tmp.FINANCIAL_SERVICE_GROUP_CODE,
live_table.FINANCIAL_SERVICE_GROUP_DESC = tmp.FINANCIAL_SERVICE_GROUP_DESC,
live_table.FINANCIAL_SERVICE_SUBGRP_CODE = tmp.FINANCIAL_SERVICE_SUBGRP_CODE, 
live_table.FINANCIAL_SERVICE_SUBGRP_DESC = tmp.FINANCIAL_SERVICE_SUBGRP_DESC,
live_table.UNIT_MEASURE_CODE = tmp.UNIT_MEASURE_CODE,
live_table.CLOSING_CATEGORY_DESC = tmp.CLOSING_CATEGORY_DESC
FROM dimdata.tmp_dim_financial_service_category tmp
    WHERE live_table.dim_financial_service_category_KEY = tmp.dim_financial_service_category_KEY
;

SELECT 'Finished updating static data table dimdata.dim_financial_service_category';