!set variable_substitution=true;
CREATE OR REPLACE STAGE APPLICATION_EVENTS.SNOWFLAKEDATA_CONSUMERTECH_MEMBER_NOTIFICATIONS
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/consumertech/notifications/member'
  ;

!set variable_substitution=false;