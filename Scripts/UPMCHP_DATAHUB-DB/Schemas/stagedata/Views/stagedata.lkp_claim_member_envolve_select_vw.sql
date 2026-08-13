CREATE OR REPLACE VIEW STAGEDATA.LKP_CLAIM_MEMBER_ENVOLVE_SELECT_VW(
	CLAIM_NBR,
	TPA_CLIENT_ID,
	TPA_ID,
	TPA_DIV_ID,
	DATA_SOURCE_NAME,
	CLAIM_MEMBER_NBR,
	MEMBER_NBR,
	MASTER_MEMBER_ID,
	GROUP_CODE,
	SUB_GROUP_CODE,
	PLAN_TYPE_CODE,
	PLAN_CODE,
    RIDER_ARRAY
) COMMENT='Translates ENVOLVE member to UPMC MemberNbrs for use in other mappings'
 AS
WITH ELIGIBILITY_HISTORY_CTE AS (
SELECT MEMBERNBR,
        EXTERNALMEMBER,
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
            EXTERNALMEMBER,
            TPACLIENT, 
            TPADIVISION, 
            TPAIDOFCLIENT, 
            TO_DATE(TO_CHAR(ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
            IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
            COVERAGEGROUPCODE, 
            SUBGROUPCODE, 
            PLANTYPE,
            PLANCODE, 
            RIDERS
        FROM MC400.DWOAO.ELIGIBILITYHISTORY
 
        UNION ALL

        SELECT MEMBERNBR,
                EXTERNALMEMBER,
                TPACLIENT, 
                TPADIVISION, 
                TPAIDOFCLIENT, 
                TO_DATE(TO_CHAR(ELIGIBILITYSTARTDATE), 'YYYYMMDD') AS ELIGIBILITYSTARTDATE,
                IFNULL(TRY_TO_DATE(TO_CHAR(ELIGIBILITYENDDATE), 'YYYYMMDD'), '9999-12-31') AS ELIGIBILITYENDDATE,
                COVERAGEGROUPCODE, 
                SUBGROUPCODE, 
                PLANTYPE,
                PLANCODE, 
                RIDERS
        FROM MC400.DWDNV_NONCLAIMS.ELIGIBILITYHISTORY
        )
)

,LKP_CTE AS (

SELECT DISTINCT
ENVOLVE_CLAIM_EXTRACTS.CLAIM_NO,
COALESCE(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient, ELIGIBILITY_HISTORY_EMP.TPACLIENT) AS TPA_CLIENT_ID,
COALESCE(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient, ELIGIBILITY_HISTORY_EMP.TPAIDOFCLIENT) AS TPA_ID,
COALESCE(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision, ELIGIBILITY_HISTORY_EMP.TPADIVISION) AS TPA_DIV_ID,
'Envolve' AS SOURCE_SYSTEM,
REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', '') AS CLAIM_MEMBER_NBR,
COALESCE(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr,ELIGIBILITY_HISTORY_EMP.MEMBERNBR) AS MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE,
REGEXP_SUBSTR_ALL(ELIGIBILITYHISTORY.RIDERS, '.{1,4}') AS RIDERS

FROM RAWDATA.ENVOLVE_CLAIM_EXTRACTS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM MC400.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM MC400.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 11, '0') = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory--Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND EligibilityHistory.EligibilityStartDate <= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD')
        AND EligibilityHistory.EligibilityEndDate >= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))

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
            FROM MC400.DWOAO.MEMBERS
            LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE
                    ON (MEMBERS.MEMBERNBR = ELIGIBILITY_HISTORY_CTE.MEMBERNBR
                    AND MEMBERS.TpaClient = ELIGIBILITY_HISTORY_CTE.TpaClient
                    AND MEMBERS.TpaIdOfClient = ELIGIBILITY_HISTORY_CTE.TpaIdOfClient
                    AND MEMBERS.TpaDivision = ELIGIBILITY_HISTORY_CTE.TpaDivision
                    AND ELIGIBILITY_HISTORY_CTE.PlanType IN ('1','B','D','4')) /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            ) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 10, '0')
        AND MEMBERS_EMPNO.ELIGIBILITYSTARTDATE <= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD')
        AND MEMBERS_EMPNO.ELIGIBILITYENDDATE >= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))
    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE ELIGIBILITY_HISTORY_EMP
            ON (ELIGIBILITY_HISTORY_EMP.EXTERNALMEMBER = LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 10, '0'))
    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND EligibilityHistory_Split.EligibilityStartDate <= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD')
        AND EligibilityHistory_Split.EligibilityEndDate >= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))
       
    LEFT OUTER JOIN MC400.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr))

WHERE COALESCE(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr,ELIGIBILITY_HISTORY_EMP.MEMBERNBR) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID <> 'UPMC99999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
QUALIFY ROW_NUMBER() -- get the most current submitted file for a claim line
OVER(PARTITION BY ENVOLVE_CLAIM_EXTRACTS.CLAIM_NO
   ORDER BY split_part(split_part(ENVOLVE_CLAIM_EXTRACTS.filename, '_', 7), '.', 1) DESC) = 1 
    )

