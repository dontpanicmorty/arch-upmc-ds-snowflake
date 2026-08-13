!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_PROVIDERID
LIKE &{CACTUS}.VISUALCACTUS.PROVIDERID
;

!set variable_substitution=false;