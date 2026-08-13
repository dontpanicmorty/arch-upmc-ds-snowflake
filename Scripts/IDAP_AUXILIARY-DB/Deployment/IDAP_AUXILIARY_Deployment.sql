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

!load ../Schemas/DatabaseLevelObjects/cms.schema.sql;

!load ../Schemas/DatabaseLevelObjects/emma_reporting.schema.sql;

!load ../Schemas/DatabaseLevelObjects/epic_extract.schema.sql;

!load ../Schemas/DatabaseLevelObjects/greenback.schema.sql;

!load ../Schemas/DatabaseLevelObjects/healthsparq.schema.sql;
!load ../Schemas/DatabaseLevelObjects/healthsparq_2.schema.sql;
!load ../Schemas/DatabaseLevelObjects/hra.schema.sql;

!load ../Schemas/DatabaseLevelObjects/integra.schema.sql;

!load ../Schemas/DatabaseLevelObjects/logdata.schema.sql;

!load ../Schemas/DatabaseLevelObjects/provider_attestation.schema.sql;

!load ../Schemas/DatabaseLevelObjects/stagedata.schema.sql;

!load ../Schemas/DatabaseLevelObjects/provider_directory.schema.sql;

!load ../Schemas/DatabaseLevelObjects/provider_online.schema.sql;

!load ../Schemas/DatabaseLevelObjects/optum_scorecard.schema.sql;

!load ../Schemas/DatabaseLevelObjects/util.schema.sql;

!load ../Schemas/DatabaseLevelObjects/quality.schema.sql;

!load ../Schemas/DatabaseLevelObjects/wellbe.schema.sql;

!load ../Schemas/DatabaseLevelObjects/marketing_eds.schema.sql;
!load ../Schemas/DatabaseLevelObjects/upmchs_labs.schema.sql;

!load ../Schemas/DatabaseLevelObjects/marketing.schema.sql;



----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
--healthsparq
!load ../Schemas/healthsparq/Stages/healthsparq.snowflakedata_outbounddata.sql;

--providerDirectory
!load ../Schemas/provider_directory/Stages/provider_directory.snowflakedata_provider_directory_inbounddata.sql;
!load ../Schemas/provider_directory/Stages/provider_directory.snowflakedata_provider_directory_outbounddata.sql;
--util
!load ../Schemas/util/Stages/util.hpdsdatalake_dbextract_idapaux.sql;
!load ../Schemas/util/Stages/util.snowflakedata_db_extract.sql;
!load ../Schemas/util/Stages/util.snowflakedata_ae2_outgoing.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_outgoing.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_fileloaddata.sql;
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--epic_extract
!load ../Schemas/epic_extract/FileFormats/epic_extract.standard_file_format.sql

--emma_reporting
!load ../Schemas/emma_reporting/FileFormats/emma_reporting.csv_gzip_quoted_file_format.sql;

--greenback
!load ../Schemas/greenback/FileFormats/greenback.outgoing_parquet_file_format.sql;
!load ../Schemas/greenback/FileFormats/greenback.gbh_pipe_delimited_uncompressed.sql;

--epic_extract
!load ../Schemas/epic_extract/FileFormats/epic_extract.standard_file_format.sql;


--healthsparq
!load ../Schemas/healthsparq/FileFormats/healthsparq.Healthsparq_Extract_File_Format.sql;
--hra
!load ../Schemas/hra/FileFormats/hra.Outgoing_Json_Format.sql;
--logdata

--marketing_eds
!load ../Schemas/marketing_eds/FileFormats/marketing_eds.marketing_salesforce_extract_file_format.sql;

--provider_attestation
!load ../Schemas/provider_attestation/FileFormats/provider_attestation.Lexis_Nexis_Csv_Format.sql;
--stagedata
--provider_directory
!load ../Schemas/provider_directory/FileFormats/provider_directory.prov_dir_file_format_nullable.sql;

--optum_scorecard
!load ../Schemas/optum_scorecard/FileFormats/optum_scorecard.outgoing_parquet_file_format.sql;
--util
!load ../Schemas/util/FileFormats/util.db_extract_file_format.sql;
!load ../Schemas/util/FileFormats/util.storage_mover_log_csv_file_format.sql;

--wellbe
!load ../Schemas/wellbe/FileFormats/wellbe.wellbe_export_file_format.sql;
!load ../Schemas/wellbe/FileFormats/wellbe.wellbe_extract_csv.sql;
--upmchs_labs
!load ../Schemas/upmchs_labs/FileFormats/upmchs_labs.epic_healthscreen2_vw_adls_file_format.sql;
!load ../Schemas/upmchs_labs/FileFormats/upmchs_labs.epic_mars_lab_lkp_vw_adls_file_format.sql;


