!set variable_substitution=true;
CREATE OR REPLACE VIEW EDW_RPT.MTM_LOAD_DATE
AS
SELECT
TABLE_NAME,
LOAD_DATE
FROM &{IDW_LAKE}.EDW_RPT.MTM_LOAD_DATE;
!set variable_substitution=false;
