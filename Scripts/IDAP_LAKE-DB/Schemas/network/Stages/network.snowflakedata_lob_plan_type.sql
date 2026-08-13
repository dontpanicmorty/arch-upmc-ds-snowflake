!set variable_substitution=true;
CREATE OR REPLACE STAGE NETWORK.SNOWFLAKEDATA_LOB_PLAN_TYPE
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/fileloaddata/lob_plan_type_archive'
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION;

!set variable_substitution=false;