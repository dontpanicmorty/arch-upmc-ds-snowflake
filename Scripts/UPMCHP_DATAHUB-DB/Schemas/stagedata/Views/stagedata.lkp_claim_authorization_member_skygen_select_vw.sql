!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.LKP_CLAIM_AUTHORIZATION_MEMBER_SKYGEN_SELECT_VW
COMMENT = 'Translates Skygen member to UPMC MemberNbrs for use in other mappings'
AS

SELECT DISTINCT
SKYGEN_CLAIM_AUTHORIZATION.AUTHORIZATION_NBR,
IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient) AS TPA_CLIENT_ID,
IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient) AS TPA_ID,
IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision) AS TPA_DIV_ID,
'Skygen' AS DATA_SOURCE_NAME,
SKYGEN_CLAIM_AUTHORIZATION.MEMBER_NBR AS AUTHORIZATION_MEMBER_NBR,
IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) AS MC400_MEMBER_NBR,
MASTERMEMBERID.MASTERMEMBER AS MASTER_MEMBER_ID,
COALESCE(TRIM(EligibilityHistory.CoverageGroupCode), TRIM(MEMBERS_EMPNO.CoverageGroupCode), TRIM(EligibilityHistory_Split.CoverageGroupCode)) AS COVERAGE_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.SubGroupCode), TRIM(MEMBERS_EMPNO.SubGroupCode), TRIM(EligibilityHistory_Split.SubGroupCode)) AS SUB_GROUP_CODE,
COALESCE(TRIM(EligibilityHistory.PlanType), TRIM(MEMBERS_EMPNO.PlanType), TRIM(EligibilityHistory_Split.PlanType)) AS PLAN_TYPE,
COALESCE(TRIM(EligibilityHistory.PlanCode), TRIM(MEMBERS_EMPNO.PlanCode), TRIM(EligibilityHistory_Split.PlanCode)) AS PLAN_CODE
--STRTOK_TO_ARRAY(TRIM(IFNULL(EligibilityHistory.Riders, MEMBERS_EMPNO.Riders)), ' ') AS RIDERS

