!set variable_substitution=true;

CREATE OR REPLACE TABLE RAWDATA.GREENBACK_RX_CLAIM_HISTORY
LIKE &{IDAP_LAKE}.CLAIM.GREENBACK_RX_CLAIM_HISTORY
;

!set variable_substitution=false;