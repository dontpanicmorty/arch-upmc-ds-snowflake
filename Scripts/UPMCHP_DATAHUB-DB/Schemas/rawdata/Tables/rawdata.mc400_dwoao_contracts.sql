!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_CONTRACTS 
LIKE &{CDC_MERGE}.DBO.CONTRACTS
;

!set variable_substitution=false;