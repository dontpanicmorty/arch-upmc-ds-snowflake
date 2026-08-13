!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_RIDERMASTER
LIKE &{CDC_MERGE}.DBO.RIDERMASTER
;
 
!set variable_substitution=false;