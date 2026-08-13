!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_SERVICEREASON 
LIKE &{CDC_MERGE}.DBO.SERVICEREASON
;

!set variable_substitution=false;