!set variable_substitution=true;

CREATE OR REPLACE STAGE ODSDATA.HPDSDATALAKE_IDAPSQL
storage_integration = SNOWFLAKEDATA_INTEGRATION
url = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idapsql'
COMMENT = 'Landing area for data coming from on prem SQL Server and Informatica provider ODS build'
;

!set variable_substitution=false;