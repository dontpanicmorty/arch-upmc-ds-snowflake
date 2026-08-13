CREATE OR REPLACE TABLE UTIL.RAWDATA_LOAD_CONTROL
(
    RAWDATA_LOAD_CONTROL_HKEY VARCHAR(32) NOT NULL,
    INSERT_DATETIME TIMESTAMP_TZ(9) NOT NULL,
    LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) NOT NULL,
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
)
COMMENT = 'Control table to load data into tables in the RAWDATA Schema'
;