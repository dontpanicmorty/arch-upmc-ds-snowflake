!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.LKP_CLAIM_MEMBER_SKYGEN_SELECT_VW
COMMENT = 'Translates Skygen member to UPMC MemberNbrs for use in other mappings'
AS
--this cte is temporary due to data quality issue with historical files - may need to be revisited

WITH ELIGIBILITY_HISTORY_CTE AS (
SELECT MEMBERNBR,
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

FROM (SELECT MEMBERNBR,
            TPACLIENT, 
            TPADIVISION, 
            TPAIDOFCLIENT, 
            TO_DATE(TO_CHAR(ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
            IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
            COVERAGEGROUPCODE, 
            SUBGROUPCODE, 
            PLANTYPE,
            PLANCODE, 
            TRANSFORM(REGEXP_SUBSTR_ALL(TRIM(ELIGIBILITYHISTORY.RIDERS), '.{1,4}'), x->TRIM(x)) AS RIDERS
        FROM &{MC400}.DWOAO.ELIGIBILITYHISTORY
 
        UNION ALL

        SELECT MEMBERNBR,
                TPACLIENT, 
                TPADIVISION, 
                TPAIDOFCLIENT, 
                TO_DATE(TO_CHAR(ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
                IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
                COVERAGEGROUPCODE, 
                SUBGROUPCODE, 
                PLANTYPE,
                PLANCODE, 
                TRANSFORM(REGEXP_SUBSTR_ALL(TRIM(ELIGIBILITYHISTORY.RIDERS), '.{1,4}'), x->TRIM(x)) AS RIDERS
        FROM &{MC400}.DWDNV_NONCLAIMS.ELIGIBILITYHISTORY
        )
)

,LKP_CTE AS (

SELECT DISTINCT
SKYGEN_CLAIMS.CLAIM_NBR,
IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient) AS TPA_CLIENT_ID,
IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient) AS TPA_ID,
IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision) AS TPA_DIV_ID,
'Skygen' AS DATA_SOURCE_NAME,
SKYGEN_CLAIMS.MEMBER_NBR AS CLAIM_MEMBER_NBR,
IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) AS MC400_MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE,
COALESCE(EligibilityHistory.Riders, MEMBERS_EMPNO.Riders, EligibilityHistory_Split.Riders) AS RIDERS_ARRAY

FROM ( 
        SELECT DISTINCT
        CLAIM_NBR
        ,MEMBER_NBR
        ,ADMIT_DATE
        FROM RAWDATA.DWSKYGEN_CLAIM_HEADER

        UNION ALL

        SELECT DISTINCT
        CLAIM_NO AS CLAIM_NBR
        ,SUBSCRIBER_ID AS MEMBER_NBR
        ,TO_DATE(SERVICE_DT,'YYYYMMDD') AS ADMIT_DATE
        FROM RAWDATA.SKYGEN_PAID_CLAIM_EXTRACTS_CURRENT_VW
        WHERE CLAIM_NO NOT IN (SELECT CLAIM_NBR FROM RAWDATA.DWSKYGEN_CLAIM_HEADER)
    ) SKYGEN_CLAIMS

    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (SKYGEN_CLAIMS.MEMBER_NBR = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory--Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND EligibilityHistory.EligibilityStartDate <= SKYGEN_CLAIMS.ADMIT_DATE
        AND EligibilityHistory.EligibilityEndDate >= SKYGEN_CLAIMS.ADMIT_DATE)

     LEFT OUTER JOIN --Find members by EmployeeNbr where eligibility matches
            (SELECT DISTINCT MEMBERS.MemberNbr, 
                    MEMBERS.EmployeeNbr,
                    MEMBERS.TpaClient,
                    MEMBERS.TpaIdOfClient,
                    MEMBERS.TpaDivision,
                    MEMBERS.MedicaidId,
                    ELIGIBILITY_HISTORY_CTE.EligibilityStartDate,
                    ELIGIBILITY_HISTORY_CTE.EligibilityEndDate,
                    ELIGIBILITY_HISTORY_CTE.CoverageGroupCode,
                    ELIGIBILITY_HISTORY_CTE.SubGroupCode,
                    ELIGIBILITY_HISTORY_CTE.PlanType,
                    ELIGIBILITY_HISTORY_CTE.PlanCode,
                    ELIGIBILITY_HISTORY_CTE.Riders
            FROM &{MC400}.DWOAO.MEMBERS
                JOIN ELIGIBILITY_HISTORY_CTE
                    ON (MEMBERS.MemberNbr = ELIGIBILITY_HISTORY_CTE.MemberNbr
                    AND MEMBERS.TpaClient = ELIGIBILITY_HISTORY_CTE.TpaClient
                    AND MEMBERS.TpaIdOfClient = ELIGIBILITY_HISTORY_CTE.TpaIdOfClient
                    AND MEMBERS.TpaDivision = ELIGIBILITY_HISTORY_CTE.TpaDivision
                    AND ELIGIBILITY_HISTORY_CTE.PlanType IN ('1','B','D','4')) /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            ) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = SKYGEN_CLAIMS.MEMBER_NBR
        AND MEMBERS_EMPNO.ELIGIBILITYSTARTDATE <= SKYGEN_CLAIMS.ADMIT_DATE
        AND MEMBERS_EMPNO.ELIGIBILITYENDDATE >= SKYGEN_CLAIMS.ADMIT_DATE)
    
    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND EligibilityHistory_Split.EligibilityStartDate <= SKYGEN_CLAIMS.ADMIT_DATE
        AND EligibilityHistory_Split.EligibilityEndDate >= SKYGEN_CLAIMS.ADMIT_DATE)
       
    LEFT OUTER JOIN &{MC400}.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr))

