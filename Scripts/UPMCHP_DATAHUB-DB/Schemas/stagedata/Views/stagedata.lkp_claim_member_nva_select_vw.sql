!set variable_substitution=true;

/****************************************************
THIS WILL NEED REVISTED FOR THE 30 ODD RECORDS THAT DID NOT GET A MATCH ON MEMBER
 ****************************************************/
CREATE OR REPLACE VIEW STAGEDATA.LKP_CLAIM_MEMBER_NVA_SELECT_VW
COMMENT = 'Translates NVA member to UPMC memberNbrs and memershipGroups for use in other mappings'
AS
WITH NVA_CLAIMS AS (
SELECT NVA_PAID_CLAIM_EXTRACTS_VW."ClaimNo", 
       NVA_PAID_CLAIM_EXTRACTS_VW.DOS,
       NVA_PAID_CLAIM_EXTRACTS_VW."MemberID",
       NVA_PAID_CLAIM_EXTRACTS_VW."PlanCode"
FROM RAWDATA.NVA_PAID_CLAIM_EXTRACTS_VW
WHERE NVA_PAID_CLAIM_EXTRACTS_VW."ClaimNo" <> 'TRAILER'
QUALIFY ROW_NUMBER() -- get the most current submitted file for a claim line
    OVER(PARTITION BY NVA_PAID_CLAIM_EXTRACTS_VW."ClaimNo"
    ORDER BY split_part(split_part(NVA_PAID_CLAIM_EXTRACTS_VW.filename, '_', 7), '.', 1) DESC) = 1 
)

,ELIGIBILITY_HISTORY_CTE AS (
    
SELECT MEMBERNBR,
        EMPLOYEENBR,
        TPACLIENT,
        TPADIVISION,
        TPAIDOFCLIENT,
        ELIGIBILITYSTARTDATE,
        ELIGIBILITYENDDATE,
        COVERAGEGROUPCODE,
        SUBGROUPCODE,
        PLANTYPE,
        PLANCODE,
        RIDERS,
        DENSE_RANK() OVER(PARTITION BY MEMBERNBR, TPACLIENT, TPADIVISION,TPAIDOFCLIENT ORDER BY ELIGIBILITYSTARTDATE) AS ELIGIBILITY_RANK

FROM (SELECT MEMBERS.MEMBERNBR,
            IFF(TRIM(MEMBERS.EMPLOYEENBR) = '', NULL, MEMBERS.EMPLOYEENBR) AS EMPLOYEENBR,
            MEMBERS.TPACLIENT, 
            MEMBERS.TPADIVISION, 
            MEMBERS.TPAIDOFCLIENT, 
            TO_DATE(TO_CHAR(ELIGIBILITYHISTORY.ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
            IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYHISTORY.ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
            ELIGIBILITYHISTORY.COVERAGEGROUPCODE, 
            ELIGIBILITYHISTORY.SUBGROUPCODE, 
            ELIGIBILITYHISTORY.PLANTYPE,
            ELIGIBILITYHISTORY.PLANCODE, 
            REGEXP_SUBSTR_ALL(ELIGIBILITYHISTORY.RIDERS, '.{1,4}') AS RIDERS
        FROM &{MC400}.DWOAO.ELIGIBILITYHISTORY
        JOIN &{MC400}.DWOAO.MEMBERS
            ON MEMBERS.MEMBERNBR = ELIGIBILITYHISTORY.MEMBERNBR
 
        UNION ALL

        SELECT MEMBERS.MEMBERNBR,
                IFF(TRIM(MEMBERS.EMPLOYEENBR) = '', NULL, MEMBERS.EMPLOYEENBR) AS EMPLOYEENBR,
                MEMBERS.TPACLIENT, 
                MEMBERS.TPADIVISION, 
                MEMBERS.TPAIDOFCLIENT, 
                TO_DATE(TO_CHAR(ELIGIBILITYHISTORY.ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
                IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYHISTORY.ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
                ELIGIBILITYHISTORY.COVERAGEGROUPCODE, 
                ELIGIBILITYHISTORY.SUBGROUPCODE, 
                ELIGIBILITYHISTORY.PLANTYPE,
                ELIGIBILITYHISTORY.PLANCODE, 
                REGEXP_SUBSTR_ALL(ELIGIBILITYHISTORY.RIDERS, '.{1,4}') AS RIDERS
        FROM &{MC400}.DWDNV_NONCLAIMS.ELIGIBILITYHISTORY
        JOIN &{MC400}.DWDNV_NONCLAIMS.MEMBERS
            ON MEMBERS.MEMBERNBR = ELIGIBILITYHISTORY.MEMBERNBR
        )
)

,LKP_CTE_NONTERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityEndDate >= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
                AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND MembershipEmp.EligibilityEndDate >= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%'
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
)

,LKP_CTE_MAX_PRIOR_NONTERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY
,COALESCE(ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK, MembershipEmp.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate 
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%' 
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_NONTERMED)
)

,LKP_CTE_MIN_AFTER_NONTERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY
,COALESCE(ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK, MembershipEmp.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate > TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate 
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp      
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate > TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate 
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%'
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR_NONTERMED)
)


,LKP_CTE_TERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityEndDate >= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
                AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <> ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp      
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND MembershipEmp.EligibilityEndDate >= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%'
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MIN_AFTER_NONTERMED)
)

