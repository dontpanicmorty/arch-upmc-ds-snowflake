CREATE OR REPLACE VIEW STAGEDATA.SAT_MEMBER_DETAIL_MC400UPM_SELECT_VW
COMMENT = 'Source select view for MC400Upm member data to load HUBDATA.SAT_MEMBER_DETAIL'
AS

SELECT
 Members.TPAClient AS TPA_CLIENT_ID
,Members.TPAIdOfClient AS TPA_ID
,Members.TPADivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,TRIM(Members.MemberNbr) AS MEMBER_NBR
,CASE
    WHEN Members.TPADivision = '0001' THEN 'MEDICAL UPMC'
    WHEN Members.TPADivision = '0002' THEN 'DENTAL UPMC'
    ELSE NULL
 END AS MEMBER_TYPE_CODE
,Members.SubscriberNbr AS SUBSCRIBER_NBR
,TRIM(Members.PersonNbr) AS PERSON_NBR
,TRIM(Members.MembersLastName) AS LAST_NAME
,TRIM(Members.MembersFirstName) AS FIRST_NAME
,CONCAT(LAST_NAME, ', ', FIRST_NAME) AS FULL_NAME
,NULLIF(TRIM(Members.MiddleInitial), '') AS MIDDLE_NAME
,NULLIF(LEFT(TRIM(Members.MiddleInitial), 1), '') AS MIDDLE_INITIAL_NAME
,NULLIF(Members.MembersSuffix, '') AS NAME_SUFFIX
,NULLIF(TRIM(Members.SalutoryMemberName), '') AS SALUTORY_NAME
,TRIM(Members.MemberSex) AS GENDER_CODE
,NULLIF(TRIM(Members.RaceCode), '') AS RACE_CODE
,NULLIF(UPPER(TRIM(Members.RelationshipCode)), '') AS SUBSCRIBER_RELATIONSHIP_CODE
,IFNULL(TRY_TO_DATE(TO_VARCHAR(Members.MemberAddedDate), 'YYYYMMDD'), TO_DATE('0001-01-01')) AS ADDED_DATE
,IFNULL(TRY_TO_DATE(TO_VARCHAR(Members.MemberDateOfBirth), 'YYYYMMDD'), TO_DATE('0001-01-01')) AS BIRTH_DATE
,TRY_TO_DATE(TO_VARCHAR(Members.DateOfDeath), 'YYYYMMDD') AS DEATH_DATE
,NULLIF(TRIM(Members.ResponsibleParty), '') AS RESPONSIBLE_PARTY_NAME
,NULLIF(TRIM(Members.MaritalStatus), '') AS MARITAL_STATUS_CODE
,CASE 
    WHEN LEFT(Members.CurrCoverageGroupCode, 3) = 'MAC' -- COMMUNITY HEALTHCHOICES (CHC)
      OR LEFT(Members.CurrCoverageGroupCode, 2) = 'MA' -- MEDICAID (STANDARD PLANS)
      OR LEFT(Members.CurrCoverageGroupCode, 4) = 'KIDS' -- CHILDREN'S HEALTH INSURANCE PROGRAM (CHIP)
        THEN NULL 
    ELSE TRY_TO_DATE(TO_VARCHAR(Members.MaritalStatusEffDate), 'YYYYMMDD') 
END AS MARITAL_STATUS_EFF_DATE -- These Lines of Businesses (identified first chars of CurrCoverageGroupCode) use MaritalStatusEffDate as PregnancyDueDate instead
,CASE
  WHEN LENGTH(TRIM(Members.MedicaidId)) >= 2
    THEN LEFT(TRIM(Members.MedicaidId), 2)
  ELSE NULL
END AS DPW_COUNTY_CODE -- County code is first two chars of MedicaidId
-- ,RestrictedMembers.MemberNbr IS NOT NULL AS RESTRICTED_MEMBER_FLAG
,IFF(RestrictedMembers.MemberNbr IS NULL, FALSE, TRUE) AS RESTRICTED_MEMBER_FLAG -- This has to be revisited. "We need to work with TEAM Dire to get source table copied to Snowflake so data can be incorporated into the solution. Alternative solution will be leveraged later if desired" Team Q&A doc - THIS HAS BEEN COMPLETED.
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, MEMBER_NBR]) AS HUB_MEMBER_HKEY

FROM RAWDATA.MC400_DWOAO_MEMBERS Members
    LEFT OUTER JOIN
    (
        SELECT
        Members.MemberNbr
        FROM RAWDATA.MC400_DWOAO_MEMBERS Members
        WHERE TRY_TO_NUMBER(NULLIF(TRIM(Members.MemberVIPSecurityCode), '')) > 2 -- can take this part of the union and keep it in main select statement

        UNION

        SELECT
        EligibilityHistory.MemberNbr
        FROM RAWDATA.MC400_DWOAO_ELIGIBILITYHISTORY EligibilityHistory
        WHERE TRIM(EligibilityHistory.CoverageGroupCode) IN ('001079', '007653')
        OR TRIM(EligibilityHistory.PlanType) = '0'

        UNION

        SELECT
        RestrictedIndividual.MemberNbr
        FROM RAWDATA.MEMBER_RESTRICTED_INDIVIDUAL RestrictedIndividual
    ) RestrictedMembers -- Third solution Added with old table "Restricted Individuals" SWIDAPDB1002.MemberStaging.dbo.DwOAO_MemberRestrictedIndividuals in (true source)
        ON RestrictedMembers.MemberNbr = Members.MemberNbr
        
WHERE Members.MemberNbr <> '99999999901' -- Junk catch‑all member number excluded
;
