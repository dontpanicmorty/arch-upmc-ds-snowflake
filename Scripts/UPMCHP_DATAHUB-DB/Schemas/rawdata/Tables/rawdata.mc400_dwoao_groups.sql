!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_GROUPS
LIKE &{CDC_MERGE}.DBO.GROUPS
;

!set variable_substitution=false;