,LKP_CTE_MAX AS (

SELECT DISTINCT
ENVOLVE_CLAIM_EXTRACTS.CLAIM_NO,
COALESCE(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient, ELIGIBILITY_HISTORY_EMP.TPACLIENT) AS TPA_CLIENT_ID,
COALESCE(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient, ELIGIBILITY_HISTORY_EMP.TPAIDOFCLIENT) AS TPA_ID,
COALESCE(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision, ELIGIBILITY_HISTORY_EMP.TPADIVISION) AS TPA_DIV_ID,
'Envolve' AS SOURCE_SYSTEM,
REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', '') AS CLAIM_MEMBER_NBR,
COALESCE(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr,ELIGIBILITY_HISTORY_EMP.MEMBERNBR) AS MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE,
COALESCE(EligibilityHistory.ELIGIBILITY_RANK, MEMBERS_EMPNO.ELIGIBILITY_RANK, EligibilityHistory_Split.ELIGIBILITY_RANK) AS MASTER_ELIGIBILITY_RANK,
REGEXP_SUBSTR_ALL(ELIGIBILITYHISTORY.RIDERS, '.{1,4}') AS RIDERS

FROM RAWDATA.ENVOLVE_CLAIM_EXTRACTS
    LEFT OUTER JOIN --Get full list of members from MC400 to find member for claim
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM MC400.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM MC400.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 11, '0') = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory--Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND EligibilityHistory.EligibilityStartDate <=TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))

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
            FROM MC400.DWOAO.MEMBERS
                JOIN ELIGIBILITY_HISTORY_CTE
                    ON (MEMBERS.MEMBERNBR = ELIGIBILITY_HISTORY_CTE.MEMBERNBR
                    AND MEMBERS.TpaClient = ELIGIBILITY_HISTORY_CTE.TpaClient
                    AND MEMBERS.TpaIdOfClient = ELIGIBILITY_HISTORY_CTE.TpaIdOfClient
                    AND MEMBERS.TpaDivision = ELIGIBILITY_HISTORY_CTE.TpaDivision
                    AND ELIGIBILITY_HISTORY_CTE.PlanType IN ('1','B','D','4') /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            )) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 10, '0')
        AND MEMBERS_EMPNO.ELIGIBILITYSTARTDATE <= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))
    
    LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND EligibilityHistory_Split.EligibilityStartDate <= TO_DATE(ENVOLVE_CLAIM_EXTRACTS.SERVICE_DT,'YYYYMMDD'))
    
     LEFT OUTER JOIN ELIGIBILITY_HISTORY_CTE ELIGIBILITY_HISTORY_EMP
            ON (ELIGIBILITY_HISTORY_EMP.EXTERNALMEMBER = LPAD(REGEXP_REPLACE(REPLACE(ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID, '"', ''), '[^ -~]', ''), 10, '0'))
       
    LEFT OUTER JOIN MC400.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr))

WHERE COALESCE(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr,ELIGIBILITY_HISTORY_EMP.MEMBERNBR) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND ENVOLVE_CLAIM_EXTRACTS.SUBSCRIBER_ID <> 'UPMC99999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
AND ENVOLVE_CLAIM_EXTRACTS.CLAIM_NO NOT IN (SELECT DISTINCT CLAIM_NO FROM LKP_CTE)
)

SELECT CLAIM_NO,
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
SOURCE_SYSTEM,
CLAIM_MEMBER_NBR,
MEMBER_NBR,
MASTER_MEMBER_ID,
COVERAGE_GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE,
PLAN_CODE,
RIDERS
FROM LKP_CTE

UNION ALL

SELECT CLAIM_NO,
TPA_CLIENT_ID,
TPA_ID,
TPA_DIV_ID,
SOURCE_SYSTEM,
CLAIM_MEMBER_NBR,
MEMBER_NBR,
MASTER_MEMBER_ID,
COVERAGE_GROUP_CODE,
SUB_GROUP_CODE,
PLAN_TYPE,
PLAN_CODE,
RIDERS
FROM LKP_CTE_MAX
WHERE MASTER_ELIGIBILITY_RANK = (SELECT MAX(MASTER_ELIGIBILITY_RANK) 
                          FROM LKP_CTE_MAX AS MAX_RANK
                          WHERE MAX_RANK.CLAIM_NO = LKP_CTE_MAX.CLAIM_NO
                          AND MAX_RANK.TPA_CLIENT_ID = LKP_CTE_MAX.TPA_CLIENT_ID
                          AND MAX_RANK.TPA_ID = LKP_CTE_MAX.TPA_ID
                          AND MAX_RANK.TPA_DIV_ID = LKP_CTE_MAX.TPA_DIV_ID
                          AND MAX_RANK.SOURCE_SYSTEM = LKP_CTE_MAX.SOURCE_SYSTEM
                          )
;