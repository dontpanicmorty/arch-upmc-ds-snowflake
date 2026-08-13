!set variable_substitution=true;
CREATE OR REPLACE VIEW STAGING.SPECIALTY_NDC
AS
SELECT
SHORT_NAME,
NDC
FROM &{IDW_LAKE}.STAGING.SPECIALTY_NDC;
!set variable_substitution=false;
