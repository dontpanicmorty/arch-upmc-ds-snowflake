!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_CLAIMS 
LIKE &{CDC_MERGE}.DBO.CLAIMS
;

!set variable_substitution=false;