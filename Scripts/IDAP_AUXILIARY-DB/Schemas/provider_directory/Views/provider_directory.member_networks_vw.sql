--assumes we're receiving a single file from SQL Server called providerAffiliations.txt.
--if that turns out to be a bad assumption we need to edit the FROM below to match
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.MEMBER_NETWORKS_VW 
COMMENT = 'Parses memberNetworks.txt as is from the storage container so we can build JSON from it'
AS
SELECT 
memberNetworks.$1 AS LoadDate
,memberNetworks.$2 AS id
,memberNetworks.$3 AS TPAClientId
,memberNetworks.$4 AS TPAId
,memberNetworks.$5 AS TPADivId
,memberNetworks.$6 AS MemberCardId
,memberNetworks.$7 AS IdMatchErrorInd
,memberNetworks.$8 AS NetworkId
,memberNetworks.$9 AS CareTypeName
,memberNetworks.$10 AS SubProductKey
,memberNetworks.$11 AS AltDestinationURL
,memberNetworks.$12 AS MultipleNetworksInd
,memberNetworks.$13 AS PlanYear
,memberNetworks.$14 AS IssueWarningInd
,memberNetworks.$15 AS WarningDate
,memberNetworks.$16 AS MarketSegment
,memberNetworks.$17 AS FutureSubProductKey
FROM @PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_INBOUNDDATA/memberNetworks.txt 
    (file_format => 'PROVIDER_DIRECTORY.PROV_DIR_FILE_FORMAT_NULLABLE') memberNetworks;