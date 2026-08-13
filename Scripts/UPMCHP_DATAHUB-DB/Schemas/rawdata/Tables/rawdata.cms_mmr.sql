!set variable_substitution=true;


CREATE OR REPLACE TABLE RAWDATA.CMS_MMR
LIKE &{IDAP_LAKE}.CMS.MMR
;


!set variable_substitution=false;