!set variable_substitution=true;

CREATE OR REPLACE STAGE PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_INBOUNDDATA
storage_integration = SNOWFLAKEDATA_INTEGRATION
url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/provider-directory/inbounddata'
COMMENT = 'Staging area for data coming from on prem SQL Server and Informatica provider directory build'
;

!set variable_substitution=false;