!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_LEGALFILENAME
LIKE &{CDC_MERGE}.DBO.LEGALFILENAME
;

!set variable_substitution=false;