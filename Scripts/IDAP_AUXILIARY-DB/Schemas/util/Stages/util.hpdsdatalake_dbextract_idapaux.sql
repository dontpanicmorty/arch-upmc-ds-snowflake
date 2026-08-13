!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_DBEXTRACT_IDAPAUX
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract/'
    COMMENT = 'Staging area for db extracts'
	;
!set variable_substitution=false;