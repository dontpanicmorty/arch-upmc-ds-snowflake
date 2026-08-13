!set variable_substitution=true;

CREATE OR REPLACE STAGE INFA.SNOWFLAKEDATA_STAGEDATA
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idapsql/dwhpbi_incremental'
	;

!set variable_substitution=false;