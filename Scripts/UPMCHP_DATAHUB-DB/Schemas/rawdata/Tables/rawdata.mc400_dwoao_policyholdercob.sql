!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_POLICYHOLDERCOB
LIKE &{CDC_MERGE}.DBO.POLICYHOLDERCOB;
 
!set variable_substitution=false;