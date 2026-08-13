create or replace view STAGEDATA.LNK_CLAIM_PLAN_MC400UPM_SELECT_VW
COMMENT='Source view for mc400Upm data into LNK_CLAIM_PLAN'
as
select
claims.TpaClient AS C_TPA_CLIENT_ID,
claims.TpaIdOfClient AS C_TPA_ID,
claims.TpaDivision AS C_TPA_DIV_ID,
'MC400Upm' AS C_DATA_SOURCE_NAME,
claims.ClaimNbr AS C_CLAIM_NBR,
claims.TpaClient AS P_TPA_CLIENT_ID,
claims.TpaIdOfClient AS P_TPA_ID,
claims.TpaDivision AS P_TPA_DIV_ID,
'MC400Upm' AS P_DATA_SOURCE_NAME,
claims.PlanCode AS P_PLAN_CODE,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR, P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PLAN_CODE]) AS LNK_CLAIM_PLAN_HKEY,
UTIL.FXN_ARRAY_HASH([C_TPA_CLIENT_ID, C_TPA_ID, C_TPA_DIV_ID, C_DATA_SOURCE_NAME, C_CLAIM_NBR]) AS HUB_CLAIM_HKEY,
UTIL.FXN_ARRAY_HASH([P_TPA_CLIENT_ID, P_TPA_ID, P_TPA_DIV_ID, P_DATA_SOURCE_NAME, P_PLAN_CODE]) AS HUB_PLAN_HKEY

from RAWDATA.MC400_DWOAO_CLAIMS claims
    join RAWDATA.MC400_DWOAO_PLANMASTER planMaster
        on (planMaster.tpaClient = claims.tpaclient
        and planMaster.tpaIdOfClient = claims.tpaidofclient
        and planMaster.tpaDivision = claims.tpadivision
        and planMaster.planCode = claims.planCode)
where Claims.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
;
