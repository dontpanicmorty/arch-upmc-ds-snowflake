!set variable_substitution=true;

CREATE OR REPLACE STAGE UTIL.SNOWFLAKEDATA_AE2_IDAPLAKE
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake'
  COMMENT = 'East 2 Staging area for Incoming data to IDAP_LAKE'
;
!set variable_substitution=false;