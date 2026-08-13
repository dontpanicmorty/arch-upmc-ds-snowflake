!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_PEER_EPI_PEG_VW(
	PEER_DEF_ID,
	PEG_CAT_ID
) as 
SELECT
    PEER_DEF_ID,
	PEG_CAT_ID
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_PEER_EPI_PEG;
!set variable_substitution=false;