WHERE IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND COVERAGE_GROUP_CODE IS NOT NULL
AND SKYGEN_CLAIMS.MEMBER_NBR <> '9999999999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
)

,LKP_CTE_MAX_PRIOR 
AS 
(
SELECT DISTINCT
SKYGEN_CLAIMS.CLAIM_NBR,
IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient) AS TPA_CLIENT_ID,
IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient) AS TPA_ID,
IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision) AS TPA_DIV_ID,
'Skygen' AS DATA_SOURCE_NAME,
SKYGEN_CLAIMS.MEMBER_NBR AS CLAIM_MEMBER_NBR,
IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) AS MC400_MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE,
COALESCE(EligibilityHistory.Riders, MEMBERS_EMPNO.Riders, EligibilityHistory_Split.Riders) AS RIDERS_ARRAY,
COALESCE(EligibilityHistory.ELIGIBILITY_RANK, MEMBERS_EMPNO.ELIGIBILITY_RANK, EligibilityHistory_Split.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM ( 
        SELECT DISTINCT
        CLAIM_NBR
        ,MEMBER_NBR
        ,ADMIT_DATE
        FROM RAWDATA.DWSKYGEN_CLAIM_HEADER

        UNION ALL

        SELECT DISTINCT
        CLAIM_NO AS CLAIM_NBR
        ,SUBSCRIBER_ID AS MEMBER_NBR
        ,TO_DATE(SERVICE_DT,'YYYYMMDD') AS ADMIT_DATE
        FROM RAWDATA.SKYGEN_PAID_CLAIM_EXTRACTS_CURRENT_VW
        WHERE CLAIM_NO NOT IN (SELECT CLAIM_NBR FROM RAWDATA.DWSKYGEN_CLAIM_HEADER)
    ) SKYGEN_CLAIMS

    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (SKYGEN_CLAIMS.MEMBER_NBR = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory--Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND EligibilityHistory.EligibilityStartDate <= SKYGEN_CLAIMS.ADMIT_DATE
        )

     LEFT OUTER JOIN --Find members by EmployeeNbr where eligibility matches
            (SELECT DISTINCT MEMBERS.MemberNbr, 
                    MEMBERS.EmployeeNbr,
                    MEMBERS.TpaClient,
                    MEMBERS.TpaIdOfClient,
                    MEMBERS.TpaDivision,
                    MEMBERS.MedicaidId,
                    ELIGIBILITY_HISTORY_CTE.EligibilityStartDate,
                    ELIGIBILITY_HISTORY_CTE.EligibilityEndDate,
                    ELIGIBILITY_HISTORY_CTE.CoverageGroupCode,
                    ELIGIBILITY_HISTORY_CTE.SubGroupCode,
                    ELIGIBILITY_HISTORY_CTE.PlanType,
                    ELIGIBILITY_HISTORY_CTE.PlanCode,
                    ELIGIBILITY_HISTORY_CTE.Riders,
                    ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK
            FROM &{MC400}.DWOAO.MEMBERS
                JOIN ELIGIBILITY_HISTORY_CTE
                    ON (MEMBERS.MemberNbr = ELIGIBILITY_HISTORY_CTE.MemberNbr
                    AND MEMBERS.TpaClient = ELIGIBILITY_HISTORY_CTE.TpaClient
                    AND MEMBERS.TpaIdOfClient = ELIGIBILITY_HISTORY_CTE.TpaIdOfClient
                    AND MEMBERS.TpaDivision = ELIGIBILITY_HISTORY_CTE.TpaDivision
                    AND ELIGIBILITY_HISTORY_CTE.PlanType IN ('1','B','D','4')) /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            ) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = SKYGEN_CLAIMS.MEMBER_NBR
        AND MEMBERS_EMPNO.ELIGIBILITYSTARTDATE <= SKYGEN_CLAIMS.ADMIT_DATE)
    
    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND EligibilityHistory_Split.EligibilityStartDate <= SKYGEN_CLAIMS.ADMIT_DATE)
       
    LEFT OUTER JOIN &{MC400}.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr)
        )

