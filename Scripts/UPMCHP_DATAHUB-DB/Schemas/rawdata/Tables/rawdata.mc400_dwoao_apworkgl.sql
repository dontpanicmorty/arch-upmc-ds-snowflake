!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_APWORKGL 
LIKE &{CDC_MERGE}.DBO.APWORKGL
;

!set variable_substitution=false;