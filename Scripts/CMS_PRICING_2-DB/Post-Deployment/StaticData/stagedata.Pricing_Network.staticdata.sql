/***************************************
***   Static data management script  ***
***************************************/
-- This script will manage the static data from for stagedata.PRICING_NETWORK
SELECT
    'Updating static data table stagedata.PRICING_NETWORK';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE STAGEDATA.TMP_PRICING_NETWORK (
    PRICING_NETWORK_KEY INT NOT NULL,
    PRICING_NETWORK_NAME VARCHAR NOT NULL,
    PRICING_NETWORK_DISPLAY_NAME VARCHAR NOT NULL,
    LAST_UPDATED_DATETIME DATETIME NOT NULL,
    LAST_UPDATED_USER_NAME VARCHAR NOT NULL
);

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        1,
        'PARTNER',
        'UPMC Partner Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        2,
        'SELECT',
        'UPMC Select Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        3,
        'STANDARD',
        'UPMC Standard Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        4,
        'PREMIUM',
        'Premium Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        5,
        'ENHANCED ACCESS',
        'Enhanced Access Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        6,
        'TOTAL ADVANTAGE',
        'Total Advantage Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

INSERT INTO
    STAGEDATA.TMP_PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
VALUES
    (
        7,
        'UPMC EMPLOYEES',
        'UPMC Employees Advantage Network',
        CURRENT_TIMESTAMP(),
        'SMITHWP'
    );

-- 3: Insert any new items into the table from the table variable
INSERT INTO
    STAGEDATA.PRICING_NETWORK (
        PRICING_NETWORK_KEY,
        PRICING_NETWORK_NAME,
        PRICING_NETWORK_DISPLAY_NAME,
        LAST_UPDATED_DATETIME,
        LAST_UPDATED_USER_NAME
    )
SELECT
    TMP.PRICING_NETWORK_KEY,
    TMP.PRICING_NETWORK_NAME,
    TMP.PRICING_NETWORK_DISPLAY_NAME,
    TMP.LAST_UPDATED_DATETIME,
    TMP.LAST_UPDATED_USER_NAME
FROM
    STAGEDATA.TMP_PRICING_NETWORK TMP
    LEFT JOIN STAGEDATA.PRICING_NETWORK TBL ON TBL.PRICING_NETWORK_KEY = TMP.PRICING_NETWORK_KEY
WHERE
    TBL.PRICING_NETWORK_KEY IS NULL;

-- 4: Update any modified values with the values from the table variable
UPDATE STAGEDATA.PRICING_NETWORK LIVE_TABLE
SET
    LIVE_TABLE.PRICING_NETWORK_NAME = TMP.PRICING_NETWORK_NAME,
    LIVE_TABLE.PRICING_NETWORK_DISPLAY_NAME = TMP.PRICING_NETWORK_DISPLAY_NAME,
    LIVE_TABLE.LAST_UPDATED_DATETIME = TMP.LAST_UPDATED_DATETIME,
    LIVE_TABLE.LAST_UPDATED_USER_NAME = TMP.LAST_UPDATED_USER_NAME
FROM
    STAGEDATA.TMP_PRICING_NETWORK TMP
WHERE
    LIVE_TABLE.PRICING_NETWORK_KEY = TMP.PRICING_NETWORK_KEY;

-- 5: Delete any missing records from the target
/* commented out for now since it doesn't work quite right
DELETE FROM stagedata.PRICING_NETWORK FROM stagedata.PRICING_NETWORK LiveTable
LEFT JOIN stagedata.tmp_PRICING_NETWORK tmp ON LiveTable.PRICING_NETWORK_KEY = tmp.PRICING_NETWORK_KEY
WHERE tmp.PRICING_NETWORK_KEY IS NULL;
*/
SELECT
    'Finished updating static data table stagedata.PRICING_NETWORK';