
/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for util.RAWDATA_load_control
!set variable_substitution=true;
SELECT 'Updating static data table util.rawdata_load_control';
-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE UTIL.tmp_RAWDATA_LOAD_CONTROL
(
	RAWDATA_LOAD_CONTROL_HKEY VARCHAR(32) NOT NULL,
-- excluded from temp table   INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
-- excluded from temp table   LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    IS_ACTIVE BOOLEAN NOT NULL,
    DATA_DOMAIN_NAME VARCHAR NOT NULL COMMENT 'CLAIMS, MEMBER, PROVIDER, etc.',
    DATA_SOURCE_NAME VARCHAR NOT NULL COMMENT 'Skygen, MC400Dnt, MC400Upm, etc.',
    TARGET_TABLE_NAME VARCHAR NOT NULL COMMENT 'Target table name in RAWDATA schema',
    IS_CLONE_FLAG BOOLEAN NOT NULL COMMENT 'If true the target_table_name is created via a clone statment of the source_table_name',
    IS_COPY_INTO_FLAG BOOLEAN NOT NULL COMMENT 'If true the target_table_name is loaded via a copy into statement',
	IS_TRUNCATE_RELOAD_FLAG BOOLEAN NULL COMMENT 'When set to TRUE, the TARGET_TABLE_NAME will be truncated prior to COPY INTO',
	IS_PARQUET_FLAG BOOLEAN COMMENT 'Indicates IS_COPY_INTO_FLAG is for a parquet file',	
    SOURCE_CLONE_TABLE_NAME VARCHAR COMMENT 'Source database table to be cloned if IS_CLONE_FLAG equal true',
    SOURCE_FILE_STAGE_NAME VARCHAR COMMENT 'The STAGE name used in the COPY_INTO statement when IS_COPY_INTO_FLAG equal true',
    SOURCE_FILE_PATH VARCHAR COMMENT 'The file path in the stage used in the COPY_INTO statement when IS_COPY_INTO_FLAG equal true',
    SOURCE_FILE_FORMAT_NAME VARCHAR COMMENT 'The FILE FORMAT used in the COPY INTO statement when IS_COPY_INTO_FLAG equal true',
    SOURCE_FILE_PATTERN VARCHAR COMMENT 'The file PATTERN used in the COPY INTO statement when IS_COPY_INTO_FLAG equal true',
    SOURCE_FILE_DELIMITED_COLUMN_COUNT NUMBER (38,0) COMMENT 'The number of columns in the source file(s) that will be mapped in the COPY INTO statement',
    SOURCE_FILE_FIXED_WIDTH_MAPPING VARIANT COMMENT 'JSON data used for fixed width files to determine start position and length of column in source data',
    VALIDATE_DATA_FLAG BOOLEAN COMMENT 'If set to TRUE custom logic for the DATA_SOUCE_NAME will be executed to validate data',
	TRIM_FIXED_WIDTH_COLUMNS_FLAG BOOLEAN COMMENT 'Will add a TRIM() command to the select statement on a fixed width file',
    CONSTRAINT PK_RAWDATA_LOAD_CONTROL PRIMARY KEY (RAWDATA_LOAD_CONTROL_HKEY),
    CONSTRAINT UK_RAWDATA_LOAD_CONTROL UNIQUE (TARGET_TABLE_NAME)
);

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, by adding or removing files from the
-- subfolder in source control.

-- Create a tempory stage to upload the json files for loading to table
CREATE OR REPLACE TEMPORARY STAGE UTIL.RAWDATA_LOAD_CONTROL_STAGE
    FILE_FORMAT = UTIL.RAWDATA_LOAD_CONTROL_FILE_FORMAT;


--***************************************************************************************************************
--*************************************** IF YOU WANT TO RUN THIS LOCAL *****************************************
--***************************************************************************************************************
-- 1.) Right click on this file is VScode and click "Open in Integrated Terminal"
-- 2.) Copy the text from Line 6 and paste it in the terminal
-- 3.) Replace <your user name> with your username example: GENTILEGA
-- 4.) Hit Enter!
-- 5.) User: This is your network-id example: gentilega@upmc.edu
-- 6.) snowsql.exe --accountname UPMC-UPMCHP --authenticator externalbrowser --dbname UPMCHP_DATAHUB_LOCAL_<your user name> --variable drop_file_location=.. -f util.rawdata_load_control.sql
--***************************************************************************************************************

