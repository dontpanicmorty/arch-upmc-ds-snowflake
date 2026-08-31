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
!set variable_substitution=false;

--***************************************************************************
--***** THE ORDER OF EXECUTION IS BASED OFF OF DATABASE DEPENDENCIES!! ******
--***************************************************************************
----------------------------------------------------------------------------------------------------------
-- Schemas
----------------------------------------------------------------------------------------------------------
!load ../Schemas/DatabaseLevelObjects/util.schema.sql;
!load ../Schemas/DatabaseLevelObjects/logdata.schema.sql;
!load ../Schemas/DatabaseLevelObjects/encounter_data_management_coreedmdb_stage.schema.sql;
!load ../Schemas/DatabaseLevelObjects/encounter_data_management_reportedmdb_stage.schema.sql;
!load ../Schemas/DatabaseLevelObjects/healthplanet_rs_stage.schema.sql;
!load ../Schemas/DatabaseLevelObjects/emma_stage.schema.sql;
!load ../Schemas/DatabaseLevelObjects/epic_caboodle_stage.schema.sql;
!load ../Schemas/DatabaseLevelObjects/epic_clarity_stage.schema.sql;




--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/Stages/util.snowflakedata_db_extract.sql;
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
-- util
!load ../Schemas/util/FileFormats/util.db_extract_parquet_file_format.sql;
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
--emma_stage
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_contact_member_ids.sql;
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_contact_special_statuses.sql;
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_memberships.sql;


--encounter_data_management_reportedmdb_stage
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responseclaimstatuscode.sql;

--encounter_data_management_coreedmdb_stage
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderdate.sql;

--healthplanet_rs_stage
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__user_response.sql;

--logdata
!load ../Schemas/logdata/Tables/logdata.adf_table_load_history.sql;

--util
!load ../Schemas/util/Tables/util.adf_sqldb_copy_control.sql;

--epic_caboodle_stage
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__analyticscontentfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__authorizationfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__bedrequestfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__birthfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__bpafact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__caremanagementcasefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__caremanagementteamfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__careplaneventmappingfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__careplanfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__checklisttaskfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__clinicalnotefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__continuingcarerequestfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__coveragedim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__dashboardusagefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__diagnosisdim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__diagnosisterminologydim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__drgeventfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilityeventfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilitytransactionalternatepayerfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilitytransactionbenefitfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilitytransactioncoveragefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilitytransactionerrorfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__eligibilitytransactionfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__employeedim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__employergrouprenewalfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__encounterfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__episodeencountermappingfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__episodefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__episodemonthlyoutcomedatamart.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__episodetypedim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__flowsheetrowdim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__flowsheettemplatedim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__flowsheetvaluefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__healthmaintenanceactionfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__healthplanappealgrievancefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__interfaceerroreventfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__interfacemessageeventfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__lineofbusinessdim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__medicationtherapyproblemfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__memberinsightdatamart.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__memberinsightfeedbackactionfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__messagerecipientfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__mtpsentcommunicationfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__patientdim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__pregnancyfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__proceduredim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__providerdim.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__qualityoutcomefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__referralfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__reportrunfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__requireddocumentationfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__riskadjustmentcomponentdatamart.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__riskadjustmentevidencefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__riskadjustmentmodeldatamart.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__riskadjustmentproviderauditfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialcarecommattemptpatientmappingfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialcarecommunicationattemptfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialcareepisodeeventfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialcareepisodefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialdeterminantfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialdeterminantpatientdomainfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__socialdeterminanttrendingdatamart.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__useractionlogactivityhourfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__useractionlogshiftfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__utilmgmtauthorizationrequestfact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__utilmgmtauthorizationrequestservicefact.sql;
!load ../Schemas/epic_caboodle_stage/Tables/epic_caboodle_stage.dbo__utilmgmtcoverageguidancerequestfact.sql;

--epic_clarity_stage
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__access_log.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__all_categories.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__aut_proc_details.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__aut_proc_mods.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__auth_request_hx_2.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__auth_request_hx.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__auth_request.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__auth_um_status_hx.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__authorizations.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__care_intg_elem.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__careplan_info.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__careplan_temp_info.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__cl_qanswer_qa.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__cl_qanswer.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__cl_ub_rev_code.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__concept_mapped.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__coverage.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__docs_rcvd_encounters.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__episode_all.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__external_cncpt_map.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__goal_contact.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__goal_intrvntn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__goal.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__intervention.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__intvtn_contact.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flo_custom_list.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flo_gp_data.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flo_measuremnts.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flt_comps.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flt_data.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flwsht_meas.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__ip_flwsht_rec.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__pat_enc.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__patient.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__plan_grp.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__poc_info.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__prob_cp_template.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__prob_goals.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__problem.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__referral_2.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__referral_4.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__referral_dx.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__referral.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__sc_episode_support_types.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__social_care_episode.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__spoc_participants.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_ip_cp_igo_160.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_pos_type.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_rfl_priority.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_rfl_status.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_rfl_type.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_sc_support_type.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_approved_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_canceled_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_closed_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_denied_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_dismissed_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_not_required_rsn.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_um_status.sql;
!load ../Schemas/epic_clarity_stage/Tables/epic_clarity_stage.dbo__zc_val_type.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
!load ../Schemas/util/Functions/util.fxn_array_hash.sqlproc;

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------


--util
!load ../Schemas/util/StoredProcedures/util.spu_sqldb_copy_into.sqlproc;



!exit