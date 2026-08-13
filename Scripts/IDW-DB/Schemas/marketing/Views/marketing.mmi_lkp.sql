!set variable_substitution=true;
CREATE OR REPLACE VIEW MARKETING.MMI_LKP
AS
SELECT
MMI,
MEMBER_NBR,
INDIVIDUAL_ID
FROM &{IDW_LAKE}.MARKETING.MMI_LKP;
!set variable_substitution=false;
