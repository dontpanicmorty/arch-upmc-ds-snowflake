!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_TPACUSTOMER 
LIKE &{CDC_MERGE}.DBO.TPACUSTOMER
;

!set variable_substitution=false;