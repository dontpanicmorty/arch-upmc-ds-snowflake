!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.CACTUS_AUDITLOG
LIKE &{CACTUS}.VISUALCACTUS.AUDITLOG
;

!set variable_substitution=false;