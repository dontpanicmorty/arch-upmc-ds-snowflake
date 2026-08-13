CREATE OR REPLACE VIEW STAGEDATA.CLAIM_DETAIL_ADJUSTMENT_REASON_CODES_VW
AS
SELECT
CLAIM_DETAIL.CLAIM_DETAIL_KEY
,CLAIM_DETAIL.URI
,ADJUSTMENT_REASON.INDEX AS CODE_INDEX_NBR
,ADJUSTMENT_REASON.VALUE:claimAdjustmentReason:adjustmentReasonCode::string AS CODE_VALUE
,ADJUSTMENT_REASON.VALUE:claimAdjustmentReason:adjustmentReasonDescKey::string AS DESC_KEY
,JSON_DATA:envelope:instance:claimDetail:universalClaimId::string AS UNIVERSAL_CLAIM_ID
,JSON_DATA:envelope:instance:claimDetail:claimNbr::string AS CLAIM_NBR
,JSON_DATA:envelope:instance:claimDetail:claimLineNbr::string AS CLAIM_LINE_NBR
,JSON_DATA:envelope:instance:claimDetail:claimSequenceNbr::string AS CLAIM_SEQUENCE_NBR
,JSON_DATA:envelope:instance:claimDetail:procedureAdj::string AS PROCEDURE_ADJ
,JSON_DATA:envelope:instance:claimDetail:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:claimDetail:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:claimDetail:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:claimDetail:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:claimDetail:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:claimDetail:adjustmentReasons AS ADJUSTMENT_REASONS
FROM STAGEDATA.CLAIM_DETAIL
      ,TABLE(FLATTEN(JSON_DATA:envelope:instance:claimDetail:adjustmentReasons)) ADJUSTMENT_REASON
;