----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--healthsparq
--logdata
--provider_attestation
--stagedata
----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--greenback
!load ../Schemas/greenback/Tables/greenback.plan_design_extract_upmc_outbound.sql;
--healthsparq
!load ../Schemas/healthsparq/Tables/healthsparq.FILE_VERSIONS.sql;
--healthsparq
!load ../Schemas/healthsparq_2/Tables/healthsparq_2.FILE_VERSIONS.sql;
--integra
!load ../Schemas/integra/Tables/integra.sba_oncology_1_eligibility_did.sql;
!load ../Schemas/integra/Tables/integra.sba_oncology_2_medical_claims_did.sql;
!load ../Schemas/integra/Tables/integra.sba_oncology_3_pharmacy_claims_did.sql;
--logdata
!load ../Schemas/logdata/Tables/logdata.adf_epic_export_history.sql;
!load ../Schemas/logdata/Tables/logdata.Healthsparq_Extract_History.sql;
!load ../Schemas/logdata/Tables/logdata.Data_Validation_Result.sql;
!load ../Schemas/logdata/Tables/logdata.Job_Log.sql; 
!load ../Schemas/logdata/Tables/logdata.Table_Load_History.sql; 
!load ../Schemas/logdata/Tables/logdata.Json_Data_Exec_Config.sql;
!load ../Schemas/logdata/Tables/logdata.data_flow_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.storage_mover_raw_logs.sql;

--marketing_eds
!load ../Schemas/marketing_eds/Tables/marketing_eds.household_bridge.sql;

-- Marketing (Acxiom Member Matching)
!load ../Schemas/marketing/Tables/marketing.acxiom_member_matching.sql;

--provider_attestation
--stagedata
--provider_directory
!load ../Schemas/provider_directory/Tables/provider_directory.provider_directory_office_list.sql;
!load ../Schemas/provider_directory/Tables/provider_directory.providers_json_prev.sql;
!load ../Schemas/provider_directory/Tables/provider_directory.providers_json.sql;
!load ../Schemas/provider_directory/Tables/provider_directory.member_networks_json_prev.sql;
!load ../Schemas/provider_directory/Tables/provider_directory.member_networks_json.sql;

--provider_online
!load ../Schemas/provider_online/Tables/provider_online.affiliations_non_participant.sql;
!load ../Schemas/provider_online/Tables/provider_online.contract_non_participant.sql;
!load ../Schemas/provider_online/Tables/provider_online.directory_non_participant.sql;
!load ../Schemas/provider_online/Tables/provider_online.legal_address_relationship.sql;
!load ../Schemas/provider_online/Tables/provider_online.record_max_length_exceeded.sql;
!load ../Schemas/provider_online/Tables/provider_online.directory_non_participant_hard_deletes.sql;
!load ../Schemas/provider_online/Tables/provider_online.directory_non_participant_previous.sql;
!load ../Schemas/provider_online/Tables/provider_online.office_list_non_participant.sql;

--quality
!load ../Schemas/quality/Tables/quality.ccd_allergies.sql;
!load ../Schemas/quality/Tables/quality.ccd_assessments.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_diagnosis_procedure_link.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_diagnosis_procedure.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_participant_link.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_participant.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_performer_link.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena_performer.sql;
!load ../Schemas/quality/Tables/quality.ccd_encounters_athena.sql;
!load ../Schemas/quality/Tables/quality.ccd_functional_status.sql;
!load ../Schemas/quality/Tables/quality.ccd_immunizations.sql;
!load ../Schemas/quality/Tables/quality.ccd_immunizations_athena.sql;
!load ../Schemas/quality/Tables/quality.ccd_medications.sql;
!load ../Schemas/quality/Tables/quality.ccd_meds_in_office.sql;
!load ../Schemas/quality/Tables/quality.ccd_mrn_history.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients_athena.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients_athena_author_link.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients_athena_author.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients_athena_performer_link.sql;
!load ../Schemas/quality/Tables/quality.ccd_patients_athena_performer.sql;
!load ../Schemas/quality/Tables/quality.ccd_payers.sql;
!load ../Schemas/quality/Tables/quality.ccd_problems.sql;
!load ../Schemas/quality/Tables/quality.ccd_procedures.sql;
!load ../Schemas/quality/Tables/quality.ccd_procedures_athena.sql;
!load ../Schemas/quality/Tables/quality.ccd_results.sql;
!load ../Schemas/quality/Tables/quality.ccd_social_history.sql;
!load ../Schemas/quality/Tables/quality.ccd_vital_signs.sql;
!load ../Schemas/quality/Tables/quality.ccd_vital_signs_athena.sql;
!load ../Schemas/quality/Tables/quality.section_xml.sql;
!load ../Schemas/quality/Tables/quality.ccd_control_history.sql;
--util
!load ../Schemas/util/Tables/util.data_flow_control_table.sql;
!load ../Schemas/util/Tables/util.adf_epic_export_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_export_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_storage_copy_control.sql;
----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
!load ../Schemas/util/Functions/util.fxn_array_hash.sqlproc;
----------------------------------------------------------------------------------------------------------
--healthsparq
!load ../Schemas/healthsparq/Functions/healthsparq.fxn_make_filename.sqlproc;
--healthsparq
!load ../Schemas/healthsparq_2/Functions/healthsparq_2.fxn_make_filename.sqlproc;
--quality
!load ../Schemas/quality/Functions/quality.fxn_extract_value.sqlproc;
--logdata
--provider_attestation
--stagedata
----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------