FROM
    (
        SELECT
        AUTHORIZATION_NBR
        ,MEMBER_NBR
        ,DETERMINATION_DATE
        ,'DWSKYGEN' AS SOURCE_SYSTEM
        FROM RAWDATA.DWSKYGEN_CLAIM_AUTHORIZATION

        UNION ALL

        SELECT DISTINCT
        AUTHORIZATION_NUMBER AS AUTHORIZATION_NBR
        ,SUBSCRIBER_ID AS MEMBER_NBR
        ,MAX(TO_DATE(INITIAL_DETERMINATION_DATE)) AS DETERMINATION_DATE
        ,'FLATFILE' AS SOURCE_SYSTEM
        FROM RAWDATA.SKYGEN_AUTHORIZATION_EXTRACTS_CURRENT_VW
        WHERE AUTHORIZATION_NUMBER NOT IN (SELECT DISTINCT AUTHORIZATION_NBR FROM RAWDATA.DWSKYGEN_CLAIM_AUTHORIZATION)
        GROUP BY AUTHORIZATION_NUMBER, SUBSCRIBER_ID        
    ) SKYGEN_CLAIM_AUTHORIZATION

    LEFT OUTER JOIN --Get full list of members from MC400 to find member for authorization
            (SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWOAO.MEMBERS
            UNION ALL
            SELECT MemberNbr, TpaClient, TpaIdOfClient, TpaDivision, MedicaidId
            FROM &{MC400}.DWDNV_NONCLAIMS.MEMBERS
            ) AS MEMBERS_MemberNbr
        ON (SKYGEN_CLAIM_AUTHORIZATION.MEMBER_NBR = MEMBERS_MemberNbr.MemberNbr)

    LEFT OUTER JOIN &{MC400}.DWOAO.EligibilityHistory --Get Eligibility for member found by member in mc400
        ON (EligibilityHistory.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory.MemberNbr = MEMBERS_MemberNbr.MemberNbr
        AND TO_DATE(TO_CHAR(EligibilityHistory.EligibilityStartDate), 'YYYYMMDD') <= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE
        AND IFNULL(TRY_TO_DATE(TO_CHAR(EligibilityHistory.EligibilityEndDate), 'YYYYMMDD'), '9999-12-31') >= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE)

     LEFT OUTER JOIN --Find members by EmployeeNbr where eligibility matches
            (SELECT DISTINCT MEMBERS.MemberNbr, 
                    MEMBERS.EmployeeNbr,
                    MEMBERS.TpaClient,
                    MEMBERS.TpaIdOfClient,
                    MEMBERS.TpaDivision,
                    MEMBERS.MedicaidId,
                    EligibilityHistory.EligibilityStartDate,
                    EligibilityHistory.EligibilityEndDate,
                    EligibilityHistory.CoverageGroupCode,
                    EligibilityHistory.SubGroupCode,
                    EligibilityHistory.PlanType,
                    EligibilityHistory.PlanCode,
                    EligibilityHistory.Riders
            FROM &{MC400}.DWOAO.MEMBERS
                JOIN &{MC400}.DWOAO.EligibilityHistory
                    ON (MEMBERS.MemberNbr = EligibilityHistory.MemberNbr
                    AND MEMBERS.TpaClient = EligibilityHistory.TpaClient
                    AND MEMBERS.TpaIdOfClient = EligibilityHistory.TpaIdOfClient
                    AND MEMBERS.TpaDivision = EligibilityHistory.TpaDivision
                    AND EligibilityHistory.PlanType IN ('1','B','D','4')) /*THIS NEEDS TO BE CONVERTED TO A DYNAMIC LOOKUP TO A REF TABLE FOR LOB = MA*/
            ) AS MEMBERS_EMPNO
        ON (MEMBERS_EMPNO.EMPLOYEENBR = SKYGEN_CLAIM_AUTHORIZATION.MEMBER_NBR
        AND TO_DATE(TO_CHAR(MEMBERS_EMPNO.EligibilityStartDate),'YYYYMMDD') <= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE
        AND IFNULL(TRY_TO_DATE(TO_CHAR(MEMBERS_EMPNO.EligibilityEndDate),'YYYYMMDD'),'9999-12-31') >= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE)
    
    LEFT OUTER JOIN &{MC400}.DWOAO.EligibilityHistory AS EligibilityHistory_Split --Get Eligibility for members with split policies or surviving annuitants
        ON (EligibilityHistory_Split.TpaClient = MEMBERS_MemberNbr.TpaClient
        AND EligibilityHistory_Split.TpaIdOfClient = MEMBERS_MemberNbr.TpaIdOfClient
        AND EligibilityHistory_Split.TpaDivision = MEMBERS_MemberNbr.TpaDivision
        AND EligibilityHistory_Split.MemberNbr = SUBSTR(IFNULL(MEMBERS_MemberNbr.MedicaidID, MEMBERS_EMPNO.MedicaidID),1,11)
        AND TO_DATE(TO_CHAR(EligibilityHistory_Split.EligibilityStartDate), 'YYYYMMDD') <= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE
        AND IFNULL(TRY_TO_DATE(TO_CHAR(EligibilityHistory_Split.EligibilityEndDate), 'YYYYMMDD'), '9999-12-31') >= SKYGEN_CLAIM_AUTHORIZATION.DETERMINATION_DATE)
       
    LEFT OUTER JOIN &{MC400}.DWOAO.MASTERMEMBERID
        ON (MASTERMEMBERID.TpaClient = IFNULL(MEMBERS_MemberNbr.TpaClient, MEMBERS_EMPNO.TpaClient)
        AND MASTERMEMBERID.TpaIdOfClient = IFNULL(MEMBERS_MemberNbr.TpaIdOfClient, MEMBERS_EMPNO.TpaIdOfClient)
        AND MASTERMEMBERID.TpaDivision = IFNULL(MEMBERS_MemberNbr.TpaDivision, MEMBERS_EMPNO.TpaDivision)
        AND MASTERMEMBERID.SOURCEID = IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr))

WHERE IFNULL(MEMBERS_MemberNbr.MemberNbr, MEMBERS_EMPNO.MemberNbr) IS NOT NULL /*handles outlier scenarios where we cant find a match*/ 
AND SKYGEN_CLAIM_AUTHORIZATION.MEMBER_NBR <> '9999999999' /*7/27/20123 HOTFIX. Need input from business on if or how we handle these. Very small percentage*/
;
set variable_substitution=true;
