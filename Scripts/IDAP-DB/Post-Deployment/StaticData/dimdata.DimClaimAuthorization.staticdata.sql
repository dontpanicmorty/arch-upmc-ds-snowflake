/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for dimdata.dim_claim_authorization

SELECT 'Updating static data table dimdata.dim_claim_authorization';

-- 1: Define table variable
create or replace temporary table dimdata.tmp_dim_claim_authorization
(
    DIM_CLAIM_AUTHORIZATION_KEY INTEGER NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_LOGICAL_DELETE_FLAG BOOLEAN NOT NULL,
    TPA_CLIENT_ID VARCHAR NOT NULL,
    TPA_ID VARCHAR NOT NULL,
    TPA_DIV_ID VARCHAR NOT NULL,
    DATA_SOURCE_NAME VARCHAR NOT NULL,
    AUTHORIZATION_NBR VARCHAR NOT NULL,
    CARE_TYPE_NAME VARCHAR,
    STATUS_DESC VARCHAR,
    DETERMINATION_STATUS_DESC VARCHAR,
    DETERMINATION_DATE DATE,
    MEDICAL_GROUP_ADDRESS_LINE_1 VARCHAR,
    MEDICAL_GROUP_ADDRESS_LINE_2 VARCHAR,
    MEDICAL_GROUP_CITY VARCHAR,
    MEDICAL_GROUP_STATE_ABBREV_NAME VARCHAR,
    MEDICAL_GROUP_ZIP_CODE VARCHAR,
    MEDICAL_GROUP_PRIMARY_PHONE_NBR VARCHAR
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO dimdata.TMP_dim_claim_authorization
    (DIM_CLAIM_AUTHORIZATION_KEY,
    INSERT_DATETIME,
    LAST_UPDATED_DATETIME,
    IS_LOGICAL_DELETE_FLAG,
    TPA_CLIENT_ID,
    TPA_ID,
    TPA_DIV_ID,
    DATA_SOURCE_NAME,
    AUTHORIZATION_NBR,
    CARE_TYPE_NAME,
    STATUS_DESC,
    DETERMINATION_STATUS_DESC,
    DETERMINATION_DATE,
    MEDICAL_GROUP_ADDRESS_LINE_1,
    MEDICAL_GROUP_ADDRESS_LINE_2,
    MEDICAL_GROUP_CITY,
    MEDICAL_GROUP_STATE_ABBREV_NAME,
    MEDICAL_GROUP_ZIP_CODE,
    MEDICAL_GROUP_PRIMARY_PHONE_NBR
)
    VALUES
(1,
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
    FALSE,
 'Unknown',
 'Unknown',
 'Unknown',
 'Unknown',
 'Unknown',
 'Unknown',
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL
);

INSERT INTO dimdata.TMP_dim_claim_authorization
    (DIM_CLAIM_AUTHORIZATION_KEY,
    INSERT_DATETIME,
    LAST_UPDATED_DATETIME,
    IS_LOGICAL_DELETE_FLAG,
    TPA_CLIENT_ID,
    TPA_ID,
    TPA_DIV_ID,
    DATA_SOURCE_NAME,
    AUTHORIZATION_NBR,
    CARE_TYPE_NAME,
    STATUS_DESC,
    DETERMINATION_STATUS_DESC,
    DETERMINATION_DATE,
    MEDICAL_GROUP_ADDRESS_LINE_1,
    MEDICAL_GROUP_ADDRESS_LINE_2,
    MEDICAL_GROUP_CITY,
    MEDICAL_GROUP_STATE_ABBREV_NAME,
    MEDICAL_GROUP_ZIP_CODE,
    MEDICAL_GROUP_PRIMARY_PHONE_NBR
)
    VALUES
(2,
 CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(),
    FALSE,
 'n/a',
 'n/a',
 'n/a',
 'n/a',
 'n/a',
 'n/a',
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL,
 NULL
);

-- 3: Insert any new items into the table from the table variable
INSERT INTO dimdata.dim_claim_authorization 
(DIM_CLAIM_AUTHORIZATION_KEY,
    INSERT_DATETIME,
    LAST_UPDATED_DATETIME,
    IS_LOGICAL_DELETE_FLAG,
    TPA_CLIENT_ID,
    TPA_ID,
    TPA_DIV_ID,
    DATA_SOURCE_NAME,
    AUTHORIZATION_NBR,
    CARE_TYPE_NAME,
    STATUS_DESC,
    DETERMINATION_STATUS_DESC,
    DETERMINATION_DATE,
    MEDICAL_GROUP_ADDRESS_LINE_1,
    MEDICAL_GROUP_ADDRESS_LINE_2,
    MEDICAL_GROUP_CITY,
    MEDICAL_GROUP_STATE_ABBREV_NAME,
    MEDICAL_GROUP_ZIP_CODE,
    MEDICAL_GROUP_PRIMARY_PHONE_NBR)

SELECT tmp.DIM_CLAIM_AUTHORIZATION_KEY,
    tmp.INSERT_DATETIME,
    tmp.LAST_UPDATED_DATETIME,
    tmp.IS_LOGICAL_DELETE_FLAG,
    tmp.TPA_CLIENT_ID,
    tmp.TPA_ID,
    tmp.TPA_DIV_ID,
    tmp.DATA_SOURCE_NAME,
    tmp.AUTHORIZATION_NBR,
    tmp.CARE_TYPE_NAME,
    tmp.STATUS_DESC,
    tmp.DETERMINATION_STATUS_DESC,
    tmp.DETERMINATION_DATE,
    tmp.MEDICAL_GROUP_ADDRESS_LINE_1,
    tmp.MEDICAL_GROUP_ADDRESS_LINE_2,
    tmp.MEDICAL_GROUP_CITY,
    tmp.MEDICAL_GROUP_STATE_ABBREV_NAME,
    tmp.MEDICAL_GROUP_ZIP_CODE,
    tmp.MEDICAL_GROUP_PRIMARY_PHONE_NBR
FROM dimdata.tmp_dim_claim_authorization tmp
    LEFT JOIN dimdata.dim_claim_authorization tbl ON tbl.dim_claim_authorization_key = tmp.dim_claim_authorization_key
WHERE tbl.dim_claim_authorization_key IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE dimdata.dim_claim_authorization live_table
SET
live_table.DIM_CLAIM_AUTHORIZATION_KEY = tmp.DIM_CLAIM_AUTHORIZATION_KEY,
live_table.INSERT_DATETIME = tmp.INSERT_DATETIME,
live_table.LAST_UPDATED_DATETIME = tmp.LAST_UPDATED_DATETIME,
live_table.IS_LOGICAL_DELETE_FLAG = tmp.IS_LOGICAL_DELETE_FLAG,
live_table.TPA_CLIENT_ID = tmp.TPA_CLIENT_ID,
live_table.TPA_ID = tmp.TPA_ID,
live_table.TPA_DIV_ID = tmp.TPA_DIV_ID,
live_table.DATA_SOURCE_NAME = tmp.DATA_SOURCE_NAME,
live_table.AUTHORIZATION_NBR = tmp.AUTHORIZATION_NBR,
live_table.CARE_TYPE_NAME = tmp.CARE_TYPE_NAME,
live_table.STATUS_DESC = tmp.STATUS_DESC,
live_table.DETERMINATION_STATUS_DESC = tmp.DETERMINATION_STATUS_DESC,
live_table.DETERMINATION_DATE = tmp.DETERMINATION_DATE,
live_table.MEDICAL_GROUP_ADDRESS_LINE_1 = tmp.MEDICAL_GROUP_ADDRESS_LINE_1,
live_table.MEDICAL_GROUP_ADDRESS_LINE_2 = tmp.MEDICAL_GROUP_ADDRESS_LINE_2,
live_table.MEDICAL_GROUP_CITY = tmp.MEDICAL_GROUP_CITY,
live_table.MEDICAL_GROUP_STATE_ABBREV_NAME = tmp.MEDICAL_GROUP_STATE_ABBREV_NAME,
live_table.MEDICAL_GROUP_ZIP_CODE = tmp.MEDICAL_GROUP_ZIP_CODE,
live_table.MEDICAL_GROUP_PRIMARY_PHONE_NBR = tmp.MEDICAL_GROUP_PRIMARY_PHONE_NBR
FROM dimdata.tmp_dim_claim_authorization tmp
    WHERE live_table.dim_claim_authorization_KEY = tmp.dim_claim_authorization_KEY
;

SELECT 'Finished updating static data table dimdata.dim_claim_authorization';