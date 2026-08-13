!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_SUBGROUPS
LIKE &{CDC_MERGE}.DBO.SUBGROUPS
;

!set variable_substitution=false;