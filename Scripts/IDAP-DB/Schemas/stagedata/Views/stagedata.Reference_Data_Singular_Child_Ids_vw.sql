CREATE OR REPLACE VIEW STAGEDATA.REFERENCE_DATA_SINGULAR_CHILD_IDS_VW
AS
SELECT
REFERENCE_DATA_SINGULAR_KEY
,URI
,INSERT_DATETIME
,LAST_UPDATED_DATETIME
,JSON_DATA:envelope:headers:groupCode::string AS GROUP_CODE
,JSON_DATA:envelope:headers:hipaaCodes:hipaa277::string AS HIPAA_277_CODE
,JSON_DATA:envelope:headers:hipaaCodes:hipaa835::string AS HIPAA_835_CODE
,JSON_DATA:envelope:instance:referenceDataSingular:dataDomain::string AS DATA_DOMAIN
,JSON_DATA:envelope:instance:referenceDataSingular:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:referenceDataSingular:dataStewardName::string AS DATA_STEWARD_NAME
,TO_TIMESTAMP_TZ(JSON_DATA:envelope:instance:referenceDataSingular:effectiveStartDate::datetime) AS EFFECTIVE_START_DATE
,TO_TIMESTAMP_TZ(JSON_DATA:envelope:instance:referenceDataSingular:effectiveEndDate::datetime) AS EFFECTIVE_END_DATE
,JSON_DATA:envelope:instance:referenceDataSingular:languageName::string AS LANGUAGE_NAME
,JSON_DATA:envelope:instance:referenceDataSingular:lineOfBusinessCode::string AS LINE_OF_BUSINESS_CODE
,JSON_DATA:envelope:instance:referenceDataSingular:referenceKey::string AS REFERENCE_KEY
,TO_TIMESTAMP_TZ(JSON_DATA:envelope:instance:referenceDataSingular:sourceLastUpdated::datetime) AS SOURCE_LAST_UPDATED
,JSON_DATA:envelope:instance:referenceDataSingular:sourceValue::string AS SOURCE_VALUE
,JSON_DATA:envelope:instance:referenceDataSingular:sourceVersion::string AS SOURCE_VERSION
,JSON_DATA:envelope:instance:referenceDataSingular:targetReferenceSet::string AS TARGET_REFERENCE_SET
,JSON_DATA:envelope:instance:referenceDataSingular:targetValue::string AS TARGET_VALUE
,JSON_DATA:envelope:instance:referenceDataSingular:targetDesc::string AS TARGET_DESC
,JSON_DATA:envelope:instance:referenceDataSingular:targetLongDesc::string AS TARGET_LONG_DESC
,JSON_DATA:envelope:instance:referenceDataSingular:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:referenceDataSingular:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:referenceDataSingular:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:referenceDataSingular:tpaKey::string AS TPA_KEY
,CHILD.value::string AS CHILD_ID
FROM STAGEDATA.REFERENCE_DATA_SINGULAR
    ,LATERAL FLATTEN (mode => 'ARRAY', input => JSON_DATA:envelope:instance:referenceDataSingular:childIDs) CHILD
;