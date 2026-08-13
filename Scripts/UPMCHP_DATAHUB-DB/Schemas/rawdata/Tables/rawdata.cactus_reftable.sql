!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_REFTABLE
LIKE &{CACTUS}.VISUALCACTUS.REFTABLE
;

!set variable_substitution=false;