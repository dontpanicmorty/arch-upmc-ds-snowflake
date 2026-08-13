!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_APWORK 
LIKE &{CDC_MERGE}.DBO.APWORK
;
!set variable_substitution=false;