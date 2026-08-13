!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.LOB_PLAN_TYPE
LIKE &{IDAP_LAKE}.NETWORK.LOB_PLAN_TYPE
;

!set variable_substitution=false;