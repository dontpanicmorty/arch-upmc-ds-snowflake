!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PLANTYPE
LIKE &{CDC_MERGE}.DBO.PLANTYPE
;

!set variable_substitution=false;