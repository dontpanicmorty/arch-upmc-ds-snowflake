!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_PLANTYPE
LIKE &{MC400}.DWDNV.PLANTYPE
;

!set variable_substitution=false;