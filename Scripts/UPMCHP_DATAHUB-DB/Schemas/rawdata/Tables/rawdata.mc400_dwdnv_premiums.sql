!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_PREMIUMS
LIKE &{MC400}.DWDNV.PREMIUMS
;

!set variable_substitution=false;