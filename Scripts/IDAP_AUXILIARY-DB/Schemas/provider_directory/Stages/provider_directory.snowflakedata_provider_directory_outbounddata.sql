!set variable_substitution=true;

CREATE OR REPLACE STAGE PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_OUTBOUNDDATA
storage_integration = SNOWFLAKEDATA_INTEGRATION
url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/provider-directory/outbounddata'
COMMENT = 'Unloading area for data being sent on to CosmosDB for FindCare'
;

!set variable_substitution=false;