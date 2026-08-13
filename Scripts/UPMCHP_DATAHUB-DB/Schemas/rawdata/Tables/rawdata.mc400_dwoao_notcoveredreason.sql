!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_NOTCOVEREDREASON 
LIKE &{CDC_MERGE}.DBO.NOTCOVEREDREASON
;

!set variable_substitution=false;