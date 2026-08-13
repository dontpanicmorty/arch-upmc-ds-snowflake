!set variable_substitution=true;


CREATE OR REPLACE TABLE RAWDATA.HP_ANALYTICS_IA_ACA_PLANS
LIKE &{IDW_LAKE}.HPANALYTICS.IA_ACA_PLANS
;


!set variable_substitution=false;