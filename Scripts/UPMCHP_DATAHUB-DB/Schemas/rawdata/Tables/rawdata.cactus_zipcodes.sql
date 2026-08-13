!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_ZIPCODES
LIKE &{CACTUS}.VISUALCACTUS.ZIPCODES
;

!set variable_substitution=false;
