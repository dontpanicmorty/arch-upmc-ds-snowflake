!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGING.RX_NPI_LKP
AS
SELECT
NPI
FROM &{IDW_LAKE}.STAGING.RX_NPI_LKP;
!set variable_substitution=false;
