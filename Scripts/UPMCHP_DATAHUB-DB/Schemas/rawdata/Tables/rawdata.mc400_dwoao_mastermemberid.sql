!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_MASTERMEMBERID
LIKE &{CDC_MERGE}.DBO.MASTERMEMBERID
;

!set variable_substitution=false;