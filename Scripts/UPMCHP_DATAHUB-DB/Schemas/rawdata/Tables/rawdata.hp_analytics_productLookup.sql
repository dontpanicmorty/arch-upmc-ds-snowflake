!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.HP_ANALYTICS_PRODUCT_LOOKUP
LIKE &{IDW_LAKE}.HPANALYTICS.PRODUCT_LOOKUP
;

!set variable_substitution=false;