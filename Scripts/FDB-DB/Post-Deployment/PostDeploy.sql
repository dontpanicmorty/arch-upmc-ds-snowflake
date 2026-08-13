-- ADD SCRIPT LOAD CALL
-- !load ./StaticData/<schemaname>.<scriptname>.sql;
!set variable_substitution=true;
!load ./&{tokenFileName}
!set variable_substitution=false;
!load ./StaticData/util.load_config.sql;

SELECT 'Post-deployment Complete!';