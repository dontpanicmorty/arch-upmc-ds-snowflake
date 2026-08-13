!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_BENEFITCATEGORY 
LIKE &{CDC_MERGE}.DBO.BENEFITCATEGORY
;

!set variable_substitution=false;