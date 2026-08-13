!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_HIXMEMBERMASTER
LIKE &{CDC_MERGE}.DBO.HIXMEMBERMASTER
;

!set variable_substitution=false;