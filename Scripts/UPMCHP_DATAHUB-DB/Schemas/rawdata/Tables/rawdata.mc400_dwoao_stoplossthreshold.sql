!set variable_substitution=true;
 
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_STOPLOSSTHRESHOLD
LIKE &{CDC_MERGE}.DBO.STOPLOSSTHRESHOLD
;
 
!set variable_substitution=false;