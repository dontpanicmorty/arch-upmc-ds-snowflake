!set variable_substitution=true;
CREATE OR REPLACE STAGE EXTRACTDATA.HPDSDATALAKE_OUTGOING
	STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
	URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/outgoing/'
    COMMENT = 'Staging area for adls outgoing data'
	; 
!set variable_substitution=false;