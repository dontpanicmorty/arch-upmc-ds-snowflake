!set variable_substitution=true;
CREATE OR REPLACE VIEW EDW_RPT.MC_PLAN_LOB_VW
AS
SELECT

FROM &{IDW_LAKE}.EDW_RPT.MC_PLAN_LOB_VW;
!set variable_substitution=false;
