!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_PROVIDERS
LIKE &{CACTUS}.VISUALCACTUS.PROVIDERS
;

!set variable_substitution=false;