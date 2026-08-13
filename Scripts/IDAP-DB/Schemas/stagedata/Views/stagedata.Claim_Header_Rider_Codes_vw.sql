CREATE OR REPLACE VIEW STAGEDATA.CLAIM_HEADER_RIDER_CODES_VW
AS
SELECT
CLAIM_HEADER_KEY
,URI
,RIDER_CODES.VALUE::string AS CODE_VALUE
,JSON_DATA:envelope:instance:claimHeader:universalClaimId::string AS UNIVERSAL_CLAIM_ID
,JSON_DATA:envelope:instance:claimHeader:claimNbr::string AS CLAIM_NBR
,JSON_DATA:envelope:instance:claimHeader:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:claimHeader:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:claimHeader:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:claimHeader:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:claimHeader:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:claimHeader:riderCodes AS RIDER_CODES
,JSON_DATA:envelope:instance:claimHeader:admitDate::date AS ADMIT_DATE
,JSON_DATA:envelope:instance:claimHeader:groupNbr::string AS GROUP_NBR
,JSON_DATA:envelope:instance:claimHeader:subGroupNbr::string AS SUB_GROUP_NBR
FROM STAGEDATA.CLAIM_HEADER
    ,TABLE(FLATTEN(JSON_DATA:envelope:instance:claimHeader:riderCodes)) RIDER_CODES
;