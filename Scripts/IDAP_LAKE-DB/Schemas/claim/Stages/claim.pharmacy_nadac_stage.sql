!set variable_substitution=true;

CREATE OR REPLACE STAGE CLAIM.PHARMACY_NADAC_STAGE
    STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
    URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/idaplake/claim/nadac'        
    FILE_FORMAT = CLAIM.PHARMACY_NADAC_CSV_FILE_FORMAT
    ;

!set variable_substitution=false;