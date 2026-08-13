!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_HRAHSAGROUP
LIKE &{CDC_MERGE}.DBO.HRAHSAGROUP
;

!set variable_substitution=false;