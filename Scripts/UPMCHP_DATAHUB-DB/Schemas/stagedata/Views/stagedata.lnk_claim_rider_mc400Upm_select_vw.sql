create or replace view STAGEDATA.LNK_CLAIM_RIDER_MC400UPM_SELECT_VW
COMMENT='This is a LNK View containing Claim Rider  data'
AS
select distinct -- Distinct is needed because mc400 puts the same rider twice on a claim, aka bad data!!!
riders_cte.TpaClient AS C_TPA_CLIENT_ID
,riders_cte.TpaIdOfClient AS C_TPA_ID
,riders_cte.TpaDivision AS C_TPA_DIV_ID
,'MC400Upm' AS C_DATA_SOURCE_NAME
,riders_cte.claimNbr AS C_CLAIM_NBR
,riders_cte.TpaClient AS R_TPA_CLIENT_ID
,riders_cte.TpaIdOfClient AS R_TPA_ID
,riders_cte.TpaDivision AS R_TPA_DIV_ID
,'MC400Upm' AS R_DATA_SOURCE_NAME
,riders_cte.riderCode AS R_RIDER_CODE
,riders_cte.TpaClient AS MG_TPA_CLIENT_ID
,riders_cte.TpaIdOfClient AS MG_TPA_ID
,riders_cte.TpaDivision AS MG_TPA_DIV_ID
,'MC400Upm' AS MG_DATA_SOURCE_NAME
,riders_cte.GroupNbr AS MG_GROUP_NBR
,riders_cte.SubGroup AS MG_SUB_GROUP_NBR
,UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID ,C_TPA_ID, C_TPA_DIV_ID,C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY
,UTIL.FXN_ARRAY_HASH([R_TPA_CLIENT_ID, R_TPA_ID, R_TPA_DIV_ID, R_DATA_SOURCE_NAME, R_RIDER_CODE]) AS HUB_RIDER_HKEY
,UTIL.FXN_ARRAY_HASH([MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_GROUP_NBR, MG_SUB_GROUP_NBR]) AS HUB_MEMBERSHIP_GROUP_HKEY
,UTIL.FXN_ARRAY_HASH(
        [C_TPA_CLIENT_ID
        ,C_TPA_ID
        ,C_TPA_DIV_ID
        ,C_DATA_SOURCE_NAME
        ,C_CLAIM_NBR
        ,R_TPA_CLIENT_ID
        ,R_TPA_ID
        ,R_TPA_DIV_ID
        ,R_DATA_SOURCE_NAME
        ,R_RIDER_CODE
        ,MG_TPA_CLIENT_ID
        ,MG_TPA_ID
        ,MG_TPA_DIV_ID
        ,MG_DATA_SOURCE_NAME
        ,MG_GROUP_NBR
        ,MG_SUB_GROUP_NBR]
) AS LNK_CLAIM_RIDER_HKEY

from (
        select
        claims.tpaClient
        ,claims.tpaIdOfClient
        ,claims.tpaDivision
        ,claims.claimNbr
        ,trim(claims.groupNbr) as groupNbr
        ,trim(claims.subGroup) as subGroup
        ,trim(rider_codes.value) as riderCode
        from rawdata.mc400_dwoao_claims claims
                ,lateral flatten(input => (REGEXP_SUBSTR_ALL(claims.riders, '.{1,4}'))) RIDER_CODES  --split riders by every 4 characters
        where claims.memberNbr <> '99999999901' --Exclude Generic Default Member Claims
        and trim(rider_codes.value) <> ''
    ) riders_cte
    
    join rawdata.mc400_dwoao_riders riders
        on (riders.tpaClient = riders_cte.tpaClient
        and riders.tpaIdOfClient = riders_cte.tpaIdOfClient
        and riders.tpaDivision = riders_cte.tpaDivision
        and riders.riderCode = riders_cte.riderCode)

    join rawdata.mc400_dwoao_subgroups subGroups
        on (subGroups.tpaClient = riders_cte.tpaClient
        and subGroups.tpaIdOfClient = riders_cte.tpaIdOfClient
        and subGroups.tpaDivision = riders_cte.tpaDivision
        and subGroups.groupNbr = riders_cte.groupNbr
        and subGroups.subGroup = riders_cte.subGroup)
;
