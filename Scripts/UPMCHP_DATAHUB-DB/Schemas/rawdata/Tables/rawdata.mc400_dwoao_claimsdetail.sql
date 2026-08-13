!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_CLAIMSDETAIL
LIKE &{CDC_MERGE}.DBO.CLAIMSDETAIL
;

!set variable_substitution=false;