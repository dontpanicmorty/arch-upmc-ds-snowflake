!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_GROUPS
LIKE &{MC400}.DWDNV.GROUPS
;

!set variable_substitution=false;