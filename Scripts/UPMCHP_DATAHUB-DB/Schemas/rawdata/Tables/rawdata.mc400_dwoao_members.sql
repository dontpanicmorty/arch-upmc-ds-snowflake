!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_MEMBERS 
LIKE &{CDC_MERGE}.DBO.MEMBERS
;

!set variable_substitution=false;