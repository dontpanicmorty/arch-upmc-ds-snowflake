!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_DIAGNOSISTYPES 
LIKE &{CDC_MERGE}.DBO.DIAGNOSISTYPES
;

!set variable_substitution=false;