-- Display all the snowsql veriables for debugging
!variables;

-- PUT (copy files to internal stage) all JSON files under the rawdataLoadControl folder
PUT file://&drop_file_location\StaticData\rawdataLoadControl\*.json
    @UTIL.RAWDATA_LOAD_CONTROL_STAGE
    OVERWRITE = true;

--list the contents of the internal stage
list @UTIL.RAWDATA_LOAD_CONTROL_STAGE;

--Insert records into the temp table
INSERT INTO UTIL.tmp_RAWDATA_LOAD_CONTROL
	(
		RAWDATA_LOAD_CONTROL_HKEY, IS_ACTIVE, DATA_DOMAIN_NAME, DATA_SOURCE_NAME, TARGET_TABLE_NAME, IS_CLONE_FLAG, IS_COPY_INTO_FLAG, IS_TRUNCATE_RELOAD_FLAG, IS_PARQUET_FLAG,
		SOURCE_CLONE_TABLE_NAME, SOURCE_FILE_STAGE_NAME, SOURCE_FILE_PATH, SOURCE_FILE_FORMAT_NAME, SOURCE_FILE_PATTERN, SOURCE_FILE_DELIMITED_COLUMN_COUNT,
		SOURCE_FILE_FIXED_WIDTH_MAPPING, VALIDATE_DATA_FLAG, TRIM_FIXED_WIDTH_COLUMNS_FLAG
	)

SELECT
UTIL.FXN_ARRAY_HASH([$1:"targetTableName"::string]) AS RAWDATA_LOAD_CONTROL_HKEY
,$1:"isActive"::boolean AS IS_ACTIVE
,$1:"dataDomain"::string AS DATA_DOMAIN_NAME
,$1:"dataSourceName"::string AS DATA_SOURCE_NAME
,$1:"targetTableName"::string AS TARGET_TABLE_NAME
,$1:"isCloneFlag"::boolean AS IS_CLONE_FLAG
,$1:"isCopyIntoFlag"::boolean AS IS_COPY_INTO_FLAG
,$1:"isParquetFlag"::boolean AS IS_PARQUET_FLAG
,$1:"isTruncateReloadFlag"::boolean AS IS_TRUNCATE_RELOAD_FLAG
,$1:"sourceCloneTableName"::string AS SOURCE_CLONE_TABLE_NAME
,$1:"sourceFileStageName"::string AS SOURCE_FILE_STAGE_NAME
,$1:"sourceFilePath"::string AS SOURCE_FILE_PATH
,$1:"sourceFileFormatName"::string AS SOURCE_FILE_FORMAT_NAME
,$1:"sourceFilePattern"::string AS SOURCE_FILE_PATTERN
,$1:"sourceFileDelimitedColumnCount"::number AS SOURCE_FILE_DELIMITED_COLUMN_COUNT
,$1:"sourceFileFixedWidthMapping"::array AS SOURCE_FILE_FIXED_WIDTH_MAPPING
,$1:"validateDataFlag"::boolean AS VALIDATE_DATA_FLAG
,$1:"trimFixedWidthColumnsFlag"::boolean AS TRIM_FIXED_WIDTH_COLUMNS_FLAG

FROM @UTIL.RAWDATA_LOAD_CONTROL_STAGE
;

--Check for bad data in the temp table before merging
EXECUTE IMMEDIATE $$
DECLARE
  dup_primary_key_exception EXCEPTION (-20001, 'DUPLICATE Primary Keys Detected.');
  dup_unique_key_exception EXCEPTION (-20002, 'DUPLICATE Unique Keys Detected.');
  both_flag_exception EXCEPTION (-20003, 'IS_CLONE_FLAG and IS_COPY_INTO_FLAG cannot both be set to TRUE.');
  fixed_with_and_delimited_exception EXCEPTION (-20004, 'sourceFileDelimitedColumnCount and sourceFileFixedWidthMapping cannot both be specified.');
  parquet_exception EXCEPTION (-20004, 'isParquetFlag cannot be set to true if sourceFileDelimitedColumnCount or sourceFileFixedWidthMapping is specified.');    
  dup_count INTEGER;
