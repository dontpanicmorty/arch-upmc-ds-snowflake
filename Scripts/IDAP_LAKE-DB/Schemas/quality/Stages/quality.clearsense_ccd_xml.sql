!set variable_substitution=true;

CREATE OR REPLACE STAGE QUALITY.CLEARSENSE_CCD_XML
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/quality/clearsenseccd/data/'
    COMMENT = 'Staging area for ClearSense Data (XML) Files into IDAP_LAKE'
;

!set variable_substitution=false;
