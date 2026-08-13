CREATE OR REPLACE VIEW STAGEDATA.CLAIM_HEADER_ICD_DIAGNOSIS_CODES_VW
AS
SELECT
CLAIM_HEADER_KEY
,URI
,JSON_DATA:envelope:instance:claimHeader:universalClaimId::string AS UNIVERSAL_CLAIM_ID
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:icdDiagnosisCodePosition::number AS CODE_POSITION
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:icdDiagnosisCodeValue::string AS CODE_VALUE
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:icdDiagnosisCodeVersion::string AS CODE_VERSION
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:icdDiagnosisCodeQualifier::string AS CODE_QUALIFIER
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:icdDiagnosisDescKey::string AS DESC_KEY
,DIAGNOSIS_CODES.VALUE:claimIcdDiagnosisCode:poaCode::string AS POA_CODE
,JSON_DATA:envelope:instance:claimHeader:claimNbr::string AS CLAIM_NBR
,JSON_DATA:envelope:instance:claimHeader:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:claimHeader:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:claimHeader:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:claimHeader:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:claimHeader:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:claimHeader:icdDiagnosisCodes AS CODES
FROM STAGEDATA.CLAIM_HEADER
      ,TABLE(FLATTEN(JSON_DATA:envelope:instance:claimHeader:icdDiagnosisCodes)) DIAGNOSIS_CODES
;