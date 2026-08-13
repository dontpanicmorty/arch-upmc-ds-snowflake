!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_IPA
LIKE &{CDC_MERGE}.DBO.IPA
;
 
!set variable_substitution=false;