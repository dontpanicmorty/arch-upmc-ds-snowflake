!set variable_substitution=true;

CREATE OR REPLACE STAGE QUALITY.CLEARSENSE_CCD_INDEX
    storage_integration = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/quality/clearsenseccd/index/'
    COMMENT = 'Staging area for ClearSense Control (TXT) Files into IDAP_LAKE'
;

!set variable_substitution=false;
