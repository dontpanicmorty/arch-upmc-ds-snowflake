!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_PEER_GRP_VW(
	CUSTOM_PEER_GRP_ID,
	CUSTOM_PEER_GRP_DESC
) as SELECT
    CUSTOM_PEER_GRP_ID,
	CUSTOM_PEER_GRP_DESC
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_PEER_GRP;
!set variable_substitution=false;