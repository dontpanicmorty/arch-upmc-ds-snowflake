CREATE OR REPLACE VIEW STAGEDATA.MEMBER_DEMOGRAPHIC_VW
AS
SELECT
URI
,INSERT_DATETIME
,LAST_UPDATED_DATETIME
,JSON_DATA:envelope:instance:memberDemographic:age::number AS AGE
,JSON_DATA:envelope:instance:memberDemographic:genderCode::string AS GENDER_CODE
,JSON_DATA:envelope:instance:memberDemographic:actuarialAgeRange::string AS ACTUARIAL_AGE_RANGE
,JSON_DATA:envelope:instance:memberDemographic:clinicalAgeRange::string AS CLINICAL_AGE_RANGE
,JSON_DATA:envelope:instance:memberDemographic:financialAgeRange::string AS FINANCIAL_AGE_RANGE
,JSON_DATA:envelope:instance:memberDemographic:medicareHcfaAgeRange::string AS MEDICARE_HCFA_AGE_RANGE
,JSON_DATA:envelope:instance:memberDemographic:medicareRateAgeRange::string AS MEDICARE_RATE_AGE_RANGE
,JSON_DATA:envelope:instance:memberDemographic:memberDemographicKey::string AS MEMBER_DEMOGRAPHIC_KEY
FROM STAGEDATA.MEMBER_DEMOGRAPHIC
;

--This will need to be sourced from somewhere in the DATAHUB when we do UPM