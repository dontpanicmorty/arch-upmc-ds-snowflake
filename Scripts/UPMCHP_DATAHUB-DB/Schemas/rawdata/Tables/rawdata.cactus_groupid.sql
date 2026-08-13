!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_GROUPID
LIKE &{CACTUS}.VISUALCACTUS.GROUPID
;

!set variable_substitution=false;