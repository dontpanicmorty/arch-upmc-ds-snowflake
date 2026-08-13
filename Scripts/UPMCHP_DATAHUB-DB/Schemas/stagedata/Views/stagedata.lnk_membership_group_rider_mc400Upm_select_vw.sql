CREATE OR REPLACE VIEW STAGEDATA.LNK_MEMBERSHIP_GROUP_RIDER_MC400UPM_SELECT_VW
COMMENT = 'This is a LNK View containing Membership Group and Rider data'
AS
SELECT DISTINCT
SubGroups.TpaClient AS MG_TPA_CLIENT_ID
,SubGroups.TpaIdOfClient AS MG_TPA_ID
,SubGroups.TpaDivision AS MG_TPA_DIV_ID
,'MC400Upm' AS MG_DATA_SOURCE_NAME
,SubGroups.GroupNbr AS MG_GROUP_NBR
,SubGroups.SubGroup AS MG_SUB_GROUP_NBR
,Riders.TpaClient AS R_TPA_CLIENT_ID
,Riders.TpaIdOfClient AS R_TPA_ID
,Riders.TpaDivision AS R_TPA_DIV_ID
,'MC400Upm' AS R_DATA_SOURCE_NAME
,Riders.RiderCode AS R_RIDER_CODE
,UTIL.FXN_ARRAY_HASH([MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_GROUP_NBR, MG_SUB_GROUP_NBR, R_TPA_CLIENT_ID, R_TPA_ID, R_TPA_DIV_ID, R_DATA_SOURCE_NAME, R_RIDER_CODE]) AS LNK_MEMBERSHIP_GROUP_RIDER_HKEY
,UTIL.FXN_ARRAY_HASH([MG_TPA_CLIENT_ID, MG_TPA_ID, MG_TPA_DIV_ID, MG_DATA_SOURCE_NAME, MG_GROUP_NBR, MG_SUB_GROUP_NBR]) AS HUB_MEMBERSHIP_GROUP_HKEY
,UTIL.FXN_ARRAY_HASH([R_TPA_CLIENT_ID, R_TPA_ID, R_TPA_DIV_ID, R_DATA_SOURCE_NAME, R_RIDER_CODE]) AS HUB_RIDER_HKEY
FROM RAWDATA.MC400_DWOAO_RIDERS Riders
    JOIN RAWDATA.MC400_DWOAO_GROUPS Groups
        ON (Riders.GroupNbr = Groups.GroupNbr
        AND Riders.TpaClient = Groups.TpaClient
        AND Riders.TpaIdOfClient = Groups.TpaIdOfClient
        AND Riders.TpaDivision = Groups.TpaDivision)

    JOIN RAWDATA.MC400_DWOAO_SUBGROUPS SubGroups
        ON (Riders.GroupNbr = SubGroups.GroupNbr
        AND Riders.SubGroup = SubGroups.SubGroup
        AND Riders.TpaClient = SubGroups.TpaClient
        AND Riders.TpaIdOfClient = SubGroups.TpaIdOfClient
        AND Riders.TpaDivision = SubGroups.TpaDivision)
WHERE TRIM(Riders.SubGroup) <> ''
;
