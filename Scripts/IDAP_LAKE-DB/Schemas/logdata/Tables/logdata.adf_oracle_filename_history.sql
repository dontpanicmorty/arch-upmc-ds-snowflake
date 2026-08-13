create or replace TABLE LOGDATA.ADF_ORACLE_FILENAME_LOAD_HISTORY 
    (
        FILENAME VARCHAR,  
        LOAD_DATETIME TIMESTAMP_TZ(9)
    )COMMENT='Logging table for loaded filenames and dates' ;