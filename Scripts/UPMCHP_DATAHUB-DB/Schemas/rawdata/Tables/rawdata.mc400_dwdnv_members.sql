!set variable_substitution=true;
CREATE OR REPLACE TABLE RAWDATA.MC400_DWDNV_MEMBERS 
LIKE &{MC400}.DWDNV.MEMBERS
;

!set variable_substitution=false;
