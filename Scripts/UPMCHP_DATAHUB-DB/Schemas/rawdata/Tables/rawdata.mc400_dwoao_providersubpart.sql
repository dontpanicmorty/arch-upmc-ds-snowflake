!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWOAO_PROVIDERSUBPART
LIKE &{CDC_MERGE}.DBO.PROVIDERSUBPART
;

!set variable_substitution=false;