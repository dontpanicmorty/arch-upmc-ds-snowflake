!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_SUBGROUPS
LIKE &{MC400}.DWDNV.SUBGROUPS
;

!set variable_substitution=false;