!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_COUNTRY
LIKE &{CACTUS}.VISUALCACTUS.COUNTRY
;

!set variable_substitution=false;