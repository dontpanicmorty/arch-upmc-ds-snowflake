!set variable_substitution=true;

CREATE OR REPLACE STAGE RAWDATA.HPDSDATALAKE_DBEXTRACT
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract/'
;
!set variable_substitution=false;

--idapdeus2sadatalakedev  dev storage account