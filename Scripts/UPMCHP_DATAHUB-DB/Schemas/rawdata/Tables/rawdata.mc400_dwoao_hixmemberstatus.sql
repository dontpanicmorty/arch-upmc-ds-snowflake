!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_HIXMEMBERSTATUS
LIKE &{CDC_MERGE}.DBO.HIXMEMBERSTATUS;
 
!set variable_substitution=false;