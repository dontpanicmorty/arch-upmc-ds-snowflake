!set variable_substitution=true;

CREATE OR REPLACE STAGE HEALTHSPARQ_2.SNOWFLAKEDATA_OUTBOUNDDATA
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/outbounddata'
	;

!set variable_substitution=false;
