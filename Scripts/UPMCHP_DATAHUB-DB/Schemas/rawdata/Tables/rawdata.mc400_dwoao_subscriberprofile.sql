!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_SUBSCRIBERPROFILE
LIKE &{CDC_MERGE}.DBO.SUBSCRIBERPROFILE
;
 
!set variable_substitution=false;