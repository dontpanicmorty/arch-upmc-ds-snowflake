!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_POS_VW(
	MAP_SRCE_N,
	POS_N,
	POS_N_DESC,
	POS_I
) as SELECT 
 	MAP_SRCE_N,
	POS_N,
	POS_N_DESC,
	POS_I
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_POS;
!set variable_substitution=false;