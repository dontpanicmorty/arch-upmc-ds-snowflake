/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for util.EXTRACTDATA_LOAD_CONTROL

SELECT 'Updating static data table util.EXTRACTDATA_LOAD_CONTROL';

-- 1: Define table variable
CREATE OR REPLACE temporary TABLE UTIL.tmp_EXTRACTDATA_LOAD_CONTROL
(
	EXTRACTDATA_LOAD_CONTROL_HKEY VARCHAR(32) NULL, -- NULLABLE on purpose here, to make the insert statements below cleaner
    IS_ACTIVE BOOLEAN NOT NULL,
    DATA_DOMAIN_NAME VARCHAR NOT NULL COMMENT 'claim, member, provider, etc.',
    RUN_GROUP_NBR NUMBER(38,0) NOT NULL COMMENT 'Grouping of tables to be loaded, mostly will just be 0, no group',
    RUN_ORDER_NBR NUMBER(38,0) NOT NULL COMMENT 'Order to process the table loads, they run sequential',
    PROCEDURE_NAME VARCHAR NOT NULL COMMENT 'Example: HUBDATA.SPU_LOAD_HUB_CLAIM',
    --CONSTRAINT PK_EXTRACTDATA_LOAD_CONTROL PRIMARY KEY (EXTRACTDATA_LOAD_CONTROL_HKEY), -- NULLABLE on purpose here, to make the insert statements below cleaner
    CONSTRAINT UK_EXTRACTDATA_LOAD_CONTROL UNIQUE (PROCEDURE_NAME)
)
;

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO UTIL.tmp_EXTRACTDATA_LOAD_CONTROL (IS_ACTIVE, DATA_DOMAIN_NAME, RUN_GROUP_NBR, RUN_ORDER_NBR, PROCEDURE_NAME)
VALUES 
(true, 'member', 0, 1, 'EXTRACTDATA.SPU_LOAD_MEMBER_ADDRESS_BASE')
,(true, 'member', 0, 1, 'EXTRACTDATA.SPU_LOAD_MEMBER_DETAIL_BASE')
,(true, 'member', 0, 1, 'EXTRACTDATA.SPU_LOAD_PLAN_BASE')
,(true, 'claim', 0, 1, 'EXTRACTDATA.SPU_LOAD_CLAIM_HEADER_BILLING_PROVIDER')
,(true, 'claim', 0, 2, 'EXTRACTDATA.SPU_LOAD_CLAIM_HEADER_REFERRING_PROVIDER')
,(true, 'claim', 0, 3, 'EXTRACTDATA.SPU_LOAD_CLAIM_HEADER_RIDER_ARRAY')
;

--Set the HKEY for all the records in the temp table.
UPDATE UTIL.tmp_EXTRACTDATA_LOAD_CONTROL
SET EXTRACTDATA_LOAD_CONTROL_HKEY = UTIL.FXN_ARRAY_HASH([PROCEDURE_NAME])
;

--Check for bad data in the temp table before merging
EXECUTE IMMEDIATE $$
DECLARE
  dup_primary_key_exception EXCEPTION (-20001, 'DUPLICATE Primary Keys Detected.');
  dup_unique_key_exception EXCEPTION (-20002, 'DUPLICATE Unique Keys Detected.');
  dup_count INTEGER;
BEGIN
    SELECT COUNT(1) INTO :dup_count 
        FROM(SELECT EXTRACTDATA_LOAD_CONTROL_HKEY, COUNT(1) FROM UTIL.tmp_EXTRACTDATA_LOAD_CONTROL GROUP BY EXTRACTDATA_LOAD_CONTROL_HKEY HAVING COUNT(1) > 1);
    IF (dup_count > 0) THEN
    RAISE dup_primary_key_exception;
	END IF;

    SELECT COUNT(1) INTO :dup_count 
        FROM(SELECT PROCEDURE_NAME, COUNT(1) FROM UTIL.tmp_EXTRACTDATA_LOAD_CONTROL GROUP BY PROCEDURE_NAME HAVING COUNT(1) > 1);
    IF (dup_count > 0) THEN
    RAISE dup_unique_key_exception;
	END IF;
END;
$$;

--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO UTIL.EXTRACTDATA_LOAD_CONTROL AS tgt
USING (SELECT EXTRACTDATA_LOAD_CONTROL_HKEY, IS_ACTIVE, DATA_DOMAIN_NAME, RUN_GROUP_NBR, RUN_ORDER_NBR, PROCEDURE_NAME
	FROM  UTIL.tmp_EXTRACTDATA_LOAD_CONTROL
	MINUS 
	SELECT EXTRACTDATA_LOAD_CONTROL_HKEY, IS_ACTIVE, DATA_DOMAIN_NAME, RUN_GROUP_NBR, RUN_ORDER_NBR, PROCEDURE_NAME
	FROM UTIL.EXTRACTDATA_LOAD_CONTROL
	) AS SRC

ON (tgt.EXTRACTDATA_LOAD_CONTROL_HKEY = SRC.EXTRACTDATA_LOAD_CONTROL_HKEY)

WHEN MATCHED 
THEN UPDATE
	SET 
	tgt.IS_ACTIVE = SRC.IS_ACTIVE
	,tgt.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
WHEN NOT MATCHED 
THEN INSERT
	(
		EXTRACTDATA_LOAD_CONTROL_HKEY
		,INSERT_DATETIME
		,LAST_UPDATED_DATETIME
		,IS_ACTIVE
		,DATA_DOMAIN_NAME
		,RUN_GROUP_NBR
		,RUN_ORDER_NBR
		,PROCEDURE_NAME
	)
VALUES
	(
		src.EXTRACTDATA_LOAD_CONTROL_HKEY
		,CURRENT_TIMESTAMP()
		,CURRENT_TIMESTAMP()
		,src.IS_ACTIVE
		,src.DATA_DOMAIN_NAME
		,src.RUN_GROUP_NBR
		,src.RUN_ORDER_NBR
		,src.PROCEDURE_NAME
	)
;
	
--Flip the minus and delete from the target
DELETE FROM UTIL.EXTRACTDATA_LOAD_CONTROL tgt
USING
(SELECT EXTRACTDATA_LOAD_CONTROL_HKEY
	FROM UTIL.EXTRACTDATA_LOAD_CONTROL
	MINUS 
	SELECT EXTRACTDATA_LOAD_CONTROL_HKEY
	FROM UTIL.tmp_EXTRACTDATA_LOAD_CONTROL
	) SRC
WHERE tgt.EXTRACTDATA_LOAD_CONTROL_HKEY = SRC.EXTRACTDATA_LOAD_CONTROL_HKEY
;

SELECT 'Finished updating static data table util.EXTRACTDATA_LOAD_CONTROL';
