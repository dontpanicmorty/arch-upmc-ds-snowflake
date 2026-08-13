--assumes we're receiving a single file from SQL Server called providersContract.txt.
--if that turns out to be a bad assumption we need to edit the FROM below to match
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDERS_CONTRACT_VW 
COMMENT = 'Parses providersContract.txt as is from the storage container so we can build JSON from it'
AS
SELECT 
providersContract.$1 AS ProviderAddressRelKey
,providersContract.$2 AS ProductKey
,providersContract.$3 AS ProductName
,providersContract.$4 AS ProductTypeKey
,providersContract.$5 AS ProductTypeName
,providersContract.$6 AS ContractLevelCode
,providersContract.$7 AS ActiveInd
,providersContract.$8 AS ProviderContractRoleType
,providersContract.$9 AS AcceptingNewPatientsInd
,providersContract.$10 AS ProvDirRestrictionDesc
,providersContract.$11 AS RestrictionRankNbr
,providersContract.$12 AS H2EntityName
,providersContract.$13 AS CareTypeName
,providersContract.$14 AS CoverageTypeName
,providersContract.$15 AS LeveledSubproductInd
,providersContract.$16 AS ContractModelName
,providersContract.$17 AS AlternateNetworkName
,providersContract.$18 AS ProvDirH2ProductName
,providersContract.$19 AS ProvDirH2ProductKey
,providersContract.$20 AS ProvDirH2SubproductName
,providersContract.$21 AS ProvDirH2SubproductKey
,providersContract.$22 AS ProvDirNetworkId
FROM @PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_INBOUNDDATA/providersContract.txt
    (file_format => 'PROVIDER_DIRECTORY.PROV_DIR_FILE_FORMAT_NULLABLE') providersContract;