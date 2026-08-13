create or replace view STAGEDATA.LNK_CLAIM_MEMBERSHIP_GROUP_MC400UPM_SELECT_VW
COMMENT='Link between hub_claim and hub_membership_group'
as
select
claims.TpaClient AS C_TPA_CLIENT_ID,
claims.TpaIdOfClient AS C_TPA_ID,
claims.TpaDivision AS C_TPA_DIV_ID,
'MC400Upm' AS C_DATA_SOURCE_NAME,
claims.claimNbr AS C_CLAIM_NBR,
claims.TpaClient AS MG_TPA_CLIENT_ID,
claims.TpaIdOfClient AS MG_TPA_ID,
claims.TpaDivision AS MG_TPA_DIV_ID,
'MC400Upm' as MG_DATA_SOURCE_NAME,
trim(claims.groupNbr) AS MG_GROUP_NBR,
trim(claims.subGroup) AS MG_SUB_GROUP_NBR,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_GROUP_NBR, MG_SUB_GROUP_NBR]) AS LNK_CLAIM_MEMBERSHIP_GROUP_HKEY,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY,
UTIL.FXN_ARRAY_HASH([MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_GROUP_NBR, MG_SUB_GROUP_NBR]) AS HUB_MEMBERSHIP_GROUP_HKEY
FROM rawdata.mc400_dwoao_claims claims
    JOIN rawdata.mc400_dwoao_subgroups subgroups
        on (subgroups.tpaclient = claims.tpaclient
        and subgroups.tpaidofclient = claims.tpaidofclient
        and subgroups.tpaDivision = claims.tpadivision
        and subgroups.groupNbr = claims.groupnbr
        and subgroups.subgroup = claims.subgroup)

WHERE claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;