,LKP_CTE_MAX_PRIOR_TERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY
,COALESCE(ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK, MembershipEmp.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate = ELIGIBILITY_HISTORY_CTE.EligibilityEndDate 
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp      
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate <= TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate = ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%' 
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MIN_AFTER_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_TERMED)
)

,LKP_CTE_MIN_AFTER_TERMED AS (

SELECT DISTINCT
IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaClient, MembershipEmp.TpaClientEmp) AS TPA_CLIENT_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaIdOfClient, MembershipEmp.TpaIdOfClientEmp) AS TPA_ID
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.TpaDivision, MembershipEmp.TpaDivisionEmp) AS TPA_DIV_ID
,'NVA' AS DATA_SOURCE_NAME
,NVA_CLAIMS."ClaimNo" AS CLAIM_NBR
,IFF(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode IS NOT NULL, MembersCombined.MemberNbr, MembershipEmp.MemberNbr) AS MEMBER_NBR
,MasterMemberId.SourceSystem AS SOURCE_SYSTEM
,MasterMemberId.MasterMember AS MASTER_MEMBER_ID
,COALESCE(ELIGIBILITY_HISTORY_CTE.CoverageGroupCode, MembershipEmp.CoverageGroupCode) AS GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.SubGroupCode, MembershipEmp.SubGroupCode) AS SUB_GROUP_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanType, MembershipEmp.PlanType) AS PLAN_TYPE_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.PlanCode, MembershipEmp.PlanCode) AS PLAN_CODE
,COALESCE(ELIGIBILITY_HISTORY_CTE.Riders, MembershipEmp.Riders) AS RIDER_ARRAY
,COALESCE(ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK, MembershipEmp.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM NVA_CLAIMS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWOAO.EmployeeNbr) = '', NULL, Members_DWOAO.EmployeeNbr) AS EmployeeNbr, Members_DWOAO.TpaClient, Members_DWOAO.TpaIdOfClient, Members_DWOAO.TpaDivision
            FROM &{MC400}.DWOAO.Members Members_DWOAO
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr, PersonNbr, IFF(TRIM(Members_DWDNV_NONCLAIMS.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS.EmployeeNbr) AS EmployeeNbr, Members_DWDNV_NONCLAIMS.TpaClient, Members_DWDNV_NONCLAIMS.TpaIdOfClient, Members_DWDNV_NONCLAIMS.TpaDivision
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS
            ) AS MembersCombined
        ON (MembersCombined.MemberNbr = NVA_CLAIMS."MemberID")

    LEFT OUTER JOIN &{MC400}.DWOAO.MasterMemberId
        ON (MasterMemberId.TpaClient = '000001' --These are hardcoded because master member only exists in dwoao div 0001
        AND MasterMemberId.TpaIdOfClient = '000001'
        AND MasterMemberId.TpaDivision = '0001'
        AND MasterMemberId.SourceId = MembersCombined.MemberNbr)


    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
        ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersCombined.TpaClient
        AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersCombined.TpaIdOfClient
        AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersCombined.TpaDivision
        AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersCombined.MemberNbr
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate > TRY_TO_DATE(NVA_CLAIMS."DOS")
        AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate = ELIGIBILITY_HISTORY_CTE.EligibilityEndDate 
        )
LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (
            SELECT * FROM 
            (SELECT 'DWOAO' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(MEMBERS_DWOAO2.EmployeeNbr) = '', NULL, MEMBERS_DWOAO2.EmployeeNbr) AS EmployeeNbr2, MEMBERS_DWOAO2.TpaClient AS TpaClientEmp, MEMBERS_DWOAO2.TpaIdOfClient AS TpaIdOfClientEmp, MEMBERS_DWOAO2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWOAO.Members MEMBERS_DWOAO2
            UNION ALL
            SELECT 'DWDNV_NONCLAIMS' AS SOURCE_SYSTEM, MemberNbr AS MemberNbrEmp, PersonNbr AS PersonNbrEmp, IFF(TRIM(Members_DWDNV_NONCLAIMS2.EmployeeNbr) = '', NULL, Members_DWDNV_NONCLAIMS2.EmployeeNbr) AS EmployeeNbr2, Members_DWDNV_NONCLAIMS2.TpaClient  AS TpaClientEmp, Members_DWDNV_NONCLAIMS2.TpaIdOfClient AS TpaIdOfClientEmp, Members_DWDNV_NONCLAIMS2.TpaDivision AS TpaDivisionEmp
            FROM &{MC400}.DWDNV_NONCLAIMS.Members Members_DWDNV_NONCLAIMS2
            ) AS MembersEmployeeNbr
            JOIN ELIGIBILITY_HISTORY_CTE
                ON (ELIGIBILITY_HISTORY_CTE.TpaClient = MembersEmployeeNbr.TpaClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaIdOfClient = MembersEmployeeNbr.TpaIdOfClientEmp
                AND ELIGIBILITY_HISTORY_CTE.TpaDivision = MembersEmployeeNbr.TpaDivisionEmp
                AND ELIGIBILITY_HISTORY_CTE.MemberNbr = MembersEmployeeNbr.MemberNbrEmp
        )
        )MembershipEmp

        ON (MembersCombined.EmployeeNbr = MembershipEmp.EmployeeNbr2
            AND MembersCombined.PersonNbr = MembershipEmp.PersonNbrEmp      
            AND MembersCombined.SOURCE_SYSTEM <> MembershipEmp.SOURCE_SYSTEM
            AND MembershipEmp.EligibilityStartDate > TRY_TO_DATE(NVA_CLAIMS."DOS")
            AND ELIGIBILITY_HISTORY_CTE.EligibilityStartDate = ELIGIBILITY_HISTORY_CTE.EligibilityEndDate
            AND NVA_CLAIMS."DOS" BETWEEN '2018-01-01' AND '2019-12-31'
            AND NVA_CLAIMS."PlanCode" LIKE '7108%'  
            )
WHERE TPA_CLIENT_ID IS NOT NULL
AND GROUP_CODE IS NOT NULL
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MIN_AFTER_NONTERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_TERMED)
AND NVA_CLAIMS."ClaimNo" NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR_TERMED)
)


SELECT 
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_NONTERMED

