!set variable_substitution=true;

CREATE OR REPLACE STAGE MARKETING_PROSPECTS.SNOWFLAKEDATA_MARKETING_PROSPECTS
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/marketingprospects/'
    COMMENT = 'Staging area for Prospect Addresses from the ACXIOM prospect data files'
;

!set variable_substitution=false;