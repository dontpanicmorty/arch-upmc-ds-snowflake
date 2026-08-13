!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PROCEDURETYPES 
LIKE &{CDC_MERGE}.DBO.PROCEDURETYPES
;

!set variable_substitution=false;