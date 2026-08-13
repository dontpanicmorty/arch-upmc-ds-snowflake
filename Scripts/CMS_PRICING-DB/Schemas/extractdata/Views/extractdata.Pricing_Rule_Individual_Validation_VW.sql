CREATE OR REPLACE VIEW EXTRACTDATA.PRICING_RULE_VALIDATION_INDIVIDUAL_SELECT_VW
AS
SELECT PRICING_RULE, COUNT(distinct BILLING_CODE, NVL(BILLING_CODE_MODIFIER,'NULL')) AS COUNT, VENDOR, SEGMENT
    FROM
        (select  '065' as pricing_rule, vendor, segment, billing_code, BILLING_CODE_MODIFIER
        from stagedata.pricing_rule_065_vw
        union
        select  '041' as pricing_rule, vendor, segment, billing_code, BILLING_CODE_MODIFIER
        from stagedata.pricing_rule_041_vw
        union
        select  '009' as pricing_rule, vendor, segment, billing_code, BILLING_CODE_MODIFIER
        from stagedata.pricing_rule_009_vw
        )
    GROUP BY PRICING_RULE, VENDOR, SEGMENT
;