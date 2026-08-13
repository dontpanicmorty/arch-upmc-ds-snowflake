/***************************************
***   Static data management script  ***
***************************************/
-- This script will manage the static data from for healthsparq.FILE_VERSIONS
SELECT
  'Updating static data table healthsparq_2.FILE_VERSIONS';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY INT NOT NULL, FILE_NAME VARCHAR NOT NULL, FILE_VERSION VARCHAR NOT NULL);

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (1, 'LEASED_NETWORKS_MAPPING', '4.6');

INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (
    2,
    'OON_Region_XWalk', -- Intentionally lower-case per Healthsparq's specs
    '4.6'
  );

INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (3, 'OUTOFNETWORK_ALLOWED_AMOUNT', '4.6');

INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (4, 'PLAN_DETAILS', '4.6');

INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (5, 'POS_MAPPING', '4.6');

INSERT INTO
  HEALTHSPARQ_2.TMP_FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
VALUES
  (6, 'provider-reference', '2.0.0');

-- 3: Insert any new items into the table from the table variable
INSERT INTO
  HEALTHSPARQ_2.FILE_VERSIONS (FILE_VERSIONS_KEY, FILE_NAME, FILE_VERSION)
SELECT
  TMP.FILE_VERSIONS_KEY,
  TMP.FILE_NAME,
  TMP.FILE_VERSION
FROM
  HEALTHSPARQ_2.TMP_FILE_VERSIONS TMP
  LEFT JOIN HEALTHSPARQ_2.FILE_VERSIONS TBL ON TBL.FILE_VERSIONS_KEY = TMP.FILE_VERSIONS_KEY
WHERE
  TBL.FILE_VERSIONS_KEY IS NULL;

-- 4: Update any modified values with the values from the table variable
UPDATE HEALTHSPARQ_2.FILE_VERSIONS LIVE_TABLE
SET
  LIVE_TABLE.FILE_NAME = TMP.FILE_NAME,
  LIVE_TABLE.FILE_VERSION = TMP.FILE_VERSION
FROM
  HEALTHSPARQ_2.TMP_FILE_VERSIONS TMP
WHERE
  LIVE_TABLE.FILE_VERSIONS_KEY = TMP.FILE_VERSIONS_KEY;

-- 5: Delete any missing records from the target
/* commented out for now since it doesn't work quite right
*/
SELECT
  'Finished updating static data table healthsparq.FILE_VERSIONS';