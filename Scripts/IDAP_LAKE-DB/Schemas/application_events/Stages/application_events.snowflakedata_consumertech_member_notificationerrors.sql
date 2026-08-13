!set variable_substitution=true;
CREATE OR REPLACE STAGE APPLICATION_EVENTS.SNOWFLAKEDATA_CONSUMERTECH_MEMBER_NOTIFICATIONERRORS
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/consumertech/notificationErrors/member'
;

!set variable_substitution=false;