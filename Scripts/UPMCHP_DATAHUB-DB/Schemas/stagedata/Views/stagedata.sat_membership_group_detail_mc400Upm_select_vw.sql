CREATE OR REPLACE VIEW STAGEDATA.SAT_MEMBERSHIP_GROUP_DETAIL_MC400UPM_SELECT_VW
COMMENT = 'This is a HUB View containing Membership Group Detail data'
AS
SELECT
Groups.TpaClient AS TPA_CLIENT_ID
,Groups.TpaIdOfClient AS TPA_ID
,Groups.TpaDivision AS TPA_DIV_ID
,'MC400Upm' as DATA_SOURCE_NAME
,TRIM(SubGroups.GroupNbr) AS GROUP_NBR
,TRIM(SubGroups.SubGroup) AS SUB_GROUP_NBR
,Groups.NAME1 AS GROUP_NAME
,SubGroups.NAME1 AS SUB_GROUP_NAME
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, GROUP_NBR, SUB_GROUP_NBR]) AS HUB_MEMBERSHIP_GROUP_HKEY
FROM RAWDATA.MC400_DWOAO_SUBGROUPS SubGroups
    JOIN RAWDATA.MC400_DWOAO_GROUPS Groups
        ON (Groups.TpaClient = SubGroups.TpaClient
        AND Groups.TpaIdOfClient = SubGroups.TpaIdOfClient
        AND Groups.TpaDivision = SubGroups.TpaDivision
        AND Groups.GroupNbr = SubGroups.GroupNbr)
;
