!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.HPDSDATALAKE_OUTGOING
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/outgoing/'
    COMMENT = 'Outgoing directory for Snowflake Data Lake'
	;
!set variable_substitution=false;