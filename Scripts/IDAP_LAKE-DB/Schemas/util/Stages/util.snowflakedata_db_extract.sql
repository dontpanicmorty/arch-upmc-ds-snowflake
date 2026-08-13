!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.SNOWFLAKEDATA_DB_EXTRACT
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract/'
    COMMENT = 'Staging area for db extracts'
	;
!set variable_substitution=false;