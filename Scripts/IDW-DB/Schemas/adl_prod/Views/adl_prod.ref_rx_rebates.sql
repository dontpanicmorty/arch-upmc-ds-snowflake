!set variable_substitution=true;
CREATE OR REPLACE VIEW ADL_PROD.REF_RX_REBATES
AS
SELECT
LOB,
YYYYMM,
RX_REBATES
FROM &{IDW_LAKE}.ADL_PROD.REF_RX_REBATES;
!set variable_substitution=false;
