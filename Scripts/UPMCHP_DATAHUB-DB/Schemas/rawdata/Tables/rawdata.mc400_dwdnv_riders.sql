!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_RIDERS
LIKE &{MC400}.DWDNV.RIDERS
;

!set variable_substitution=false;