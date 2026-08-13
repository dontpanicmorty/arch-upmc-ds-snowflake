!set variable_substitution=true;

CREATE OR REPLACE STAGE APPLICATION_EVENTS.SNOWFLAKEDATA_CONSUMERTECH_APIMLOGS
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/apim/consumertech/logs/'
    COMMENT = 'Staging area for APIM log file loads into IDAP_LAKE'
;

!set variable_substitution=false;