--CMS
!load ../Schemas/cms/Views/cms.npi_deactivations_vw.sql;

--emma_reporting
!load ../Schemas/emma_reporting/Views/emma_reporting.annual_notice_of_change_mail_list_vw.sql;


--epic_extract
!load ../Schemas/epic_extract/Views/epic_extract.acuity_final_active_member_vw.sql;
!load ../Schemas/epic_extract/Views/epic_extract.dxcg_final_active_member_vw.sql;
!load ../Schemas/epic_extract/Views/epic_extract.hcc_final_active_member_vw.sql;
!load ../Schemas/epic_extract/Views/epic_extract.snu_final_active_member_vw.sql;

--greenback
!load ../Schemas/greenback/Views/greenback.claims_extract_upmc_outbound_vw.sql;
!load ../Schemas/greenback/Views/greenback.greenback_claim_f14_vw.sql;
!load ../Schemas/greenback/Views/greenback.eligibility_extract_upmc_outbound_vw.sql;
!load ../Schemas/greenback/Views/greenback.plan_design_extract_upmc_outbound_vw.sql;

--healthsparq
!load ../Schemas/healthsparq/Views/healthsparq.External_MRF_Mapping_Extract_vw.sql;
!load ../Schemas/healthsparq/Views/healthsparq.Plan_Details_Extract_vw.sql;
!load ../Schemas/healthsparq/Views/healthsparq.POS_Mapping_Extract_vw.sql;
!load ../Schemas/healthsparq/Views/healthsparq.Region_Crosswalk_Extract_vw.sql;
!load ../Schemas/healthsparq/Views/healthsparq.OON_Allowed_Amount_Extract_vw.sql;
!load ../Schemas/healthsparq/Views/healthsparq.CONTROL_FILE_EXTRACT_VW.sql;

--healthsparq_2
!load ../Schemas/healthsparq_2/Views/healthsparq_2.External_MRF_Mapping_Extract_vw.sql;
!load ../Schemas/healthsparq_2/Views/healthsparq_2.Plan_Details_Extract_vw.sql;
!load ../Schemas/healthsparq_2/Views/healthsparq_2.POS_Mapping_Extract_vw.sql;
!load ../Schemas/healthsparq_2/Views/healthsparq_2.Region_Crosswalk_Extract_vw.sql;
!load ../Schemas/healthsparq_2/Views/healthsparq_2.OON_Allowed_Amount_Extract_vw.sql;
!load ../Schemas/healthsparq_2/Views/healthsparq_2.CONTROL_FILE_EXTRACT_VW.sql;

--hra
!load ../Schemas/hra/Views/hra.Helios_Join_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Helios_Trans_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Helios_JSON_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Mhol_Flatten_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Mhol_Trans_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Mhol_Json_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Trans_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Json_Select_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Trans_Select_Backdate_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Json_Select_Backdate_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Trans_Select_Current_CMS_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Json_Select_Current_CMS_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Trans_Select_Current_CMS_Backdate_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Json_Select_Current_CMS_Backdate_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Trans_Select_Current_CMS_Backdate_Invalid_vw.sql;
!load ../Schemas/hra/Views/hra.Snpscan_Json_Select_Current_CMS_Backdate_Invalid_vw.sql;


--integra
!load ../Schemas/integra/Views/integra.sba_oncology_1_eligibility_did_vw.sql;
!load ../Schemas/integra/Views/integra.sba_oncology_2_medical_claims_did_vw.sql;
!load ../Schemas/integra/Views/integra.sba_oncology_3_pharmacy_claims_did_vw.sql;

