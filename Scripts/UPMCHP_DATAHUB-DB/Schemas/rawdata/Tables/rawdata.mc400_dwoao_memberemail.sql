!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_MEMBEREMAIL
LIKE &{CDC_MERGE}.DBO.MEMBEREMAIL;
 
!set variable_substitution=false;