!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_PROVIDERBOARDS
LIKE &{CACTUS}.VISUALCACTUS.PROVIDERBOARDS
;

!set variable_substitution=false;