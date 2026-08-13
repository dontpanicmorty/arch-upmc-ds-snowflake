!set variable_substitution=true;

CREATE OR REPLACE STAGE RAWDATA.HPDSDATALAKE_IDAPLAKE
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/'
;
!set variable_substitution=false;