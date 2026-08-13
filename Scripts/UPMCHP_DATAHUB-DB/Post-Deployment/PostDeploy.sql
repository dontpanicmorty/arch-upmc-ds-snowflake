-- ADD SCRIPT LOAD CALL
-- !load ./StaticData/<schemaname>.<scriptname>.sql;
!set variable_substitution=true;
!load ./&{tokenFileName}
!set variable_substitution=false;
!load ./StaticData/util.allowed_value_control.sql;
!load ./StaticData/util.datahub_load_control.sql;
!load ./StaticData/util.extract_load_control.sql;
!load ./StaticData/util.rawdata_load_control.sql;
!load ./StaticData/rawdata.provider_network_crosswalk.sql;
SELECT 'Post-deployment Complete!';
