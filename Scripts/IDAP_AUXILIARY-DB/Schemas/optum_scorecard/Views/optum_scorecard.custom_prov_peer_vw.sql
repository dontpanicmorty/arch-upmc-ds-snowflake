!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_PROV_PEER_VW(
	PROVIDER,
	CUSTOM_PEER_GRP_ID
) as 
SELECT 
	PROVIDER,
	CUSTOM_PEER_GRP_ID
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_PROV_PEER;
!set variable_substitution=false;