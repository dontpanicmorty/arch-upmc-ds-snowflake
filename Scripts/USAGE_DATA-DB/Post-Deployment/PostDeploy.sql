!set variable_substitution=true;
!load ./&{tokenFileName}
!set variable_substitution=false;
!load ./StaticData/util.idap_lake_triggers_check_control.staticdata.sql;
!load ./StaticData/util.idw_lake_triggers_check_control.staticdata.sql;

SELECT 'Post-deployment Complete!';
