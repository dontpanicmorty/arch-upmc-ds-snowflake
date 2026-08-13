!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PROVIDERADDRESSES 
LIKE &{CDC_MERGE}.DBO.PROVIDERADDRESSES
;

!set variable_substitution=false;