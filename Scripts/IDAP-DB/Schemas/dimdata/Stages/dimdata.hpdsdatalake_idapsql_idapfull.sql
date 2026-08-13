!set variable_substitution=true;

CREATE OR REPLACE STAGE DIMDATA.HPDSDATALAKE_IDAPSQL_IDAPFULL
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idapsql/idapfull'
	;

!set variable_substitution=false;
