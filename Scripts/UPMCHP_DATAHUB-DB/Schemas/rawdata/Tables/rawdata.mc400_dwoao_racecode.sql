!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_RACECODE
LIKE &{CDC_MERGE}.DBO.RACECODE;
 
!set variable_substitution=false;
 