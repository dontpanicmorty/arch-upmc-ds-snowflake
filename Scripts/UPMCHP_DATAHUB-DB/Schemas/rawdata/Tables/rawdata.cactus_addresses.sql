!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_ADDRESSES
LIKE &{CACTUS}.VISUALCACTUS.ADDRESSES
;

!set variable_substitution=false;