BEGIN
    SELECT COUNT(1) INTO :dup_count 
        FROM(SELECT RAWDATA_LOAD_CONTROL_HKEY, COUNT(1) FROM UTIL.tmp_RAWDATA_LOAD_CONTROL GROUP BY RAWDATA_LOAD_CONTROL_HKEY HAVING COUNT(1) > 1);
    IF (dup_count > 0) THEN
    RAISE dup_primary_key_exception;
	END IF;

    SELECT COUNT(1) INTO :dup_count 
        FROM(SELECT TARGET_TABLE_NAME, COUNT(1) FROM UTIL.tmp_RAWDATA_LOAD_CONTROL GROUP BY TARGET_TABLE_NAME HAVING COUNT(1) > 1);
    IF (dup_count > 0) THEN
    RAISE dup_unique_key_exception;
	END IF;

    SELECT COUNT(1) INTO :dup_count 
        FROM UTIL.tmp_RAWDATA_LOAD_CONTROL WHERE IS_CLONE_FLAG = TRUE AND IS_COPY_INTO_FLAG = TRUE;
    IF (dup_count > 0) THEN
    RAISE both_flag_exception;
    END IF;
	
    SELECT COUNT(1) INTO :dup_count 
        FROM UTIL.tmp_RAWDATA_LOAD_CONTROL WHERE SOURCE_FILE_DELIMITED_COLUMN_COUNT IS NOT NULL AND SOURCE_FILE_FIXED_WIDTH_MAPPING IS NOT NULL;
    IF (dup_count > 0) THEN
    RAISE fixed_with_and_delimited_exception;
    END IF;

    SELECT COUNT(1) INTO :dup_count 
        FROM UTIL.tmp_RAWDATA_LOAD_CONTROL WHERE IS_PARQUET_FLAG = TRUE AND (SOURCE_FILE_DELIMITED_COLUMN_COUNT IS NOT NULL OR SOURCE_FILE_FIXED_WIDTH_MAPPING IS NOT NULL);
    IF (dup_count > 0) THEN
    RAISE parquet_exception;
    END IF;

END;
$$;

--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO UTIL.RAWDATA_LOAD_CONTROL AS TGT
USING (SELECT 
		RAWDATA_LOAD_CONTROL_HKEY, IS_ACTIVE, DATA_DOMAIN_NAME, DATA_SOURCE_NAME, TARGET_TABLE_NAME, IS_CLONE_FLAG, IS_COPY_INTO_FLAG, IS_TRUNCATE_RELOAD_FLAG, IS_PARQUET_FLAG,
		SOURCE_CLONE_TABLE_NAME, SOURCE_FILE_STAGE_NAME, SOURCE_FILE_PATH, SOURCE_FILE_FORMAT_NAME, SOURCE_FILE_PATTERN, SOURCE_FILE_DELIMITED_COLUMN_COUNT,
		SOURCE_FILE_FIXED_WIDTH_MAPPING, VALIDATE_DATA_FLAG, TRIM_FIXED_WIDTH_COLUMNS_FLAG
	FROM  UTIL.tmp_RAWDATA_LOAD_CONTROL
	MINUS 
	SELECT
		RAWDATA_LOAD_CONTROL_HKEY, IS_ACTIVE, DATA_DOMAIN_NAME, DATA_SOURCE_NAME, TARGET_TABLE_NAME, IS_CLONE_FLAG, IS_COPY_INTO_FLAG, IS_TRUNCATE_RELOAD_FLAG, IS_PARQUET_FLAG,
		SOURCE_CLONE_TABLE_NAME, SOURCE_FILE_STAGE_NAME, SOURCE_FILE_PATH, SOURCE_FILE_FORMAT_NAME, SOURCE_FILE_PATTERN, SOURCE_FILE_DELIMITED_COLUMN_COUNT,
		SOURCE_FILE_FIXED_WIDTH_MAPPING, VALIDATE_DATA_FLAG, TRIM_FIXED_WIDTH_COLUMNS_FLAG
	FROM UTIL.RAWDATA_LOAD_CONTROL
	) AS SRC

ON (tgt.RAWDATA_LOAD_CONTROL_HKEY = src.RAWDATA_LOAD_CONTROL_HKEY)

