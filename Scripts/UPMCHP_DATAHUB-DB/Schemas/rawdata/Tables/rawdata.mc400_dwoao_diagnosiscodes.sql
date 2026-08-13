!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_DIAGNOSISCODES 
LIKE &{CDC_MERGE}.DBO.DIAGNOSISCODES
;

!set variable_substitution=false;
