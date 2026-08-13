
!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_ACCOUNTSPAYABLE
LIKE &{CDC_MERGE}.DBO.ACCOUNTSPAYABLE
;

!set variable_substitution=false;
