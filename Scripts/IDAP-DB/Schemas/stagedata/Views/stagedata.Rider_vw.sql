CREATE OR REPLACE VIEW STAGEDATA.RIDER_VW
AS
SELECT
URI
,JSON_DATA:envelope:instance:rider:universalRiderId::string AS DATA_HUB_UNIVERSAL_RIDER_ID
,JSON_DATA:envelope:instance:rider:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:rider:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:rider:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:rider:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:rider:riderCode::string AS RIDER_CODE
,JSON_DATA:envelope:instance:rider:riderDesc::string AS RIDER_DESC
,JSON_DATA:envelope:instance:rider:riderEffectiveDate::date AS RIDER_EFFECTIVE_DATE
,JSON_DATA:envelope:instance:rider:riderTerminationDate::date AS RIDER_TERMINATION_DATE
,JSON_DATA:envelope:instance:rider:riderTypeCode::string AS RIDER_TYPE_CODE
,JSON_DATA:envelope:instance:rider:riderTypeCodeDesc::string AS RIDER_TYPE_DESC
,JSON_DATA:envelope:instance:rider:groupNbr::string AS GROUP_NBR
,JSON_DATA:envelope:instance:rider:subGroupNbr::string AS SUB_GROUP_NBR
,JSON_DATA:envelope:instance:rider:tieringMethodCode::string AS TIER_METHOD_CODE
,JSON_DATA:envelope:instance:rider:riderAmt1::number(12,2) AS RIDER_AMT_1
,JSON_DATA:envelope:instance:rider:riderAmt2::number(12,2) AS RIDER_AMT_2
,JSON_DATA:envelope:instance:rider:riderAmt3::number(12,2) AS RIDER_AMT_3
,JSON_DATA:envelope:instance:rider:riderAmt4::number(12,2) AS RIDER_AMT_4
,JSON_DATA:envelope:instance:rider:riderAmt5::number(12,2) AS RIDER_AMT_5
,JSON_DATA:envelope:instance:rider:riderAmt6::number(12,2) AS RIDER_AMT_6
,JSON_DATA:envelope:instance:rider:riderAmt7::number(12,2) AS RIDER_AMT_7
,JSON_DATA:envelope:instance:rider:riderAmt8::number(12,2) AS RIDER_AMT_8
,JSON_DATA:envelope:instance:rider:riderAmt9::number(12,2) AS RIDER_AMT_9
,JSON_DATA:envelope:instance:rider:riderAmt10::number(12,2) AS RIDER_AMT_10
,JSON_DATA:envelope:instance:rider:arCashGlDistributionCode::string AS AR_CASH_GL_DISTRIBUTION_CODE
,JSON_DATA:envelope:instance:rider:companyCode::string AS COMPANY_CODE
,JSON_DATA:envelope:instance:rider:eligRuleCode::string AS ELIGIBILITY_RULE_CODE
,JSON_DATA:envelope:instance:rider:glDistributionCode::string AS GL_DISTRIBUTION_CODE
,JSON_DATA:envelope:instance:rider:formularyCode::string AS FORMULARY_CODE
,JSON_DATA:envelope:instance:rider:formularyCodeDesc::string AS FORMULARY_CODE_DESC
FROM STAGEDATA.RIDER
;