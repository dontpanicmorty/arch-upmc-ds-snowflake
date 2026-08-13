!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_COPAYREASON 
LIKE &{CDC_MERGE}.DBO.COPAYREASON
;

!set variable_substitution=false;