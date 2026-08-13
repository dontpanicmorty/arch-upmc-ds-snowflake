!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PROVIDERS 
LIKE &{CDC_MERGE}.DBO.PROVIDERS
;

!set variable_substitution=false;