!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_INSTITUTIONS
LIKE &{CACTUS}.VISUALCACTUS.INSTITUTIONS
;

!set variable_substitution=false;