!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PREMIUMS
LIKE &{CDC_MERGE}.DBO.PREMIUMS
;

!set variable_substitution=false;