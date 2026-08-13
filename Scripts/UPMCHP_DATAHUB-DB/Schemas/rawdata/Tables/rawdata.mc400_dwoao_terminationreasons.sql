!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_TERMINATIONREASONS
LIKE &{CDC_MERGE}.DBO.TERMINATIONREASONS
;
 
!set variable_substitution=false;