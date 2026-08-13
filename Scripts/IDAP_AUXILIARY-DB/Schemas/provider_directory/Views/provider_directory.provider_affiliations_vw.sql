--assumes we're receiving a single file from SQL Server called providerAffiliations.txt.
--if that turns out to be a bad assumption we need to edit the FROM below to match
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDER_AFFILIATIONS_VW 
COMMENT = 'Parses providerAffiliations.txt as is from the storage container so we can build JSON from it'
AS
SELECT 
providerAffiliations.$1 AS ProviderKey
,providerAffiliations.$2 AS FacilityName
,providerAffiliations.$3 AS AdmitHospOwnedStatus
,providerAffiliations.$4 AS FacilityProviderKey
,providerAffiliations.$5 AS ProviderAddressRelKey
,providerAffiliations.$6 AS ProvDirH2ProductName
,providerAffiliations.$7 AS ProvDirH2SubproductName
,providerAffiliations.$8 AS ProvDirH2SubproductKey
,providerAffiliations.$9 AS H2EntityName
,providerAffiliations.$10 AS ProductKey
,providerAffiliations.$11 AS ProductTypekey
,providerAffiliations.$12 AS ProvDirNetworkId
,providerAffiliations.$13 AS LeveledSubproductInd
,providerAffiliations.$14 AS ContractLevelCode
FROM @PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_INBOUNDDATA/providerAffiliations.txt 
    (file_format => 'PROVIDER_DIRECTORY.PROV_DIR_FILE_FORMAT_NULLABLE') providerAffiliations;