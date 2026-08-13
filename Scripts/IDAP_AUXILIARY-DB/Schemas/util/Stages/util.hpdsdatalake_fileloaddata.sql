!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_FILELOADDATA
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/fileloaddata'
    COMMENT = 'Staging area for flat file uploads to IDAP_LAKE'
;

!set variable_substitution=false;