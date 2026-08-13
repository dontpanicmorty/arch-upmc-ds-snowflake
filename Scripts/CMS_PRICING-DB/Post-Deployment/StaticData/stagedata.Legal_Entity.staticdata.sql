/***************************************
***   Static data management script  ***
***************************************/
-- This Script will manage the static data for stagedta.LEGAL_ENTITY
SELECT 'Updating static data table stagedata.LEGAL_ENTITY';
-- 1: Define table variable
create or replace temporary table stagedata.tmp_LEGAL_ENTITY
( 
    LEGAL_ENTITY_KEY  INT     NOT NULL,
    LEGAL_ENTITY      VARCHAR NOT NULL,
    TIN_FEIN          VARCHAR NOT NULL,
    PAYEE_GROUP       VARCHAR,
    NAIC_COMPANY_CODE VARCHAR,
    ISSUER_HIOS_ID    VARCHAR,
    PLAN_YEAR_2025    VARCHAR,
    PLAN_YEAR_2026    VARCHAR,
    NOTES             VARCHAR

);
-- 2: Populate the table variable with data
-- Row 1
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES)
VALUES( 
    1, 
    'UPMC Health Plan',
    '23-2813536',
    'A235001',
    '95216',
    '52899',
    'No Products Available',
    'Yes, Individual and Small Group',
    NULL
);
-- Row  2 
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES)
VALUES( 
    2, 
    'UPMC Health Network',
    '72-1527566',
    'A236001',
    '11994',
    '16481',
    'No Products Available',
    'No Products Available',
    NULL
);

-- Row 3 
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES) 
VALUES(
    3, 
    'UPMC Health Benefits',
    '25-1844144',
    'A35501',
    '11018',
    '67430',
    'Yes, Small Group',
    'Yes, Small Group',
    NULL
);
 
-- Row 4 
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES) 
VALUES( 
    4, 
    'UPMC Health Options',
    '46-2824626',
    'A347001',
    '15345',
    '16322',
    'Yes, Individual and Small Group',
    'Yes, Individual and Small Group',
    'Individual Plans have and will continued be offered On and Off Exchange.'
);

-- Row 5 
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES) 
VALUES( 
    5, 
    'UPMC Health Coverage',
    '46-2824537',
    'A346001',
    '15451',
    '62560',
    'Yes, Individual and Small Group',
    'No Prodcuts Avaliable',
    'Starting in PY2021 and beyond Individual Plans are currently offered both On and Off Exchange Starting in PY2026, plans are transitioning under 52899'
);

-- Row 6 
INSERT INTO stagedata.tmp_LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES) 
VALUES( 
    6, 
    'UPMC Work Alliance ',
    '45-2825053',
    NULL,
    '14485',
    '24008',
    'No Products Available',
    'No Products Available',
    NULL
);

-- 3: Insert any new items into the table from the table variable
INSERT INTO stagedata.LEGAL_ENTITY (LEGAL_ENTITY_KEY, LEGAL_ENTITY, TIN_FEIN, PAYEE_GROUP, NAIC_COMPANY_CODE, ISSUER_HIOS_ID, PLAN_YEAR_2025, PLAN_YEAR_2026, NOTES)
SELECT
    tmp.LEGAL_ENTITY_KEY,
    tmp.LEGAL_ENTITY,
    tmp.TIN_FEIN, 
    tmp.PAYEE_GROUP,
    tmp.NAIC_COMPANY_CODE,
    tmp.ISSUER_HIOS_ID,
    tmp.PLAN_YEAR_2025,
    tmp.PLAN_YEAR_2026,
    tmp.NOTES

FROM stagedata.tmp_LEGAL_ENTITY tmp 
LEFT JOIN stagedata.LEGAL_ENTITY tbl 
    ON tbl.LEGAL_ENTITY_KEY = tmp.LEGAL_ENTITY_KEY
WHERE tbl.LEGAL_ENTITY_KEY IS NULL;

-- 4: Update any modified values with the values from the table variable
UPDATE stagedata.LEGAL_ENTITY live_table
SET live_table.LEGAL_ENTITY          = tmp.LEGAL_ENTITY,
    live_table.TIN_FEIN              = tmp.TIN_FEIN,
    live_table.PAYEE_GROUP           = tmp.PAYEE_GROUP,
    live_table.NAIC_COMPANY_CODE     = tmp.NAIC_COMPANY_CODE,
    live_table.ISSUER_HIOS_ID        = tmp.ISSUER_HIOS_ID,
    live_table.PLAN_YEAR_2025        = tmp.PLAN_YEAR_2025,
    live_table.PLAN_YEAR_2026        = tmp.PLAN_YEAR_2026,
    live_table.NOTES                 = tmp.NOTES
    
FROM stagedata.tmp_LEGAL_ENTITY tmp
    WHERE live_table.LEGAL_ENTITY_KEY = tmp.LEGAL_ENTITY_KEY;

-- 5: Delete any missing records from the target

/* commented out for now, remove the comment if needed
	DELETE FROM stagedata.LEGAL_ENTITY LiveTable
	LEFT JOIN stagedata.tmp_LEGAL_ENTITY tmp
        ON LiveTable.LEGAL_ENTITY_KEY = tmp.LEGAL_ENTITY_KEY
	WHERE tmp.LEGAL_ENTITY_KEY IS NULL;
*/
-- Insert only new LEGAL_ENTITY_KEY values that are not already in STAGEDATA.LEGAL_ENTITY

SELECT 'Finished updating static data table stagedata.LEGAL_ENTITY';