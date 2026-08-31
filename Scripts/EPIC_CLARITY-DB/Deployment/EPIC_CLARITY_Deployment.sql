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
!load ../Schemas/DatabaseLevelObjects/dbo.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

----------------------------------------------------------------------------------------------------------
-- TAGS
!load ./tag.manifest.sql;
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
-- None to Run
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
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
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--clarity
!load ../schemas/dbo/views/epic_clarity.dbo.access_log_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.all_categories_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.aut_proc_details_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.aut_proc_mods_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.auth_request_hx_2_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.auth_request_hx_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.auth_request_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.auth_um_status_hx_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.authorizations_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.care_intg_elem_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.careplan_info_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.careplan_temp_info_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.cl_qanswer_qa_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.cl_qanswer_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.cl_ub_rev_code_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.concept_mapped_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.coverage_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.docs_rcvd_encounters_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.episode_all_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.external_cncpt_map_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.goal_contact_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.goal_intrvntn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.goal_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.intervention_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.intvtn_contact_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flo_custom_list_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flo_gp_data_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flo_measuremnts_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flt_comps_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flt_data_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flwsht_meas_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.ip_flwsht_rec_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.pat_enc_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.patient_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.plan_grp_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.poc_info_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.prob_cp_template_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.prob_goals_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.problem_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.referral_2_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.referral_4_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.referral_dx_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.referral_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.sc_episode_support_types_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.social_care_episode_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.spoc_participants_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_ip_cp_igo_160_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_pos_type_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_rfl_priority_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_rfl_status_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_rfl_type_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_sc_support_type_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_approved_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_canceled_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_closed_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_denied_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_dismissed_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_not_required_rsn_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_um_status_vw.sql;
!load ../schemas/dbo/views/epic_clarity.dbo.zc_val_type_vw.sql;
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
!set variable_substitution=false;
!exit