WHERE IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND COVERAGE_GROUP_CODE IS NOT NULL
AND SKYGEN_CLAIMS.MEMBER_NBR <> '9999999999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
AND SKYGEN_CLAIMS.CLAIM_NBR NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE)
)

,LKP_CTE_MIN_AFTER
AS 
(
SELECT DISTINCT
SKYGEN_CLAIMS.CLAIM_NBR,
IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient) AS TPA_CLIENT_ID,
IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient) AS TPA_ID,
IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision) AS TPA_DIV_ID,
'Skygen' AS DATA_SOURCE_NAME,
SKYGEN_CLAIMS.MEMBER_NBR AS CLAIM_MEMBER_NBR,
IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) AS MC400_MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE,
COALESCE(EligibilityHistory.Riders, MEMBERS_EMPNO.Riders, EligibilityHistory_Split.Riders) AS RIDERS_ARRAY,
COALESCE(EligibilityHistory.ELIGIBILITY_RANK, MEMBERS_EMPNO.ELIGIBILITY_RANK, EligibilityHistory_Split.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK

FROM ( 
        SELECT DISTINCT
        CLAIM_NBR
        ,MEMBER_NBR
        ,ADMIT_DATE
        FROM RAWDATA.DWSKYGEN_CLAIM_HEADER

        UNION ALL

        SELECT DISTINCT
        CLAIM_NO AS CLAIM_NBR
        ,SUBSCRIBER_ID AS MEMBER_NBR
        ,TO_DATE(SERVICE_DT,'YYYYMMDD') AS ADMIT_DATE
        FROM RAWDATA.SKYGEN_PAID_CLAIM_EXTRACTS_CURRENT_VW
        WHERE CLAIM_NO NOT IN (SELECT CLAIM_NBR FROM RAWDATA.DWSKYGEN_CLAIM_HEADER)
    ) SKYGEN_CLAIMS

    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (SKYGEN_CLAIMS.MEMBER_NBR = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory--Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND EligibilityHistory.EligibilityStartDate > SKYGEN_CLAIMS.ADMIT_DATE
        )

     LEFT OUTER JOIN --Find members by EmployeeNbr where eligibility matches
            (SELECT DISTINCT MEMBERS.MemberNbr, 
                    MEMBERS.EmployeeNbr,
                    MEMBERS.TpaClient,
                    MEMBERS.TpaIdOfClient,
                    MEMBERS.TpaDivision,
                    MEMBERS.MedicaidId,
                    ELIGIBILITY_HISTORY_CTE.EligibilityStartDate,
                    ELIGIBILITY_HISTORY_CTE.EligibilityEndDate,
                    ELIGIBILITY_HISTORY_CTE.CoverageGroupCode,
                    ELIGIBILITY_HISTORY_CTE.SubGroupCode,
                    ELIGIBILITY_HISTORY_CTE.PlanType,
                    ELIGIBILITY_HISTORY_CTE.PlanCode,
                    ELIGIBILITY_HISTORY_CTE.Riders,
                    ELIGIBILITY_HISTORY_CTE.ELIGIBILITY_RANK
            FROM &{MC400}.DWOAO.MEMBERS
                JOIN ELIGIBILITY_HISTORY_CTE
                    ON (MEMBERS.MemberNbr = ELIGIBILITY_HISTORY_CTE.MemberNbr
                    AND MEMBERS.TpaClient = ELIGIBILITY_HISTORY_CTE.TpaClient
                    AND MEMBERS.TpaIdOfClient = ELIGIBILITY_HISTORY_CTE.TpaIdOfClient
                    AND MEMBERS.TpaDivision = ELIGIBILITY_HISTORY_CTE.TpaDivision
                    AND ELIGIBILITY_HISTORY_CTE.PlanType IN ('1','B','D','4')) /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            ) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = SKYGEN_CLAIMS.MEMBER_NBR
        AND MEMBERS_EMPNO.ELIGIBILITYSTARTDATE > SKYGEN_CLAIMS.ADMIT_DATE)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND EligibilityHistory_Split.EligibilityStartDate > SKYGEN_CLAIMS.ADMIT_DATE)

    LEFT OUTER JOIN &{MC400}.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr))

