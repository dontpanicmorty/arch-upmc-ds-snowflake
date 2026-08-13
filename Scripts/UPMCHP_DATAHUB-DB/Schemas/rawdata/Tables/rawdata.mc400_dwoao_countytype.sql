!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_COUNTYTYPE 
LIKE &{CDC_MERGE}.DBO.COUNTYTYPE
;

!set variable_substitution=false;