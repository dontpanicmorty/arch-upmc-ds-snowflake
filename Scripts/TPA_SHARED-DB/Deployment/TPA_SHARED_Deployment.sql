/*----------------------------------------------------------------------------------------------------------
 This is the master deployment procedure for the database. Only the items in this script will be 
 deployed to the target database.
 
 Connection options for deployment via SnowSQL:
 -f IDAP_Deployment.sql 
 --variable build_number="<your build number>" 
 --variable environment="<DEV, TST, PRD>" 
 -o log_level=debug 
 -o timing=false 
 -o header=false 
 -o echo=true 
 -o exit_on_error=true 
 -o output_file=IDAP_Deployment.log
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
!load ../Schemas/DatabaseLevelObjects/pega.schema.sql;
!load ../Schemas/DatabaseLevelObjects/util.schema.sql;


----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
!load ../Schemas/util/Stages/util.tpadatalake_tpashared.sql;
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--logdata
!load ../Schemas/logdata/FileFormats/logdata.adf_logging_file_format.sql;

--pega
!load ../Schemas/pega/FileFormats/pega.cws_data_file_format.sql;
----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--logdata
!load ../Schemas/logdata/Tables/logdata.adf_file_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_filename_load_history.sql;

--pega
!load ../Schemas/pega/Tables/pega.stg_cws_act_adjustment_case_intake.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_act_adjustment_req_intake.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_adjustment_case_details.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_captureloginlogout.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_claimline.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_indexoperator.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_operator_wb_list.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_operator.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_operatorproductivity.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_operatorskills.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_operatorstatistics.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_pendcodes.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_scm_data_audit.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_work.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_work_ca.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_workbasket.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_workhistory.sql;
!load ../Schemas/pega/Tables/pega.stg_cws_worklist.sql;

--util
!load ../Schemas/util/Tables/util.adf_file_copy_control.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/Functions/util.fxn_array_hash.sqlproc
----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--logdata
!load ../Schemas/logdata/Views/logdata.adf_tpa_shared_pipeline_logging_vw.sql;
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/StoredProcedures/util.spu_file_load_tpa_shared.sqlproc;
!set variable_substitution=false;
!exit