UNION ALL

SELECT TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_MAX_PRIOR_NONTERMED
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MAX(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MAX_PRIOR_NONTERMED AS MAX_RANK
                          WHERE MAX_RANK.CLAIM_NBR = LKP_CTE_MAX_PRIOR_NONTERMED.CLAIM_NBR
                          AND MAX_RANK.TPA_CLIENT_ID = LKP_CTE_MAX_PRIOR_NONTERMED.TPA_CLIENT_ID
                          AND MAX_RANK.TPA_ID = LKP_CTE_MAX_PRIOR_NONTERMED.TPA_ID
                          AND MAX_RANK.TPA_DIV_ID = LKP_CTE_MAX_PRIOR_NONTERMED.TPA_DIV_ID
                          AND MAX_RANK.DATA_SOURCE_NAME = LKP_CTE_MAX_PRIOR_NONTERMED.DATA_SOURCE_NAME
                          )
UNION ALL

SELECT TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_MIN_AFTER_NONTERMED
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MIN(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MIN_AFTER_NONTERMED AS MIN_RANK
                          WHERE MIN_RANK.CLAIM_NBR = LKP_CTE_MIN_AFTER_NONTERMED.CLAIM_NBR
                          AND MIN_RANK.TPA_CLIENT_ID = LKP_CTE_MIN_AFTER_NONTERMED.TPA_CLIENT_ID
                          AND MIN_RANK.TPA_ID = LKP_CTE_MIN_AFTER_NONTERMED.TPA_ID
                          AND MIN_RANK.TPA_DIV_ID = LKP_CTE_MIN_AFTER_NONTERMED.TPA_DIV_ID
                          AND MIN_RANK.DATA_SOURCE_NAME = LKP_CTE_MIN_AFTER_NONTERMED.DATA_SOURCE_NAME
                          )
UNION ALL

SELECT 
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_TERMED

UNION ALL

SELECT TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_MAX_PRIOR_TERMED
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MAX(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MAX_PRIOR_TERMED AS MAX_RANK
                          WHERE MAX_RANK.CLAIM_NBR = LKP_CTE_MAX_PRIOR_TERMED.CLAIM_NBR
                          AND MAX_RANK.TPA_CLIENT_ID = LKP_CTE_MAX_PRIOR_TERMED.TPA_CLIENT_ID
                          AND MAX_RANK.TPA_ID = LKP_CTE_MAX_PRIOR_TERMED.TPA_ID
                          AND MAX_RANK.TPA_DIV_ID = LKP_CTE_MAX_PRIOR_TERMED.TPA_DIV_ID
                          AND MAX_RANK.DATA_SOURCE_NAME = LKP_CTE_MAX_PRIOR_TERMED.DATA_SOURCE_NAME
                          )
UNION ALL

SELECT TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_NBR,
SOURCE_SYSTEM,
MEMBER_NBR,
MASTER_MEMBER_ID,
GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE_CODE,
PLAN_CODE,
RIDER_ARRAY
FROM LKP_CTE_MIN_AFTER_TERMED
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MIN(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MIN_AFTER_TERMED AS MIN_RANK
                          WHERE MIN_RANK.CLAIM_NBR = LKP_CTE_MIN_AFTER_TERMED.CLAIM_NBR
                          AND MIN_RANK.TPA_CLIENT_ID = LKP_CTE_MIN_AFTER_TERMED.TPA_CLIENT_ID
                          AND MIN_RANK.TPA_ID = LKP_CTE_MIN_AFTER_TERMED.TPA_ID
                          AND MIN_RANK.TPA_DIV_ID = LKP_CTE_MIN_AFTER_TERMED.TPA_DIV_ID
                          AND MIN_RANK.DATA_SOURCE_NAME = LKP_CTE_MIN_AFTER_TERMED.DATA_SOURCE_NAME
                          )
;                                    
!set variable_substitution=false;
