/*
Need to work out null handling deatails. with test files we're getting a string value of 'NULL'.
That's being turned into json as "issueWarningInd":"NULL" and we probably don't want that
Could be handled on the fileFormat or loading process and that would be preferred.
Can also handle it like this in the object_construct replace(ISSUEWARNINGIND, 'NULL',null)
Latter seems like a bit of a hack, but it does work.
*/
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.MEMBER_NETWORKS_JSON_SELECT_VW
COMMENT = 'Assembles the JSON structures required by FindCare memberNetworks collection'
AS
WITH NETWORKS AS
(
	select 
		id,
		memberCardId,
		concat(TPACLIENTID, TPAID, TPADIVID) as tpaPartition,
		array_agg(distinct object_construct('networkId', NETWORKID, 'careType', CARETYPENAME, 'subProductKey',SUBPRODUCTKEY, 'issueWarningInd', ISSUEWARNINGIND, 'warningDate', WARNINGDATE, 'marketsegment', MARKETSEGMENT)) 
			within group (order by object_construct('networkId', NETWORKID, 'careType', CARETYPENAME, 'subProductKey',SUBPRODUCTKEY, 'issueWarningInd', ISSUEWARNINGIND, 'warningDate', WARNINGDATE, 'marketsegment', MARKETSEGMENT)) as networksJSON
	from PROVIDER_DIRECTORY.MEMBER_NETWORKS_VW
	--where SERVICEAREACOUNTYNAME is not null
	group by 
		id,
		memberCardId,
		concat(TPACLIENTID, TPAID, TPADIVID)
	order by 
    	id,
		memberCardId,
		concat(TPACLIENTID, TPAID, TPADIVID)
		
)
SELECT DISTINCT MEMBER_NETWORKS_VW.id
,MEMBER_NETWORKS_VW.MemberCardId
,OBJECT_CONSTRUCT(
    'id', MEMBER_NETWORKS_VW.id,
    'memberCardId', MEMBER_NETWORKS_VW.membercardid,
    'tpaPartition', concat(TPACLIENTID, TPAID, TPADIVID),
    'idMatchError', MEMBER_NETWORKS_VW.idmatcherrorind,
    'networks', NETWORKS.networksJSON 
) AS memberNetworksJSONtxt
FROM PROVIDER_DIRECTORY.MEMBER_NETWORKS_VW
LEFT JOIN NETWORKS
    ON MEMBER_NETWORKS_VW.ID = NETWORKS.ID
    AND MEMBER_NETWORKS_VW.MEMBERCARDID = NETWORKS.MEMBERCARDID
ORDER BY
MEMBER_NETWORKS_VW.id
,MEMBER_NETWORKS_VW.MemberCardId
,memberNetworksJSONtxt
;