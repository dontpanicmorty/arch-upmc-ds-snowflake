!set variable_substitution=true;

CREATE OR REPLACE STAGE MEMBER.HPDSDATALAKE_PREFERENCE_CENTER
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/consumertech/preferencecenter/'
    COMMENT = 'Staging area for preferenceCenter change data out of CosmosDB'
;

!set variable_substitution=false;