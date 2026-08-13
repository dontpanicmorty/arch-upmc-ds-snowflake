!set variable_substitution=true;
CREATE OR REPLACE STAGE DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract/dwskygen'
;
!set variable_substitution=false;