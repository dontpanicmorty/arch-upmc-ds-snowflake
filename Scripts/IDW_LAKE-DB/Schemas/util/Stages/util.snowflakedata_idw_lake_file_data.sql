!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.SNOWFLAKEDATA_IDW_LAKE_FILE_DATA
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idwlake/'
    COMMENT = 'Staging area for idwlake files'
	;
!set variable_substitution=false;