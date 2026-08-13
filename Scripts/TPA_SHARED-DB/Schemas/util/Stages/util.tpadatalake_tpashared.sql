!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.TPADATALAKE_TPASHARED
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{tpasharedstorageaccount}.blob.core.windows.net/tpashared/'
	;
!set variable_substitution=false;