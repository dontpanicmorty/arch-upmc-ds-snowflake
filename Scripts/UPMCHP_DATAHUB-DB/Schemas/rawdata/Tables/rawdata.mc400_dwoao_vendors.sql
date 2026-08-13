!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_VENDORS 
LIKE &{CDC_MERGE}.DBO.VENDORS
;

!set variable_substitution=false;
