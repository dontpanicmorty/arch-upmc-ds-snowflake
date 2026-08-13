!set variable_substitution=true;
 
CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_DEPTLAKE_USAGE_DATA
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/deptlake'
;
!set variable_substitution=false;