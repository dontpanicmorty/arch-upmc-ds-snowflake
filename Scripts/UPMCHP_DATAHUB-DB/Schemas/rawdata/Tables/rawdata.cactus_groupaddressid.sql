!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_GROUPADDRESSID
LIKE &{CACTUS}.VISUALCACTUS.GROUPADDRESSID
;

!set variable_substitution=false;