!set variable_substitution=true;

CREATE OR REPLACE STAGE RAWDATA.HPDSDATALAKE_DBEXTRACT_CMS_PRICING
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/dbextract/'
    COMMENT = 'Staging area for db extracts'
	;
!set variable_substitution=false;