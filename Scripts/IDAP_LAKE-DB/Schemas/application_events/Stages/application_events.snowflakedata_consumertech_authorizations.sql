!set variable_substitution=true;
CREATE OR REPLACE STAGE APPLICATION_EVENTS.SNOWFLAKEDATA_CONSUMERTECH_AUTHORIZATIONS
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/consumertech/authorizations'
;
!set variable_substitution=false;