!set variable_substitution=true;
CREATE OR REPLACE STAGE UTIL.SNOWFLAKEDATA_AE2_OUTGOING
    STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/outgoing/'
    COMMENT = 'Outgoing directory for Snowflake Data Lake Azure East 2'
    ;
!set variable_substitution=false;