create or replace view STAGEDATA.LNK_CLAIM_MEMBER_MC400UPM_SELECT_VW
COMMENT='Link between hub_claim and hub_member'
AS
SELECT
Claims.TpaClient AS C_TPA_CLIENT_ID,
Claims.TpaIdOfClient AS C_TPA_ID,
Claims.TpaDivision AS C_TPA_DIV_ID,
'MC400Upm' AS C_DATA_SOURCE_NAME,
Claims.ClaimNbr AS C_CLAIM_NBR,
Members.TpaClient AS M_TPA_CLIENT_ID,
Members.TpaIdOfClient AS M_TPA_ID,
Members.TpaDivision AS M_TPA_DIV_ID,
'MC400Upm' AS M_DATA_SOURCE_NAME,
Members.MemberNbr AS M_MEMBER_NBR,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, M_TPA_CLIENT_ID, M_TPA_DIV_ID, M_TPA_ID, M_DATA_SOURCE_NAME, M_MEMBER_NBR]) AS LNK_CLAIM_MEMBER_HKEY,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY,
UTIL.FXN_ARRAY_HASH([M_TPA_CLIENT_ID, M_TPA_ID, M_TPA_DIV_ID, M_DATA_SOURCE_NAME, M_MEMBER_NBR]) AS HUB_MEMBER_HKEY
FROM RAWDATA.MC400_DWOAO_CLAIMS Claims
    JOIN RAWDATA.MC400_DWOAO_MEMBERS Members --Joining to member in source system to make sure member on claim in valid.
        ON (Members.TpaClient = Claims.TpaClient
        AND Members.TpaIdOfClient = Claims.TpaIdOfClient
        AND Members.TpaDivision = Claims.TpaDivision
        AND Members.MemberNbr = Claims.MemberNbr)
WHERE Claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;
