!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_DDLAUTOMATION
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/ddlautomation'
	;
!set variable_substitution=false;