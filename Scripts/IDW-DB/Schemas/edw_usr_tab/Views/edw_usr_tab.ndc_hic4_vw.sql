!set variable_substitution=true;
CREATE OR REPLACE VIEW EDW_USR_TAB.NDC_HIC4_VW
AS
SELECT
NDC,
HIC_SEQN,
HIC4_DESC
FROM &{IDW_LAKE}.EDW_USR_TAB.NDC_HIC4_VW;
!set variable_substitution=false;
