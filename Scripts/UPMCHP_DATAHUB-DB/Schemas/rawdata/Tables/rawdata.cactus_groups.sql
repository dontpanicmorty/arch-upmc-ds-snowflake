!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_GROUPS
LIKE &{CACTUS}.VISUALCACTUS.GROUPS
;

!set variable_substitution=false;