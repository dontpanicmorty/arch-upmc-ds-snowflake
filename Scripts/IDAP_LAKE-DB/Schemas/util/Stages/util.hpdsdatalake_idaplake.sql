!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_IDAPLAKE
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/'
	;
!set variable_substitution=false;