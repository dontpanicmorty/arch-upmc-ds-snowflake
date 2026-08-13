!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PROCEDUREMODIFIER 
LIKE &{CDC_MERGE}.DBO.PROCEDUREMODIFIER
;

!set variable_substitution=false;