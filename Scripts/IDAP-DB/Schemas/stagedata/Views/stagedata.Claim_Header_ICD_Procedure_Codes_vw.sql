CREATE OR REPLACE VIEW STAGEDATA.CLAIM_HEADER_ICD_PROCEDURE_CODES_VW
AS
SELECT
CLAIM_HEADER_KEY
,URI
,JSON_DATA:envelope:instance:claimHeader:universalClaimId::string AS UNIVERSAL_CLAIM_ID
,PROCEDURE_CODES.VALUE:claimIcdProcedureCode:icdProcedureCodePosition::number AS CODE_POSITION
,PROCEDURE_CODES.VALUE:claimIcdProcedureCode:icdProcedureCodeValue::string AS CODE_VALUE
,PROCEDURE_CODES.VALUE:claimIcdProcedureCode:icdProcedureCodeVersion::string AS CODE_VERSION
,PROCEDURE_CODES.VALUE:claimIcdProcedureCode:icdProcedureCodeQualifier::string AS CODE_QUALIFIER
,PROCEDURE_CODES.VALUE:claimIcdProcedureCode:icdProcedureDescKey::string AS DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:claimNbr::string AS CLAIM_NBR
,JSON_DATA:envelope:instance:claimHeader:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:claimHeader:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:claimHeader:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:claimHeader:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:claimHeader:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:claimHeader:icdProcedureCodes AS CODES
FROM STAGEDATA.CLAIM_HEADER
      ,TABLE(FLATTEN(JSON_DATA:envelope:instance:claimHeader:icdProcedureCodes)) PROCEDURE_CODES
;