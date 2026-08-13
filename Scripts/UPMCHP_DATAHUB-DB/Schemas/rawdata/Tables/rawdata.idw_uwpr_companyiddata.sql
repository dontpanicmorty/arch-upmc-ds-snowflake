!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.IDW_UWPR_COMPANYIDDATA
LIKE &{IDW_LAKE}.UWPR.COMPANYIDDATA
;

!set variable_substitution=false;