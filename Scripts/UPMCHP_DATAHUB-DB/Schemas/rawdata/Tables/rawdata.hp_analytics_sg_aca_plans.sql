!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.HP_ANALYTICS_SG_ACA_PLANS
LIKE &{IDW_LAKE}.HPANALYTICS.SG_ACA_PLANS
;

!set variable_substitution=false;