WHEN MATCHED 
THEN UPDATE
	SET 
	tgt.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
	,tgt.IS_ACTIVE = src.IS_ACTIVE	
	,tgt.DATA_DOMAIN_NAME = src.DATA_DOMAIN_NAME
	,tgt.DATA_SOURCE_NAME = src.DATA_SOURCE_NAME
	,tgt.TARGET_TABLE_NAME = src.TARGET_TABLE_NAME
	,tgt.IS_CLONE_FLAG = src.IS_CLONE_FLAG
	,tgt.IS_COPY_INTO_FLAG = src.IS_COPY_INTO_FLAG
	,tgt.IS_TRUNCATE_RELOAD_FLAG = src.IS_TRUNCATE_RELOAD_FLAG
	,tgt.IS_PARQUET_FLAG = src.IS_PARQUET_FLAG
	,tgt.SOURCE_CLONE_TABLE_NAME = src.SOURCE_CLONE_TABLE_NAME
	,tgt.SOURCE_FILE_STAGE_NAME = src.SOURCE_FILE_STAGE_NAME
	,tgt.SOURCE_FILE_PATH = src.SOURCE_FILE_PATH
	,tgt.SOURCE_FILE_FORMAT_NAME = src.SOURCE_FILE_FORMAT_NAME
	,tgt.SOURCE_FILE_PATTERN = src.SOURCE_FILE_PATTERN
	,tgt.SOURCE_FILE_DELIMITED_COLUMN_COUNT = src.SOURCE_FILE_DELIMITED_COLUMN_COUNT
	,tgt.SOURCE_FILE_FIXED_WIDTH_MAPPING = src.SOURCE_FILE_FIXED_WIDTH_MAPPING
	,tgt.VALIDATE_DATA_FLAG	= src.VALIDATE_DATA_FLAG	
	,tgt.TRIM_FIXED_WIDTH_COLUMNS_FLAG = src.TRIM_FIXED_WIDTH_COLUMNS_FLAG

WHEN NOT MATCHED 
THEN INSERT
	(
		RAWDATA_LOAD_CONTROL_HKEY
		,INSERT_DATETIME
		,LAST_UPDATED_DATETIME
		,IS_ACTIVE
		,DATA_DOMAIN_NAME
		,DATA_SOURCE_NAME
		,TARGET_TABLE_NAME
		,IS_CLONE_FLAG
		,IS_COPY_INTO_FLAG
		,IS_TRUNCATE_RELOAD_FLAG
		,IS_PARQUET_FLAG
		,SOURCE_CLONE_TABLE_NAME
		,SOURCE_FILE_STAGE_NAME
		,SOURCE_FILE_PATH
		,SOURCE_FILE_FORMAT_NAME
		,SOURCE_FILE_PATTERN
		,SOURCE_FILE_DELIMITED_COLUMN_COUNT
		,SOURCE_FILE_FIXED_WIDTH_MAPPING
		,VALIDATE_DATA_FLAG
		,TRIM_FIXED_WIDTH_COLUMNS_FLAG
	)
VALUES
	(
		src.RAWDATA_LOAD_CONTROL_HKEY
		,CURRENT_TIMESTAMP()
		,CURRENT_TIMESTAMP()
		,src.IS_ACTIVE
		,src.DATA_DOMAIN_NAME
		,src.DATA_SOURCE_NAME
		,src.TARGET_TABLE_NAME
		,src.IS_CLONE_FLAG
		,src.IS_COPY_INTO_FLAG
		,src.IS_TRUNCATE_RELOAD_FLAG
		,src.IS_PARQUET_FLAG
		,src.SOURCE_CLONE_TABLE_NAME
		,src.SOURCE_FILE_STAGE_NAME
		,src.SOURCE_FILE_PATH
		,src.SOURCE_FILE_FORMAT_NAME
		,src.SOURCE_FILE_PATTERN
		,src.SOURCE_FILE_DELIMITED_COLUMN_COUNT
		,src.SOURCE_FILE_FIXED_WIDTH_MAPPING
		,src.VALIDATE_DATA_FLAG
		,src.TRIM_FIXED_WIDTH_COLUMNS_FLAG
	)
;
	
--Flip the minus and delete from the target
DELETE FROM UTIL.RAWDATA_LOAD_CONTROL TGT
USING
(SELECT RAWDATA_LOAD_CONTROL_HKEY
	FROM UTIL.RAWDATA_LOAD_CONTROL
	MINUS 
	SELECT RAWDATA_LOAD_CONTROL_HKEY
	FROM UTIL.tmp_RAWDATA_LOAD_CONTROL
	) SRC
WHERE tgt.RAWDATA_LOAD_CONTROL_HKEY = src.RAWDATA_LOAD_CONTROL_HKEY
;

SELECT 'Finished updating static data table util.rawdata_load_control';
!set variable_substitution=false;