--logdata

--marketing_eds
!load ../Schemas/marketing_eds/Views/marketing_eds.division_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_division_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_rider_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.members_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_members_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.individual_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.address_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_member_rider_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.dnv_member_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.member_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.member_rider_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.member_rider_dnv_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_address_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_division_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_division_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_member_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_member_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_member_rider_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_members_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_dnv_riders_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_individual_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_member_riders_dnv_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_member_riders_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_members_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_plan_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.edw_usr_tab_cavulus_ext_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_account_types_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_accounts_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_conditions_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_dim_state_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_extattr_types_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_individual_extattr_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_medical_home_pcp_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_member_conditions_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_member_preferences_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_ref_zipcodes_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.engagement_valid_emails_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_event_types_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.marketing_member_events_vw.sql;
!load ../Schemas/marketing_eds/Views/marketing_eds.household_source_vw.sql;

-- Marketing(Acxiom Member Matching)
!load ../Schemas/marketing/Views/marketing.acxiom_matching_source_vw.sql;
!load ../Schemas/marketing/Views/marketing.member_matching_source_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_1_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_2_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_3_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_4_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_5_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_6_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_7_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_8_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_9_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_10_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_11_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_12_select_vw.sql;
!load ../Schemas/marketing/Views/marketing.acxiom_member_matching_level_13_unmatched_select_vw.sql;

--provider_attestation
!load ../Schemas/provider_attestation/Views/provider_attestation.lkp_lexis_nexis_cactus_provider_detail_select_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lkp_lexis_nexis_cactus_provider_address_select_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_adaaccess_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_email_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_fax_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_location_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_location_hours_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_location_status_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_name_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_practice_phone_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_board_certification_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_gender_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_hospital_affiliation_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_language_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_name_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_specialties_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lexis_nexis_cactus_provider_status_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lkp_lexis_nexis_cactus_provider_detail_select_vw.sql;
!load ../Schemas/provider_attestation/Views/provider_attestation.lkp_lexis_nexis_cactus_provider_address_select_vw.sql;

--optum_scorecard
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_contract_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_custom_network_paid_status_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_drg_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_peer_epi_etg_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_peer_epi_peg_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_peer_grp_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_pos_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_prod_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_prov_peer_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_provaffil_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_provider_status_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_spec_rx_n_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_spec_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.member_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.provider_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.servicemed_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.servicerx_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.subscriber_vw.sql;
!load ../Schemas/optum_scorecard/Views/optum_scorecard.custom_acct_vw.sql;

-- quality
!load ../Schemas/quality/Views/quality.ccd_allergies_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_assessments_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_diagnosis_procedure_link_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_diagnosis_procedure_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_participant_link_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_participant_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_performer_link_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_performer_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_encounters_athena_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_functional_status_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_immunizations_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_immunizations_athena_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_medications_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_meds_in_office_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_mental_status_html_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_mental_status_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_athena_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_athena_author_link_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_athena_author_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_athena_performer_link_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_patients_athena_performer_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_payers_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_problems_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_procedures_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_procedures_athena_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_results_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_social_history_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_vital_signs_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_vital_signs_athena_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_meds_main_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_meds_consume_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_meds_observe_vw.sql;
!load ../Schemas/quality/Views/quality.ccd_meds_supply_vw.sql;

--stagedata
--provider_directory
!load ../Schemas/provider_directory/Views/provider_directory.provider_directory_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.provider_affiliations_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.providers_contract_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.providers_json_deletes_select_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.providers_json_select_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.member_networks_vw.sql;
!load ../Schemas/provider_directory/Views/provider_directory.member_networks_json_select_vw.sql;

--provider_online
!load ../Schemas/provider_online/Views/provider_online.providers_json_select_cactus_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.providers_json_select_mc400_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.providers_json_select_medgroup_cactus_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.providers_json_select_medgroup_mc400_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.providers_json_tin_vcode_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.compiled_delta_upload_vw.sql;
!load ../Schemas/provider_online/Views/provider_online.hard_delete_sync_vw.sql;

--wellbe
!load ../Schemas/wellbe/Views/wellbe.mao_004_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mao_004_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_beg_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_beg_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_cf_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_cf_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_d_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_d_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_i_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_i_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_j_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_j_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_k_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_k_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_l_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_l_latest_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_m_historical_extract_vw.sql;
!load ../Schemas/wellbe/Views/wellbe.mor_hcc_m_latest_extract_vw.sql;


--logdata
!load ../Schemas/logdata/Views/logdata.storage_mover_summary_vw.sql;

