!set variable_substitution=true;
CREATE OR REPLACE VIEW EDW_RPT.H9670_MBRS
AS
SELECT
MEMBER_NBR
FROM &{IDW_LAKE}.EDW_RPT.H9670_MBRS;
!set variable_substitution=false;
