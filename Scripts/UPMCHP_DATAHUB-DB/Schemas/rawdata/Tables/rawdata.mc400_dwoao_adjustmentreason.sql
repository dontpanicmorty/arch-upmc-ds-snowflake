!set variable_substitution=true;

CREATE OR REPLACE TABLE  RAWDATA.MC400_DWOAO_ADJUSTMENTREASON 
LIKE &{CDC_MERGE}.DBO.ADJUSTMENTREASON
;

!set variable_substitution=false;
