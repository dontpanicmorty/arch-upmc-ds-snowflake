!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_GENERICCODES 
LIKE &{CDC_MERGE}.DBO.GENERICCODES
;

!set variable_substitution=false;