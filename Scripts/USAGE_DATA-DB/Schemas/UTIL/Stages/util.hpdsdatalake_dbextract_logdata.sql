!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.SNOWFLAKEDATA_USAGE_DATA_DB_EXTRACT
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract'
;
!set variable_substitution=false;


