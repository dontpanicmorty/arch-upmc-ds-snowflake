CREATE OR REPLACE VIEW STAGEDATA.PROVIDER_DETAIL_IDENTIFIERS_VW
AS
SELECT
PROVIDER_DETAIL_KEY
,PROVIDER_DETAIL.URI
,IDENTIFIERS.VALUE:providerIdentification:identificationTypeDesc::string AS IDENTIFICATION_TYPE_DESC
,IDENTIFIERS.VALUE:providerIdentification:identificationValue::string AS IDENTIFICATION_VALUE
,JSON_DATA:envelope:instance:providerDetail:universalProviderId::string AS UNIVERSAL_PROVIDER_ID
,JSON_DATA:envelope:instance:providerDetail:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:providerDetail:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:providerDetail:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:providerDetail:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:providerDetail:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:providerDetail:providerIdentifiers AS PROVIDER_IDENTIFIERS
FROM STAGEDATA.PROVIDER_DETAIL
      ,TABLE(FLATTEN(JSON_DATA:envelope:instance:providerDetail:providerIdentifiers)) IDENTIFIERS
;