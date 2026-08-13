!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_RIDERMASTER
LIKE &{MC400}.DWDNV.RIDERMASTER
;

!set variable_substitution=false;