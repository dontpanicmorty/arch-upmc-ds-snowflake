!set variable_substitution=true;

CREATE OR REPLACE STAGE NETWORK.SNOWFLAKEDATA_BPL_RIDER_NETWORK_CROSSWALK
  URL = 'azure://&{datalakestorageaccount}.blob.core.windows.net/fileloaddata/bpl_rider_pharmacy_archive'
  STORAGE_INTEGRATION = SNOWFLAKEDATA_INTEGRATION
  DIRECTORY = ( ENABLE = FALSE AUTO_REFRESH = FALSE );

!set variable_substitution=false;
