!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_PEER_EPI_ETG_VW(
	PEER_DEF_ID,
	ETG_ID
) as 
SELECT 
    PEER_DEF_ID,
    ETG_ID 
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_PEER_EPI_ETG;
!set variable_substitution=false;