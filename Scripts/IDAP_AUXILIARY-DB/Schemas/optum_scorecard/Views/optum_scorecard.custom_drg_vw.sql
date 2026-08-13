!set variable_substitution=true;
create or replace view OPTUM_SCORECARD.CUSTOM_DRG_VW(
	DRG_N,
	DRG_DESC,
	MDC,
	DRG_ADMITTYP,
	DRG_VERSION,
	DRG_LEVEL,
	DRG_WGT
) as 
SELECT DRG_N,
	DRG_DESC,
	MDC,
	DRG_ADMITTYP,
	DRG_VERSION,
	DRG_LEVEL,
	DRG_WGT 
FROM DEPT_DOHE.&{OPTUM_SCHEMA}.CUSTOM_DRG;
!set variable_substitution=false;