--upmchs_labs
!load ../Schemas/upmchs_labs/Views/upmchs_labs.epic_healthscreen2_vw.sql;
!load ../Schemas/upmchs_labs/Views/upmchs_labs.epic_mars_lab_lkp_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/StoredProcedures/util.spu_epic_export.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_set_query_tag.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_run_data_flow.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_export_sf_table_to_data_lake.sqlproc;
--greenback
!load ../Schemas/greenback/StoredProcedures/greenback.spu_load_plan_design_extract_upmc_outbound.sqlproc;
--!load ../Schemas/util/StoredProcedures/util.spu_no_op.sqlproc; --This procedure is illustrative and does not need deployed
--healthsparq
!load ../Schemas/healthsparq/StoredProcedures/healthsparq.spu_Extract_File.sqlproc;
!load ../Schemas/healthsparq/StoredProcedures/healthsparq.spu_Run_Extract.sqlproc;
--healthsparq_2
!load ../Schemas/healthsparq_2/StoredProcedures/healthsparq_2.spu_Extract_File.sqlproc;
!load ../Schemas/healthsparq_2/StoredProcedures/healthsparq_2.spu_Run_Extract.sqlproc;
--hra
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Helios_Json_Data.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Mhol_Json_Data.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Snpscan_Json_Data.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Snpscan_Json_Data_Backdate.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Snpscan_Json_Data_Current_CMS.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Snpscan_Json_Data_Current_CMS_Backdate.sqlproc;
!load ../Schemas/hra/StoredProcedures/hra.spu_Export_Snpscan_Json_Data_Current_CMS_Backdate_Invalid.sqlproc;

--logdata
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Set_Job_Id.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Dupe_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Primary_Key_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_refresh_storage_mover_raw_logs.sqlproc;

--marketing_eds
!load ../Schemas/marketing_eds/StoredProcedures/marketing_eds.spu_household_matching.sqlproc;

-- Marketting(Acxiom Member Matching)
!load ../Schemas/marketing/StoredProcedures/marketing.spu_Load_Acxiom_Member_Matching.sqlproc;

--provider_attestation
!load ../Schemas/provider_attestation/StoredProcedures/provider_attestation.spu_Export_LexisNexis_Files_To_Adls.sqlproc;
--quality
!load ../Schemas/quality/StoredProcedures/quality.spu_insert_section_xml.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_allergies.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_assessments.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_diagnosis_procedure_link.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_diagnosis_procedure.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_participant_link.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_participant.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_performer_link.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena_performer.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_encounters_athena.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_functional_status.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_immunizations.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_immunizations_athena.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_medications.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_meds_in_office.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients_athena.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients_athena_author.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients_athena_author_link.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients_athena_performer.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_patients_athena_performer_link.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_payers.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_problems.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_procedures.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_procedures_athena.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_results.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_social_history.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_vital_signs.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_vital_signs_athena.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_load_clearsense_control_history.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_ccd_process_mrn_history.sqlproc;

--stagedata
--provider_directory
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Load_Provider_Directory_Office_List.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_InsertOverwrite_Providers_Json_Prev.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_InsertOverwrite_Providers_Json.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Remove_Target_Files.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Extract_Providers.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Extract_Deletes.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Load_FindCare_Provider_Master.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_InsertOverwrite_Member_Networks_Json_Prev.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_InsertOverwrite_Member_Networks_Json.sqlproc;
!load ../Schemas/provider_directory/StoredProcedures/provider_directory.spu_Load_FindCare_Member_Networks_Master.sqlproc;

--provider-online
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Merge_Directory_Non_Participant_Hard_Delete.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Merge_Directory_Non_Participant_Previous.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Merge_Office_List_Non_Participant.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Merge_Sync_To_Prev.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Truncate_Insert_Provider_Online_Tables.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Merge_Max_Length_Exceeded.sqlproc;
!load ../Schemas/provider_online/StoredProcedures/provider_online.spu_Update_Missing_Provider_Inserts.sqlproc;
--upmchs_labs
!load ../Schemas/upmchs_labs/StoredProcedures/upmchs_labs.spu_export_epic_healthscreen2_vw_to_adls.sqlproc;
!load ../Schemas/upmchs_labs/StoredProcedures/upmchs_labs.spu_export_epic_mars_lab_lkp_vw_to_adls.sqlproc;


----------------------------------------------------------------------------------------------------------
-- CODE REVIEW SCRIPT
----------------------------------------------------------------------------------------------------------
--!load ../../ValidationScripts/CodeReview.sql;
!exit