WHERE IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND SKYGEN_CLAIMS.MEMBER_NBR <> '9999999999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
AND SKYGEN_CLAIMS.CLAIM_NBR NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE)
AND SKYGEN_CLAIMS.CLAIM_NBR NOT IN (SELECT DISTINCT CLAIM_NBR FROM LKP_CTE_MAX_PRIOR)
)

SELECT CLAIM_NBR,
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_MEMBER_NBR,
MC400_MEMBER_NBR,
MASTER_MEMBER_ID,
COVERAGE_GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE,
PLAN_CODE,
RIDERS_ARRAY
FROM LKP_CTE

UNION ALL

SELECT CLAIM_NBR,
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_MEMBER_NBR,
MC400_MEMBER_NBR,
MASTER_MEMBER_ID,
COVERAGE_GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE,
PLAN_CODE,
RIDERS_ARRAY
FROM LKP_CTE_MAX_PRIOR
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MAX(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MAX_PRIOR AS MAX_RANK
                          WHERE MAX_RANK.CLAIM_NBR = LKP_CTE_MAX_PRIOR.CLAIM_NBR
                          AND MAX_RANK.TPA_CLIENT_ID = LKP_CTE_MAX_PRIOR.TPA_CLIENT_ID
                          AND MAX_RANK.TPA_ID = LKP_CTE_MAX_PRIOR.TPA_ID
                          AND MAX_RANK.TPA_DIV_ID = LKP_CTE_MAX_PRIOR.TPA_DIV_ID
                          AND MAX_RANK.DATA_SOURCE_NAME = LKP_CTE_MAX_PRIOR.DATA_SOURCE_NAME
                          )
UNION ALL

SELECT CLAIM_NBR,
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
DATA_SOURCE_NAME,
CLAIM_MEMBER_NBR,
MC400_MEMBER_NBR,
MASTER_MEMBER_ID,
COVERAGE_GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE,
PLAN_CODE,
RIDERS_ARRAY
FROM LKP_CTE_MIN_AFTER
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MIN(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MIN_AFTER AS MIN_RANK
                          WHERE MIN_RANK.CLAIM_NBR = LKP_CTE_MIN_AFTER.CLAIM_NBR
                          AND MIN_RANK.TPA_CLIENT_ID = LKP_CTE_MIN_AFTER.TPA_CLIENT_ID
                          AND MIN_RANK.TPA_ID = LKP_CTE_MIN_AFTER.TPA_ID
                          AND MIN_RANK.TPA_DIV_ID = LKP_CTE_MIN_AFTER.TPA_DIV_ID
                          AND MIN_RANK.DATA_SOURCE_NAME = LKP_CTE_MIN_AFTER.DATA_SOURCE_NAME
                          )
;

set variable_substitution=true;