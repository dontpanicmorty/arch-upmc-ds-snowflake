!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_SPEC_VW(
	MAP_SRCE_N,
	PRV_SP_N,
	PRV_SP_N_DESC,
	PRV_SP_4
) as SELECT
 	MAP_SRCE_N,
	PRV_SP_N,
	PRV_SP_N_DESC,
	PRV_SP_4
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_SPEC;
!set variable_substitution=false;