/*----------------------------------------------------------------------------------------------------------
 This is the master deployment procedure for the database. Only the items in this script will be 
 deployed to the target database.
 
 Connection options for deployment via SnowSQL:
 -f USAGE_DATA_Deployment.sql 
 --variable build_number="<your build number>" 
 --variable environment="<DEV, TST, PRD>" 
 -o log_level=debug 
 -o timing=false 
 -o header=false 
 -o echo=true 
 -o exit_on_error=true 
 -o output_file=USAGE_DATA_Deployment.log
 ----------------------------------------------------------------------------------------------------------*/
--***************************************************************************
--***** This sets the SnowSQL variables that are used for cross db queries
!set variable_substitution=true;
!load &{tokenFilePath}

--***************************************************************************
-- Create deployment shell database
CREATE OR REPLACE DATABASE &{sourceDB} 
DATA_RETENTION_TIME_IN_DAYS=0 
COMMENT='CLI CI/CD Deployment Compare Database for build.'
;
--***************************************************************************
--***** THE ORDER OF EXECUTION IS BASED OFF OF DATABASE DEPENDENCIES!! ******
--***************************************************************************
----------------------------------------------------------------------------------------------------------
-- Schemas
----------------------------------------------------------------------------------------------------------
!load ../Schemas/DatabaseLevelObjects/logdata.schema.sql;
!load ../Schemas/DatabaseLevelObjects/util.schema.sql;
!load ../Schemas/DatabaseLevelObjects/adf.schema.sql;


----------------------------------------------------------------------------------------------------------
-- Stages
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/UTIL/Stages/util.hpdsdatalake_dbextract_logdata.sql;
!load ../Schemas/UTIL/Stages/util.hpdsdatalake_usage_data_deptlake.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/UTIL/FileFormats/util.db_extract_parquet_file_format.sql;
!load ../Schemas/UTIL/FileFormats/util.json_file_format.sql;
!load ../Schemas/UTIL/FileFormats/util.pipeline_external_table_file_format.sql;

--logdata
!load ../Schemas/LOGDATA/FileFormats/logdata.file_mover_log_csv_file_format.sql;

--adf
!load ../Schemas/ADF/FileFormats/adf.triggers_json_file_format.sql;

----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/UTIL/Tables/util.pipeline_runs.sql;
!load ../Schemas/UTIL/Tables/util.idap_lake_triggers_check_control.sql;
!load ../Schemas/UTIL/Tables/util.idw_lake_triggers_check_control.sql;

--logdata
!load ../Schemas/LOGDATA/Tables/logdata.load_history.sql;
!load ../Schemas/LOGDATA/Tables/logdata.file_mover_raw_logs.sql;

--adf
!load ../Schemas/ADF/Tables/adf.triggers_raw.sql;


----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--logdata
!load ../Schemas/LOGDATA/Functions/logdata.fxn_javascript_uri_decode.sql;

--util
!load ../Schemas/UTIL/Functions/util.fxn_array_hash.sql;


----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/UTIL/Views/util.01_snowflake_direct_object_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.02_snowflake_base_object_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.adf_pipeline_runs_vw.sql;
!load ../Schemas/UTIL/Views/util.adf_triggers_vw.sql;
!load ../Schemas/UTIL/Views/util.ds_oracle_edwload_table_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.ds_oracle_edwrpt_table_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.ds_oracle_evhrpt_table_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.nonds_oracle_edwrpt_table_usage_vw.sql;
!load ../Schemas/UTIL/Views/util.oracle_nested_object_relationship_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_evh_detail_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_evh_run_time_stats_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_deploy_details_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_deploy_log_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_detail_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_run_time_stats_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_session_task_log_vw.sql;
!load ../Schemas/UTIL/Views/util.pc_idw_task_run_time_vw.sql;
!load ../Schemas/UTIL/Views/util.snowflake_database_object_usage_vw.sql;

--logdata
!load ../Schemas/LOGDATA/Views/logdata.file_mover_summary_vw.sql;

--adf
!load ../Schemas/ADF/Views/adf.triggers_pipelines_bridge_vw.sql;
!load ../Schemas/ADF/Views/adf.adf_triggers_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/UTIL/StoredProcedures/util.refresh_pipeline_runs.sqlproc;

--logdata
!load ../Schemas/LOGDATA/StoredProcedures/logdata.refresh_file_mover_raw_logs.sqlproc;
!load ../Schemas/LOGDATA/StoredProcedures/logdata.refresh_file_mover_from_snowflake_raw_logs.sqlproc;


--adf
!load ../Schemas/ADF/StoredProcedures/adf.spu_load_adf_triggers.sqlproc;

!set variable_substitution=false;
!exit