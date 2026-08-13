!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_CROSSREFERENCE
LIKE &{CACTUS}.VISUALCACTUS.CROSSREFERENCE
;

!set variable_substitution=false;