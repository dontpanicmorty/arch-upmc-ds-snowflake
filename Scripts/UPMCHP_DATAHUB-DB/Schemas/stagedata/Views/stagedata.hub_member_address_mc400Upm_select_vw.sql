CREATE OR REPLACE VIEW STAGEDATA.HUB_MEMBER_ADDRESS_MC400Upm_SELECT_VW
COMMENT = 'Source view for MC400Upm data into HUB_MEMBER_ADDRESS'
AS

SELECT
'N/A' AS SOURCE_KEY,
Members.TpaClient AS TPA_CLIENT_ID,
Members.TpaIdOfClient AS TPA_ID,
Members.TpaDivision AS TPA_DIV_ID,
'MC400Upm' AS DATA_SOURCE_NAME,
TRIM(Members.MemberNbr) AS MEMBER_NBR,
'Physical' AS ADDRESS_TYPE_CODE,
UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEMBER_NBR, ADDRESS_TYPE_CODE]) as HUB_MEMBER_ADDRESS_HKEY
FROM RAWDATA.MC400_DWOAO_MEMBERS Members
WHERE Members.MemberNbr <> '99999999901' --this is a junk catch all member number
AND TRIM(Members.MemberAddress1) <> ''
AND NOT CONTAINS(UPPER(Members.MemberAddress1), 'REMOVE') --ignore anything that has remove in it

UNION ALL

SELECT
'N/A' AS SOURCE_KEY,
Members.TpaClient AS TPA_CLIENT_ID,
Members.TpaIdOfClient AS TPA_ID,
Members.TpaDivision AS TPA_DIV_ID,
'MC400Upm' AS DATA_SOURCE_NAME,
TRIM(Members.MemberNbr) AS MEMBER_NBR,
'Mailing' AS ADDRESS_TYPE_CODE,
UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEMBER_NBR, ADDRESS_TYPE_CODE]) as HUB_MEMBER_ADDRESS_HKEY
FROM RAWDATA.MC400_DWOAO_MEMBERS Members
WHERE Members.MemberNbr <> '99999999901' --this is a junk catch all member number
AND TRIM(Members.MailingAddress1) <> ''
AND NOT CONTAINS(UPPER(Members.MailingAddress1), 'REMOVE') --ignore anything that has remove in it

UNION ALL 

SELECT
'N/A' AS SOURCE_KEY,
Members.TpaClient AS TPA_CLIENT_ID,
Members.TpaIdOfClient AS TPA_ID,
Members.TpaDivision AS TPA_DIV_ID,
'MC400Upm' AS DATA_SOURCE_NAME,
TRIM(Members.MemberNbr) AS MEMBER_NBR,
'H6' AS ADDRESS_TYPE_CODE,
UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEMBER_NBR, ADDRESS_TYPE_CODE]) as HUB_MEMBER_ADDRESS_HKEY
FROM RAWDATA.MC400_DWOAO_MEMBERS Members
    JOIN RAWDATA.MC400_DWOAO_MEMBERHIPAAPRIVACYDATA MemberHippaPrivacyData
        ON (MemberHippaPrivacyData.SubscriberNumber = Members.SubscriberNbr
        AND MemberHippaPrivacyData.PersonNumber = Members.PersonNbr)
WHERE Members.MemberNbr <> '99999999901' --this is a junk catch all member number
AND MemberHippaPrivacyData.HipaaFormType = 'H6'
AND MemberHippaPrivacyData.EffectiveRecord = 'Y'
AND MemberHippaPrivacyData.ActiveRecord = 'Y'
AND TRIM(MemberHippaPrivacyData.ConfidentialAddressLine1) <> ''
;
