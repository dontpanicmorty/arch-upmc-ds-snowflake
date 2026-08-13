!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_PLANMASTER
LIKE &{MC400}.DWDNV.PLANMASTER
;
!set variable_substitution=false;