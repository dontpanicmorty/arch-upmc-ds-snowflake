!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_GROUPADDRESS
LIKE &{CACTUS}.VISUALCACTUS.GROUPADDRESS
;

!set variable_substitution=false;