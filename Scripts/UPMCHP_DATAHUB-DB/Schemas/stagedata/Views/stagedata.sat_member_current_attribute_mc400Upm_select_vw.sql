CREATE OR REPLACE VIEW STAGEDATA.SAT_MEMBER_CURRENT_ATTRIBUTE_MC400UPM_SELECT_VW AS
SELECT
Members.TpaClient AS TPA_CLIENT_ID
,Members.TpaIdOfClient AS TPA_ID
,Members.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,TRIM(Members.MemberNbr) AS MEMBER_NBR
,NULLIF(TRIM(Members.CurrentEligStatusCode1), '') AS ELIG_STATUS_CODE01
,NULLIF(TRIM(EligibilityStatusCodes_1.EligDescription), '') AS ELIG_STATUS_DESC01
,NULLIF(TRIM(Members.CurrentEligStatusCode2), '') AS ELIG_STATUS_CODE02
,NULLIF(TRIM(EligibilityStatusCodes_2.EligDescription), '') AS ELIG_STATUS_DESC02
,NULL AS PART_D_RISK_FACTOR
,NULL AS CHRONIC_CONDITION_CNT -- int derived by counting flags from a source not yet in PROD
,TO_BOOLEAN(IFF(PrivacyRestrictionFlag.MemberId is NULL, FALSE, TRUE)) AS PRIVACY_RESTRICTION_FLAG -- Code 019
,TO_BOOLEAN(IFF(PrivacyAlertFlag.MemberId is NULL, FALSE, TRUE)) AS PRIVACY_ALERT_FLAG -- Code 033
,CASE
       WHEN SUBSTRING(TRIM(Members.CurrCoverageGroupCode), 1,3) = 'MAC' OR -- Community Health Choices (CHC)
              SUBSTRING(TRIM(Members.CurrCoverageGroupCode), 1,2) = 'MA' OR -- Medicaid
              SUBSTRING(TRIM(Members.CurrCoverageGroupCode), 1,4) = 'KIDS' -- Children's Health Insurance Program (CHIP)
       THEN TRY_TO_DATE(TO_VARCHAR(Members.MaritalStatusEffDate), 'YYYYMMDD')
       ELSE NULL
END AS PREGNANCY_DUE_DATE -- Refers to Lines of Business (CHC, Medicaid, or CHIP)
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEMBER_NBR]) AS HUB_MEMBER_HKEY

FROM RAWDATA.MC400_DWOAO_MEMBERS Members
       LEFT JOIN RAWDATA.MC400_DWOAO_ELIGIBILITYSTATUSCODES EligibilityStatusCodes_1
              ON (Members.CurrentEligStatusCode1 = EligibilityStatusCodes_1.EligibilityStCode)

       LEFT JOIN RAWDATA.MC400_DWOAO_ELIGIBILITYSTATUSCODES EligibilityStatusCodes_2
              ON (Members.CurrentEligStatusCode2 = EligibilityStatusCodes_2.EligibilityStCode)

       LEFT JOIN
              (
              SELECT DISTINCT BD_ENROLLEE.MemberId
              FROM RAWDATA.HEALTHPLANET_APP_DBO_BD_ENROLLEE BD_ENROLLEE
                     JOIN RAWDATA.HEALTHPLANET_RS_DBO_OLAP_CMS_FLAG OLAP_CMS_FLAG
                            ON (BD_ENROLLEE.C_ENROLLEE_KEY = OLAP_CMS_FLAG.C_ENROLLEE_KEY)
                     JOIN RAWDATA.HEALTHPLANET_RS_DBO_MTN_FLAG_CATEGORY MTN_FLAG_CATEGORY
                            ON (OLAP_CMS_FLAG.C_CATEGORY_KEY = MTN_FLAG_CATEGORY.C_CODE_KEY)
              WHERE MTN_FLAG_CATEGORY.C_CODE = '019'
              AND OLAP_CMS_FLAG.C_ACTIVE = 1
              ) PrivacyRestrictionFlag
              ON Members.MemberNbr = PrivacyRestrictionFlag.MemberId

       LEFT JOIN
              (
              SELECT DISTINCT BD_ENROLLEE.MemberId
              FROM RAWDATA.HEALTHPLANET_APP_DBO_BD_ENROLLEE BD_ENROLLEE
                     JOIN RAWDATA.HEALTHPLANET_RS_DBO_OLAP_CMS_FLAG OLAP_CMS_FLAG
                            ON (BD_ENROLLEE.C_ENROLLEE_KEY = OLAP_CMS_FLAG.C_ENROLLEE_KEY)
                     JOIN RAWDATA.HEALTHPLANET_RS_DBO_MTN_FLAG_CATEGORY MTN_FLAG_CATEGORY
                            ON (OLAP_CMS_FLAG.C_CATEGORY_KEY = MTN_FLAG_CATEGORY.C_CODE_KEY)
              WHERE MTN_FLAG_CATEGORY.C_CODE = '033'
              AND OLAP_CMS_FLAG.C_ACTIVE = 1
              ) PrivacyAlertFlag
              ON Members.MemberNbr = PrivacyAlertFlag.MemberId

WHERE Members.MemberNbr <> '99999999901' --this is a junk catch all member number
;

