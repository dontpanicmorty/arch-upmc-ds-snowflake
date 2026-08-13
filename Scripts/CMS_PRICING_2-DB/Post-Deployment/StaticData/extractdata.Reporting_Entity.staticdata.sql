/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for extractdata.REPORTING_ENTITY

SELECT 'Updating static data table extractdata.REPORTING_ENTITY';


-- 1: Define table variable
create or replace temporary table extractdata.tmp_REPORTING_ENTITY
(	
  REPORTING_ENTITY_KEY INT  NOT NULL,
  REPORTING_ENTITY_NAME VARCHAR NOT NULL,
  REPORTING_ENTITY_TYPE VARCHAR NOT NULL,
  BASE_URL VARCHAR NOT NULL,
  URL_DOMAIN_NAME VARCHAR NOT NULL,
  UPMC_REPORTING_ENTITY_NAME VARCHAR NOT NULL
)
;

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO extractdata.tmp_REPORTING_ENTITY (REPORTING_ENTITY_KEY, REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME, UPMC_REPORTING_ENTITY_NAME)
VALUES (
  1, 
  'horwitzar test', 
  'medicare', 
  'http://ahwitz.com/tic_test/toc/', 
  'http://ahwitz.com/', 
  'horwitzar test'
);

INSERT INTO extractdata.tmp_REPORTING_ENTITY (REPORTING_ENTITY_KEY, REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME, UPMC_REPORTING_ENTITY_NAME)
VALUES (
  3, 
  'UPMC Health Plan', 
  'Health Insurance Issuer', 
  'https://content.upmchp.com/publicweb/table-of-contents/', 
  'https://content.upmchp.com/', 
  'UPMC Health Plan'
);

INSERT INTO extractdata.tmp_REPORTING_ENTITY (REPORTING_ENTITY_KEY, REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME, UPMC_REPORTING_ENTITY_NAME)
VALUES (
  4, 
  'Highmark Blue Shield Pennsylvania', 
  'Health Insurance Network', 
  'https://mrfdata.hmhs.com/files/378/pa/inbound/local/', 
  'https://mrfdata.hmhs.com/', 
  'Highmark Blue Shield Pennsylvania'
);

INSERT INTO extractdata.tmp_REPORTING_ENTITY (REPORTING_ENTITY_KEY, REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME, UPMC_REPORTING_ENTITY_NAME)
VALUES (
  5, 
  'Highmark Blue Cross Blue Shield Pennsylvania', 
  'Health Insurance Network', 
  'https://mrfdata.hmhs.com/files/363/pa/inbound/local/', 
  'https://mrfdata.hmhs.com/', 
  'Highmark Blue Cross Blue Shield Pennsylvania'
);

-- 3: Insert any new items into the table from the table variable
INSERT INTO extractdata.REPORTING_ENTITY (REPORTING_ENTITY_KEY, REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME, UPMC_REPORTING_ENTITY_NAME)
SELECT tmp.REPORTING_ENTITY_KEY, tmp.REPORTING_ENTITY_NAME, tmp.REPORTING_ENTITY_TYPE, tmp.BASE_URL, tmp.URL_DOMAIN_NAME, tmp.UPMC_REPORTING_ENTITY_NAME
FROM extractdata.tmp_REPORTING_ENTITY tmp
    LEFT JOIN extractdata.REPORTING_ENTITY tbl ON tbl.REPORTING_ENTITY_KEY = tmp.REPORTING_ENTITY_KEY
WHERE tbl.REPORTING_ENTITY_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
UPDATE extractdata.REPORTING_ENTITY live_table
SET live_table.REPORTING_ENTITY_NAME = tmp.REPORTING_ENTITY_NAME
  ,live_table.REPORTING_ENTITY_TYPE = tmp.REPORTING_ENTITY_TYPE
  ,live_table.BASE_URL = tmp.BASE_URL
  ,live_table.URL_DOMAIN_NAME = tmp.URL_DOMAIN_NAME
  ,live_table.UPMC_REPORTING_ENTITY_NAME = tmp.UPMC_REPORTING_ENTITY_NAME
FROM extractdata.tmp_REPORTING_ENTITY tmp
    WHERE live_table.REPORTING_ENTITY_KEY = tmp.REPORTING_ENTITY_KEY
;

-- 5: Delete any missing records from the target

/* commented out for now since it doesn't work quite right
	DELETE FROM stagedata.REPORTING_ENTITY LiveTable
	LEFT JOIN stagedata.REPORTING_ENTITY tmp ON LiveTable.REPORTING_ENTITY_KEY = tmp.REPORTING_ENTITY_KEY
	WHERE tmp.REPORTING_ENTITY_KEY IS NULL;
*/



SELECT 'Finished updating static data table extractdata.REPORTING_ENTITY';