/*----------------------------------------------------------------------------------------------------------
This is the master deployment procedure for the database. Only the items in this script will be 
deployed to the target database.

Connection option example for deployment via SnowSQL:
    -f IDAP_Deployment.sql 
    --variable build_number="<your build number>" 
    --variable environment="<dev, tst, prd>" 
    -o log_level=debug 
    -o timing=false 
    -o header=false 
    -o echo=true 
    -o exit_on_error=true 
    -o output_file=IDAP_Deployment.log
----------------------------------------------------------------------------------------------------------*/
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
-- trigger change comment
!load ../DatabaseLevelObjects/Schemas/aca.schema.sql;
!load ../DatabaseLevelObjects/Schemas/application_events.schema.sql;
!load ../DatabaseLevelObjects/Schemas/authorization.schema.sql;
!load ../DatabaseLevelObjects/Schemas/claim.schema.sql;
!load ../DatabaseLevelObjects/Schemas/cms.schema.sql;
!load ../DatabaseLevelObjects/Schemas/logdata.schema.sql;
!load ../DatabaseLevelObjects/Schemas/member.schema.sql;
!load ../DatabaseLevelObjects/Schemas/member_communications.schema.sql;
!load ../DatabaseLevelObjects/Schemas/network.schema.sql;
!load ../DatabaseLevelObjects/Schemas/pricing.schema.sql;
!load ../DatabaseLevelObjects/Schemas/provider.schema.sql;
!load ../DatabaseLevelObjects/Schemas/util.schema.sql;
!load ../DatabaseLevelObjects/Schemas/assessment.schema.sql;
!load ../DatabaseLevelObjects/Schemas/premium.schema.sql;
!load ../DatabaseLevelObjects/Schemas/quality.schema.sql;
!load ../DatabaseLevelObjects/Schemas/incentive.schema.sql;
!load ../DatabaseLevelObjects/Schemas/interaction.schema.sql;
!load ../DatabaseLevelObjects/Schemas/rawdata.schema.sql;
!load ../DatabaseLevelObjects/Schemas/reference.schema.sql;
!load ../DatabaseLevelObjects/Schemas/healthplanet_rs_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/healthplanet_app_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/emma_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/acxiomdb.schema.sql;
!load ../DatabaseLevelObjects/Schemas/marketing_prospects.schema.sql;
!load ../DatabaseLevelObjects/Schemas/evolve_crm.schema.sql;
!load ../DatabaseLevelObjects/Schemas/tcscompdb_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/marketplace_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/messagecenter_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/virtual_health_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edi_edge_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/encounter_data_management_reportedmdb_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/encounter_data_management_edmstagingloaderdb_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/encounter_data_management_coreedmdb_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/dhs.schema.sql;
!load ../DatabaseLevelObjects/Schemas/lab.schema.sql;
!load ../DatabaseLevelObjects/Schemas/genesys_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/piwik.schema.sql;
!load ../DatabaseLevelObjects/Schemas/plan.schema.sql;
----------------------------------------------------------------------------------------------------------
-- TAGS
!load ./tag.manifest.sql;
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------
-- Stages
----------------------------------------------------------------------------------------------------------

--application_events
!load ../Schemas/application_events/Stages/application_events.snowflakedata_consumertech_apimlogs.sql;
!load ../Schemas/application_events/Stages/application_events.snowflakedata_consumertech_member_notifications.sql;
!load ../Schemas/application_events/Stages/application_events.snowflakedata_consumertech_member_notificationerrors.sql;
!load ../Schemas/application_events/Stages/application_events.snowflakedata_consumertech_authorizations.sql;
--util

!load ../Schemas/util/Stages/util.hpdsdatalake_fileloaddata.sql;
!load ../Schemas/util/Stages/util.snowflakedata_ae2_idaplake.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_dbextract_idap_lake.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_idaplake.sql;
!load ../Schemas/util/Stages/util.snowflakedata_db_extract.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_outgoing.sql;
!load ../Schemas/util/Stages/util.hpdsdatalake_ddlautomation.sql;

--marketing_prospects
!load ../Schemas/marketing_prospects/Stages/marketing_prospects.snowflakedata_marketing_prospects.sql;


--member
!load ../Schemas/member/Stages/member.hpdsdatalake_preference_center.sql;

--network
!load ../Schemas/network/Stages/network.snowflakedata_bpl_rider_network_crosswalk.sql;
!load ../Schemas/network/Stages/network.snowflakedata_lob_plan_type.sql;

--quality
!load ../Schemas/quality/Stages/quality.clearsense_ccd_index.sql;
!load ../Schemas/quality/Stages/quality.clearsense_ccd_xml.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--application_events
!load ../Schemas/application_events/FileFormats/application_events.apimlogs_file_format.sql;
!load ../Schemas/application_events/FileFormats/application_events.sms_message_logs_file_format.sql;
!load ../Schemas/application_events/FileFormats/application_events.member_notifications_file_format.sql;
!load ../Schemas/application_events/FileFormats/application_events.member_notificationerrors_file_format.sql;
!load ../Schemas/application_events/FileFormats/application_events.authorizations_file_format.sql;

--assessment
!load ../Schemas/assessment/FileFormats/assessment.snp_file_format.sql;

--authorization
!load ../Schemas/authorization/FileFormats/authorization.pahub_all_eoc_file_format.sql;

!load ../Schemas/authorization/FileFormats/authorization.rx_prior_authorization_file_format.sql;

--claim
!load ../Schemas/claim/FileFormats/claim.amplifon_commercial_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.chip_newserhist_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.cmu_cvs_stoploss_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.cvs_stoploss_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.helpscripts_billing_detail_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.esi_claim_record_adj_f14_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.esi_spe384_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.greenback_rx_plan_design_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.greenback_rx_claim_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nva_paid_claim_extract_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nva_paid_claim_extract_file_format_header.sql;
!load ../Schemas/claim/FileFormats/claim.nations_benefits_data_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nations_benefits_post_discharge_meals_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.pahub_user_productivity_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.cotiviti_ppm_idr_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.pharmacy_nadac_csv_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.wex_data_final_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.spanish_not_covered_reason_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.drexi_rx_stoploss_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.evv_acceptance_outcomes_csv_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nations_benefits_produce_meals_item_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nations_benefits_produce_meals_order_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.nations_benefits_shelf_stable_meals_file_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.conversio_claims_csv_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.proact_stoploss_claims_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.rx_carve_out_somerset_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.truescripts_rx_stoploss_file_format.sql;
!load ../Schemas/claim/FileFormats/claim.cmu_aetna_stoploss_file_format.sql;

--cms
!load ../Schemas/cms/FileFormats/cms.mmr_file_format.sql;
!load ../Schemas/cms/FileFormats/cms.response_fixed_file_format.sql;
!load ../schemas/cms/FileFormats/cms.transaction_reply_file_format.sql;
!load ../schemas/cms/FileFormats/cms.late_enrollment_penalty_file_format.sql;
!load ../schemas/cms/FileFormats/cms.monthly_premium_withholding_report_file_format.sql;
!load ../Schemas/cms/FileFormats/cms.batch_completion_status_summary_file_format.sql;
!load ../Schemas/cms/FileFormats/cms.medicare_enrollment_file_format.sql;
!load ../Schemas/cms/FileFormats/cms.drug_event_hist_parquet_file_format.sql;

--marketing_prospects
!load ../Schemas/marketing_prospects/FileFormats/marketing_prospects.prospect_address_file_format.sql;

--dhs
!load ../Schemas/dhs/FileFormats/dhs.medicaid_pend_enroll_file_format.sql;

--member
!load ../Schemas/member/FileFormats/member.qualtrics_survey_response_file_format.sql;
!load ../Schemas/member/FileFormats/member.member_preferences_file_format.sql;
!load ../Schemas/member/FileFormats/member.carrot_fertility_data_file_format.sql;
!load ../Schemas/member/FileFormats/member.empi_daily_global_file_format.sql;
!load ../Schemas/member/FileFormats/member.holon_gap_resp_data_file_format.sql;
!load ../Schemas/member/FileFormats/member.wex_representative_interactions_file_format.sql;
!load ../Schemas/member/FileFormats/member.wellbe_engagement_file_format.sql;
!load ../Schemas/member/FileFormats/member.wellbe_export_file_format.sql;
!load ../Schemas/member/FileFormats/member.inspira_subscriber_fsa_file_format.sql;

--member_communications
!load ../Schemas/member_communications/FileFormats/member_communications.mir_pnf_file_format.sql;

--incentive
!load ../Schemas/incentive/FileFormats/incentive.aver_ob_data_file_format.sql

--network
!load ../Schemas/network/FileFormats/network.simplify_plan_package_file_format.sql;
!load ../Schemas/network/FileFormats/network.bpl_rider_network_crosswalk_file_format_header.sql;
!load ../Schemas/network/FileFormats/network.bpl_rider_network_crosswalk_file_format.sql;
!load ../Schemas/network/FileFormats/network.lob_plan_type_file_format_header.sql;
!load ../Schemas/network/FileFormats/network.lob_plan_type_file_format.sql;

--plan
!load ../Schemas/plan/FileFormats/plan.caa_d6_summary_file_format.sql;
!load ../Schemas/plan/FileFormats/plan.caa_main_file_format.sql;
!load ../Schemas/plan/FileFormats/plan.caa_summary_file_format.sql;

--pricing
!load ../Schemas/pricing/FileFormats/pricing.business_fixed_file_format.sql
!load ../Schemas/pricing/FileFormats/pricing.business_file_format.sql
!load ../Schemas/pricing/FileFormats/pricing.business_file_format_header.sql
!load ../Schemas/pricing/FileFormats/pricing.business_comma_delim_file_format.sql

--provider
!load ../Schemas/provider/FileFormats/provider.healthplan_id_xwalk_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.healthplan_id_xwalk_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.prv414_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.prv414_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.prv430_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.prv430_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_cancer_center_ancillary_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_cancer_center_ancillary_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_kids_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_kids_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_life_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_life_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_you_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_for_you_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_medicare_silver_sneakers_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_medicare_silver_sneakers_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_medicare_silver_sneakers_ymca_file_format_header.sql;
!load ../Schemas/provider/FileFormats/provider.upmc_medicare_silver_sneakers_ymca_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.provider_online_cosmos_sync_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.lexis_nexis_file_format.sql
!load ../Schemas/provider/FileFormats/provider.idap_provider_daily_global_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.tsv_file_format.sql;
!load ../Schemas/provider/FileFormats/provider.kyruus_file_format.sql;

-- quality --
!load ../Schemas/quality/FileFormats/quality.ff_ccd_control_file_format.sql;
!load ../Schemas/quality/FileFormats/quality.ff_raw_xml.sql;

--util
!load ../Schemas/util/FileFormats/util.FILE_LOADER_FILE_FORMAT.sql;
!load ../Schemas/util/FileFormats/util.db_extract_file_format.sql;
!load ../Schemas/util/FileFormats/util.ADF_LOGGING_FILE_FORMAT.sql;

!load ../Schemas/util/FileFormats/util.db_extract_parquet_file_format.sql;
!load ../Schemas/util/FileFormats/util.historical_extract_parquet_file_format.sql;

!load ../Schemas/util/FileFormats/util.db_extract_parquet_file_format.sql;
!load ../Schemas/util/FileFormats/util.npi_csv_format.sql;

--reference
!load ../Schemas/reference/FileFormats/reference.public_data_import_file_format.sql

--evolve_crm
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.automatic_membership_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.campaign_history_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.campaign_report_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.event_data_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.event_rsvp_data_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.lead_data_profile_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.repdata_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.notes_export_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.upmc_genesys_log_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.member_window_detail_file_format.sql;
!load ../Schemas/evolve_crm/FileFormats/evolve_crm.aep_lead_nurturing_file_format.sql;

--lab
!load ../Schemas/lab/FileFormats/lab.epic_mars_csv_file_format.sql;
--piwik
!load ../Schemas/piwik/FileFormats/piwik.daily_events_sessions_file_format.sql;
----------------------------------------------------------------------------------------------------------
-- Stages 2
----------------------------------------------------------------------------------------------------------
--These Stages must come after file formats; Dependent in definition
!load ../Schemas/claim/Stages/claim.pharmacy_nadac_stage.sql;

----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--aca
!load ../Schemas/aca/Tables/aca.rarsd_diagnosiscodecategory.sql;
!load ../Schemas/aca/Tables/aca.rarsd_enrolleecategory.sql;
!load ../Schemas/aca/Tables/aca.rarsd_enrolleehccdroppedcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_enrolleeperiodcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_fileheader.sql;
!load ../Schemas/aca/Tables/aca.rarsd_hccgroupcategory.sql;
!load ../Schemas/aca/Tables/aca.rarsd_ndccodecategory.sql;
!load ../Schemas/aca/Tables/aca.rarsd_paymenthcccategory.sql;
!load ../Schemas/aca/Tables/aca.rarsd_planidentifier.sql;
!load ../Schemas/aca/Tables/aca.rarsd_ratingarea.sql;
!load ../Schemas/aca/Tables/aca.rarsd_ratingareahccdroppedcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_ratingareaseveritylvlcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_repot.sql;
!load ../Schemas/aca/Tables/aca.rarsd_riskscoredetailreport.sql;
!load ../Schemas/aca/Tables/aca.rarsd_rxccreatedbysrvcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_rxctohccintractcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_rxctohccintractgroupcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_severitylevelcat.sql;
!load ../Schemas/aca/Tables/aca.rarsd_subpolicycategory.sql;
!load ../Schemas/aca/Tables/aca.ratee_report.sql;

--application_events
!load ../Schemas/application_events/Tables/application_events.apim_logs.sql;
!load ../Schemas/application_events/Tables/application_events.sms_message_logs.sql;
!load ../Schemas/application_events/Tables/application_events.member_notifications.sql;
!load ../Schemas/application_events/Tables/application_events.member_notificationerrors.sql;
!load ../Schemas/application_events/Tables/application_events.authorizations.sql;

--authorization
!load ../Schemas/authorization/Tables/authorization.pahub_all_eoc.sql;
!load ../Schemas/authorization/Tables/authorization.RX_PRIOR_AUTHORIZATION.sql;

--util
!load ../Schemas/util/Tables/util.file_loader_control.sql;
!load ../Schemas/util/Tables/util.adf_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_oracle_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_sharepoint_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_sqldb_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_hpdsdatalake_file_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_mysqldb_copy_control.sql;
!load ../Schemas/util/Tables/util.file_load_copy_control.sql;

--logdata
!load ../Schemas/logdata/Tables/logdata.file_loader_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_table_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_file_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_filename_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_oracle_filename_history.sql;
!load ../Schemas/logdata/Tables/logdata.zenoss_member_mobile_claims_history.sql;
!load ../Schemas/logdata/Tables/logdata.table_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.load_member_preferences_history.sql;
!load ../Schemas/logdata/Tables/logdata.infer_file_ddl_history.sql;

--claim
!load ../Schemas/claim/Tables/claim.amplifon_commercial_utilization.sql;
!load ../Schemas/claim/Tables/claim.cmu_cvs_stoploss_det_history.sql;
!load ../Schemas/claim/Tables/claim.cmu_cvs_stoploss_hdr_history.sql;
!load ../Schemas/claim/Tables/claim.cmu_cvs_stoploss_stage.sql;
!load ../Schemas/claim/Tables/claim.cmu_cvs_stoploss_tlr_history.sql;
!load ../Schemas/claim/Tables/claim.cvs_stoploss_det_history.sql;
!load ../Schemas/claim/Tables/claim.cvs_stoploss_hdr_history.sql;
!load ../Schemas/claim/Tables/claim.cvs_stoploss_stage.sql;
!load ../Schemas/claim/Tables/claim.cvs_stoploss_tlr_history.sql;
!load ../Schemas/claim/Tables/claim.drug_event_cms_ddps_return.sql;
!load ../Schemas/claim/Tables/claim.esi_claim_record_daily.sql;
!load ../Schemas/claim/Tables/claim.esi_claim_record_adj_f14.sql;
!load ../Schemas/claim/Tables/claim.esi_spe384.sql;
!load ../Schemas/claim/Tables/claim.greenback_rx_claim_file.sql;
!load ../Schemas/claim/Tables/claim.greenback_rx_claim_history.sql;
!load ../Schemas/claim/Tables/claim.nva_paid_claim_extract.sql;
!load ../Schemas/claim/Tables/claim.nations_benefits_data.sql;
!load ../Schemas/claim/Tables/claim.nations_benefits_post_discharge_meals.sql;   
!load ../Schemas/claim/Tables/claim.pahub_user_productivity.sql;
!load ../Schemas/claim/Tables/claim.cotiviti_ppm_data_stg.sql;
!load ../Schemas/claim/Tables/claim.stage_medicaid_nadac.sql;
!load ../Schemas/claim/Tables/claim.pharmacy_nadac_pricing_history.sql;
!load ../Schemas/claim/Tables/claim.aetna_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.amerihealth_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.amplifon_data.sql;
!load ../Schemas/claim/Tables/claim.caa_d6_summary.sql;
!load ../Schemas/claim/Tables/claim.caa_main.sql;
!load ../Schemas/claim/Tables/claim.caa_summary.sql;
!load ../Schemas/claim/Tables/claim.chip_newserhist_inpatient.sql;
!load ../Schemas/claim/Tables/claim.chip_newserhist_medical.sql;
!load ../Schemas/claim/Tables/claim.chip_newserhist_pharmacy.sql;
!load ../Schemas/claim/Tables/claim.chip_newserhist_revenue.sql;
!load ../Schemas/claim/Tables/claim.cigna_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.cigna_rx_dsnp.sql;
!load ../Schemas/claim/Tables/claim.cologuard_claims.sql;
!load ../Schemas/claim/Tables/claim.gateway_rx_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.gateway_adm_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.gateway_rx_dsnp_new.sql;
!load ../Schemas/claim/Tables/claim.geisinger_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.greenback_rx_plan_design.sql;
!load ../Schemas/claim/Tables/claim.health_ptnr_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.helpscripts_billing_detail.sql;
!load ../Schemas/claim/Tables/claim.humana_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.in820_shop_ppr.sql;
!load ../Schemas/claim/Tables/claim.in820_shop_hdr.sql;
!load ../Schemas/claim/Tables/claim.in820_shop_det.sql;
!load ../Schemas/claim/Tables/claim.mor_rxhcc_v08.sql;
!load ../Schemas/claim/Tables/claim.pa_hub_all_eoc.sql;
!load ../Schemas/claim/Tables/claim.pa_hub_prior_authorizations.sql;
!load ../Schemas/claim/Tables/claim.pa_hub_test_claims.sql;
!load ../Schemas/claim/Tables/claim.pahw_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.aetna_rx_dsnp.sql;
!load ../Schemas/claim/Tables/claim.united_dsnp_data.sql;
!load ../Schemas/claim/Tables/claim.washington_hosp_carveout.sql;
!load ../Schemas/claim/Tables/claim.drexi_rx_stoploss.sql;
!load ../Schemas/claim/Tables/claim.evv_acceptance_outcomes.sql;
!load ../Schemas/claim/Tables/claim.nations_benefits_produce_meals_item.sql;
!load ../Schemas/claim/Tables/claim.nations_benefits_produce_meals_order.sql;
!load ../Schemas/claim/Tables/claim.nations_benefits_shelf_stable_meals_file.sql;
!load ../Schemas/claim/Tables/claim.conversio_claims.sql;
!load ../Schemas/claim/Tables/claim.rx_carve_out_somerset_current.sql;
!load ../Schemas/claim/Tables/claim.rx_carve_out_somerset_history.sql;
!load ../Schemas/claim/Tables/claim.proact_stoploss_claims_stage.sql;
!load ../Schemas/claim/Tables/claim.proact_stoploss_claims_history.sql;
!load ../Schemas/claim/Tables/claim.truescripts_rx_stoploss.sql;
!load ../Schemas/claim/Tables/claim.cmu_aetna_stoploss_current.sql;
!load ../Schemas/claim/Tables/claim.cmu_aetna_stoploss_history.sql;

--cms
!load ../Schemas/cms/Tables/cms.mmr_pre062026.sql;
!load ../Schemas/cms/Tables/cms.mmr.sql;
!load ../Schemas/cms/Tables/cms.response_mao_001_stage.sql;
!load ../Schemas/cms/Tables/cms.response_mao_002_stage.sql;
!load ../Schemas/cms/Tables/cms.response_mao_004_stage.sql;
!load ../Schemas/cms/Tables/cms.response_mor_stage.sql;
!load ../Schemas/cms/Tables/cms.response_mor_types.sql;
!load ../schemas/cms/Tables/cms.transaction_reply.sql;
!load ../schemas/cms/Tables/cms.late_enrollment_penalty.sql;
!load ../schemas/cms/Tables/cms.monthly_premium_withholding_report.sql;
!load ../Schemas/cms/Tables/cms.batch_completion_status_summary.sql;
!load ../Schemas/cms/Tables/cms.lis_history.sql;
!load ../Schemas/cms/Tables/cms.full_enrollment.sql;
!load ../Schemas/cms/Tables/cms.monthly_norx.sql;
!load ../Schemas/cms/Tables/cms.lis_part_d_premium.sql;
!load ../Schemas/cms/Tables/cms.ma_full_dual_auto_assignment_notification.sql;
!load ../Schemas/cms/Tables/cms.medicare_advantage_medicaid_status.sql;
!load ../Schemas/cms/Tables/cms.monthly_medicare_secondary_payer_part_c.sql;
!load ../Schemas/cms/Tables/cms.part_b_claims.sql;
!load ../Schemas/cms/Tables/cms.cob_ohi_annual_summary.sql;
!load ../Schemas/cms/Tables/cms.agent_broker_compensation_report.sql;
!load ../Schemas/cms/Tables/cms.loss_of_subsidy.sql;
!load ../Schemas/cms/Tables/cms.no_premium_due.sql;
!load ../Schemas/cms/Tables/cms.annual_cob_ohi_full_replacement.sql;
!load ../Schemas/cms/Tables/cms.drug_event_error_summary_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_error_summary_bhd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_error_summary_btr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_error_summary_hdr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_error_summary_rpt_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_chd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_ctr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_det_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_rhd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_41cov_rtr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_chd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_ctr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_det_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_phd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_42cov_ptr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_chd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_ctr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_det_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_shd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_43cov_str_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_chd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_ctr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_det_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_phd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40cov_ptr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_chd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_ctr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_det_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_phd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_40otc_ptr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_return_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_ret_bhd_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_ret_btr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_ret_hdr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_ret_tlr_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_return_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_cov_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_cms_cov_history.sql;
!load ../Schemas/cms/Tables/cms.drug_event_ddps_otc_stage.sql;
!load ../Schemas/cms/Tables/cms.drug_event_cms_otc_history.sql;
!load ../Schemas/cms/Tables/cms.npi.sql;

--dhs
!load ../Schemas/dhs/Tables/dhs.medicaid_pend_enroll.sql; 

--emma_stage
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_contact_member_ids.sql;
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_contact_special_statuses.sql;
!load ../Schemas/emma_stage/Tables/emma_stage.dbo__live_memberships.sql;

--healthplanet_rs_stage
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__adt_discharge_disposition_codes.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__can_successful_cross_reference.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__census_final.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__dischargedispositionmaster.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_gap_documentation_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_hmd_documentation_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_ond_documentation_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_ongoing_documentation_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_post_disch_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__epic_visit_documentation_can.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__master_member_eligibility_provider.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__masterpatienttype.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__mltss_assessment_data.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__mtm_base_yearly.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__mtm_can_yearly.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__mtm_med_review_yearly.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__pfworder.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__retention_rates_cpr_5yr_rolling.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__adt_admittypenew.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__adt_dischargedispositionnew.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__adt_patienttypenew.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__adt_pavillionnew.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_bd_enrollee.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_activity.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_claim_note.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_dxproc.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_finalized.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_finalized_overturned.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_requested.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_authorization_requested_ids.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_case.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_case_custom.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_case_sbtest.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_contact.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_discharge.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_dxproc_sbtest.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_dxproc_tbd.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_flag.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_goal.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_intervention.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_level_of_care.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_ltr_sent.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_cms_problem.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_medipacreporting.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_umclosedcase.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__olap_umopencase.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__vw_snp_has_with_icp.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.biteam__snp_has_assessment_data.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.rds__chc_has_assessment_data.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.dbo__mtn_flag_category.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__assessment.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__question_response.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__question_type.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__response_type.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__response.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__user_assessment_status.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__user_assessment.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__user_response.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__assessment_item.sql;
!load ../Schemas/healthplanet_rs_stage/Tables/healthplanet_rs_stage.assessment__categorytype.sql;


--healthplanet_app_stage
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.audit__condition_center.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_elgibility_subscriber.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_enrollee_address.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_enrollee.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_group_package_network.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_group_package.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_group.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_network_type.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_network.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__bd_provider.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__cms_case.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__cms_contact.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__cms_level_of_care.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_act_action.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_activity_category.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_activity_response.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_case_status.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_condition_level.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_condition_program_module.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_condition_referral_type.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_contact_category.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_diag_proc_history.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_diag_proc_type.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_diag_proc.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_disease_category.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_goal_reason.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_goal.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_level_of_care.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_outcome.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_setting.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_staff_department.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_staff_designation.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_staff_specialty.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__mtn_staff_type.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__sec_staff.sql;
!load ../Schemas/healthplanet_app_stage/Tables/healthplanet_app_stage.dbo__sys_care_program.sql;

--incentive
!load ../Schemas/incentive/Tables/incentive.aver_ob_data.sql;
!load ../Schemas/incentive/Tables/incentive.aces_data_registry_vbid.sql;
!load ../Schemas/incentive/Tables/incentive.aon_health_exchange.sql;
!load ../Schemas/incentive/Tables/incentive.myhealth_at_work_data.sql;
!load ../Schemas/incentive/Tables/incentive.ucci_dental_pa_cyber_claims.sql;
!load ../Schemas/incentive/Tables/incentive.time_and_outcome_data.sql;
!load ../Schemas/incentive/Tables/incentive.user_summary_new.sql;
!load ../Schemas/incentive/Tables/incentive.wex_data.sql;

--interaction
!load ../Schemas/interaction/Tables/interaction.cavulus_ext.sql;
!load ../Schemas/interaction/Tables/interaction.cavulus_sales.sql;
!load ../Schemas/interaction/Tables/interaction.convey_order_data.sql;
!load ../Schemas/interaction/Tables/interaction.convey_returns_data.sql;
!load ../Schemas/interaction/Tables/interaction.healthsparq_source.sql;
!load ../Schemas/interaction/Tables/interaction.healthy_food_card_transactions.sql;
!load ../Schemas/interaction/Tables/interaction.limber_health_data.sql;
!load ../Schemas/interaction/Tables/interaction.omw_report_data.sql;

--marketing_prospects
!load ../Schemas/marketing_prospects/Tables/marketing_prospects.prospect_address.sql;
!load ../Schemas/marketing_prospects/Tables/marketing_prospects.unverified_acxiom_prospect_address.sql;

--marketplace_stage
!load ../Schemas/marketplace_stage/Tables/marketplace_stage.dbo__account.sql;
!load ../Schemas/marketplace_stage/Tables/marketplace_stage.dbo__inf_members_final.sql;

--messagecenter_stage
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__message_headers.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__responses.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__messages.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__worklist.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__message_status.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__representatives.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__message_category.sql;
!load ../Schemas/messagecenter_stage/Tables/messagecenter_stage.dbo__headers.sql;

--member
!load ../Schemas/member/Tables/member.qualtrics_survey_response.sql;
!load ../Schemas/member/Tables/member.member_preferences.sql;
!load ../Schemas/member/Tables/member.carrot_fertility_data.sql;
!load ../Schemas/member/Tables/member.dhs_chc_data.sql;
!load ../Schemas/member/Tables/member.empi_daily_global.sql;
!load ../Schemas/member/Tables/member.hha_caregiver.sql;
!load ../Schemas/member/Tables/member.hha_evv_visit.sql;
!load ../Schemas/member/Tables/member.hha_provider.sql;
!load ../Schemas/member/Tables/member.holon_gap_resp_data.sql;
!load ../Schemas/member/Tables/member.wex_representative_interactions.sql;
!load ../Schemas/member/Tables/member.wellbe_engagement_report.sql;
!load ../Schemas/member/Tables/member.inspira_subscriber_fsa.sql;

--member_communications
!load ../Schemas/member_communications/Tables/member_communications.pnf_contact_history_detail.sql;

--network
!load ../Schemas/network/Tables/network.simplify_plan_package.sql;
!load ../Schemas/network/Tables/network.bpl_rider_network_crosswalk.sql;
!load ../Schemas/network/Tables/network.lob_plan_type.sql;

--plan
!load ../Schemas/plan/Tables/plan.caa_d6_summary.sql;
!load ../Schemas/plan/Tables/plan.caa_main.sql;
!load ../Schemas/plan/Tables/plan.caa_summary.sql;

--pricing
!load ../Schemas/pricing/Tables/pricing.billing_code_lkp.sql;
!load ../Schemas/pricing/Tables/pricing.billing_code_type.sql;
!load ../Schemas/pricing/Tables/pricing.cigna_url.sql;
!load ../Schemas/pricing/Tables/pricing.inpatient_fee_schedule.sql;
!load ../Schemas/pricing/Tables/pricing.location.sql;
!load ../Schemas/pricing/Tables/pricing.plan_info.sql;
!load ../Schemas/pricing/Tables/pricing.practitioner_fee_schedule.sql;
!load ../Schemas/pricing/Tables/pricing.schedule_type.sql;
!load ../Schemas/pricing/Tables/pricing.segment.sql;
!load ../Schemas/pricing/Tables/pricing.healthsparq_product_code_crosswalk.sql;
!load ../Schemas/pricing/Tables/pricing.healthsparq_issuer_regions.sql;
!load ../Schemas/pricing/Tables/pricing.healthsparq_shoppable_services.sql;
!load ../Schemas/pricing/Tables/pricing.healthsparq_oon_inpatient_allowed_amount.sql;
!load ../Schemas/pricing/Tables/pricing.outpatient_fee_schedule.sql;

--provider
!load ../Schemas/provider/Tables/provider.healthplan_id_xwalk.sql;
!load ../Schemas/provider/Tables/provider.provider_online_cosmos_sync_deletes.sql;
!load ../Schemas/provider/Tables/provider.provider_online_cosmos_sync.sql;
!load ../Schemas/provider/Tables/provider.prv414_raw.sql;
!load ../Schemas/provider/Tables/provider.prv430.sql;
!load ../Schemas/provider/Tables/provider.UPMC_Cancer_Center_Ancillary.sql;
!load ../Schemas/provider/Tables/provider.UPMC_For_Kids.sql;
!load ../Schemas/provider/Tables/provider.UPMC_For_Life.sql;
!load ../Schemas/provider/Tables/provider.UPMC_For_You.sql;
!load ../Schemas/provider/Tables/provider.UPMC_Medicare_Silver_Sneakers_YMCA.sql;
!load ../Schemas/provider/Tables/provider.UPMC_Medicare_Silver_Sneakers.sql;
!load ../Schemas/provider/Tables/provider.staging_filekyruusproviderurls.sql;

--quality
!load ../Schemas/quality/Tables/quality.ccd_control.sql;
!load ../Schemas/quality/Tables/quality.raw_xml.sql;

--virtual_health_stage
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.eav_assessment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.eav_assessment_ext.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.user.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_form.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator_departments.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_data.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_data_layouts.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.attestation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.authorizations.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.care_team.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.care_team_history.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_caremanager_attributes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_departments.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_languages.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_lob.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_plans.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_roles.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_service_areas.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_service_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_supervisors.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator_credentials.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator_mode.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator_roles.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.administrator_service_areas.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.api_form_version.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.api_form_version_alias.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.appeal_status_reasons.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.appeal_status_reasons_to_appeal_overall_determination.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_export_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_form_version.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assessment_form_version_alias.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_distance_matrix_call_log.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_holding_tank.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_profile.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_profile_language.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_profile_lobs.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_profile_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_profile_roles.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_queue_launch_log.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_threshold_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_ws_care_manager.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_holding_tank_assignment_pathway.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_pathway_assignment_profile.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.assignment_ws_care_manager_assignment_profile.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.authorization_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.authorizations_log.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.calendar.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.care_team_history_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.caremanager_caseload.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_isp_rug_costlimit.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_isp_rug_service.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_isp_stcw_category_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_api.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_association.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_credentials.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_email_log.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_import_active_list.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_language.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_notes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_notes_addendum.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_npi.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_pfin.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_roles.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_service_area.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_service_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_service_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_specialization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider_state_id.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cccd_codes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cccd_filemap.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cccd_map_immuno.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_careprovider.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_encounter.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_family_member_condition.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_form.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_guardian.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_habit.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_hospitalization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_hospitalization_source.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_hospitalization_status_discharge.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_commercial.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_commercial_only.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_medicaid.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_medicaid_future.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_medicare.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_insurance_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_lar.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_mailing.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_other_contact.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_parent.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_partner_contact.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_poa.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_procedure.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_race.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_report.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_service.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_service_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_spouse.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_state_data.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_visit.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.contact_list.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.credentials.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.custom_report.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.discharge_lace_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.disenrollment_terminated_insurance.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.enrollment_history.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.hcpcs_codes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.health_summary_tile.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.hedis_report_data.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.historical_data_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_cpt_map_to_cvx.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_cvx.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_map_cvx_vacine.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_map_ndc_to_cvx_mvx.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_map_pr_names_to_cvx_mvx.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.iis_mvx.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.lab.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.lab_flag.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.lab_result.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.lab_unit.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc_class_term.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc_method_typ.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc_property.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc_system.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.loinc_time_aspct.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.ltss_billing_matrix_codes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.ltss_service_category.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.ltss_service_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.membership_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_auth_service_type_settings.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_auth_service_type_settings_request_category.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_auth_service_type_settings_request_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_authorization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_authorization_diagnosis.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_authorization_number.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_authorization_service.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.prior_authorization_service_modifier.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.product_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.provider_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.publication.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.publication_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.qrs_value_sets_to_codes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.risk.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.risk_cdps_weight.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.risk_memo.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.risk_ndc_cdps_map.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.screen.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.screen_access_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.screen_access_rule.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.screen_alternative_url.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.setting_of_care.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.settings_um_permissions.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sig.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_admin_profile_field.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_care_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_criteria.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_criteria_assessment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_criteria_option.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_criteria_rank.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_criteria_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_dynamic_parameters_cache.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_eligibility_verification.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_episode.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_episode_status_from_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_episode_type_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_message.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_performed_log.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_referral.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_referral_sub_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_service_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_service_plan_amount_dynamic.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_task.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_task_auto_resolve_trigger.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_task_department.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_task_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_task_role.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_temporary_member.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_trigger.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_trigger_assessment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_trigger_category.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_trigger_option.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.system_rule_trigger_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.user_external.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.user_screen_access_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.vas_billing_matrix_codes.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.vas_service_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.zip_code_distance.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_additional_sign.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_changelog.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_member_sign.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_problem.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_problem_detail.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_problem_reference.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_problem_reference_need_range.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_problem_reference_tag.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_program.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_activities_and_supports.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_authorizations.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_back_ups.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_emergency_preparedness_plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_emergency_shelter_information.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_member_sign.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_schedule.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_services.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_service_plan_sign.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careplan_sign.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.careprovider.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.city.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.city_county.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_allergy.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_caregiver_contact.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_caremanager.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_cohort.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_communication_preference.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_condition.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_delegated_entity.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_emergency_contact.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_episode_managed_status.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_immunization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_memo.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_prescription.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_prescription_frequency_value.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_prescription_route_value.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_prescription_source.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_prescription_source_value.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_profile_changelog.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_profile_custom_field.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.client_special_needs.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cohort.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_auth_status_reason_cohorts.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_auth_status_reason_settings.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_auth_status_reason_statuses.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_auth_status_relation_settings.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_authorization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_authorization_attachment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_authorization_number.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_authorization_service_detail.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.common_ltss_authorization_service_note_history.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.country.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.county.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cpt_code.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.cpt_code_modifier.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.department.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.designation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.document_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.document_report.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.eav_general_careplan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.eav_general_careplan_ext.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode_changelog.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode_id_queue.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode_owner.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode_referral.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.episode_referral_sub_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.external_doc_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.external_doc_file_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.external_doc_import_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_additional_participant.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_assessment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_assessment_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_consent_to_enroll.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_mode.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_opting_out.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_reason_for_service.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_reason_for_service_complex.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_required_incidence.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interaction_verified_identity.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.interactions.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.language.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.letter_correspondence.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.letters_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.letters_file_attach.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.letters_template.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.letters_template_cover_page_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.lob.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.plan.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.plan_waiver.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.postal_code.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.primary_participant.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.primary_risk_score_values.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.region.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.roles.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_area.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_description_activity_link.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_description_service_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_description_service_unit.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_location.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_location_service_area.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_location_service_description.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_location_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.service_plan_reference.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_outcome.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_outcome_tag.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_reason_for_service_category.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_reason_for_service_sub_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_reason_for_service_sub_type_tag.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_reason_for_service_type.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interaction_reason_for_service_type_tag.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_interactions_reasons.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.sp_profile_custom_field_setting.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.special_needs.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.specialization.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.supervisor.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_attachment.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_memo.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_related_source.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_relation.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_standard_import_file.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.task_templates.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.termination_reason.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.unit_term.sql;
!load ../Schemas/virtual_health_stage/Tables/virtual_health_stage.user_log_ins_history.sql;





--evolve_crm
!load ../Schemas/evolve_crm/Tables/evolve_crm.automatic_membership.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.campaign_history_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.campaign_report_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.event_data_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.event_rsvp_data_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.lead_data_profile_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.repdata_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.notes_export.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.upmc_genesys_log.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.member_window_detail.sql;
!load ../Schemas/evolve_crm/Tables/evolve_crm.aep_lead_nurturing.sql;

--tcscompdb_stage
!load ../Schemas/tcscompdb_stage/Tables/tcscompdb_stage.tzcs_ecit_item.sql;
!load ../Schemas/tcscompdb_stage/Tables/tcscompdb_stage.tzcs_tmrv_revisions.sql;
!load ../Schemas/tcscompdb_stage/Tables/tcscompdb_stage.tzcs_itac_activity.sql;
!load ../Schemas/tcscompdb_stage/Tables/tcscompdb_stage.tzcs_itlc_location.sql;
!load ../Schemas/tcscompdb_stage/Tables/tcscompdb_stage.tzcs_ecev_corr_event.sql;
--edi_edge_stage
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaimsdetail_submitted.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaimsdetail_submitted_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaimsdetail_submitted_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_filtered.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_filtered_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_filtered_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_interim_bills_submitted.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_interim_bills_submitted_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_interim_bills_submitted_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_status.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_status_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_status_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_submitted.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_submitted_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__acaclaims_submitted_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__aca_pharmacystatus.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__aca_pharmacystatus_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__aca_pharmacy_submitted.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__aca_pharmacy_submitted_2022.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__aca_pharmacy_submitted_2023.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__invalid_cpt.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__invalid_diags.sql ;
!load ../Schemas/edi_edge_stage/Tables/edi_edge_stage.gpsupport__invalid_modifiers.sql ;
--encounter_data_management_reportedmdb_stage
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheader.sql ; ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderadjustmentcode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderambulancecertificationdetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercn1.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercobamount.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercobpayer.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercr3.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadercrccode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderdate.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderdentaltoothstatus.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderflag.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderhcp.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderk3.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadermember.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheadernte.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderprovider.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderpwk.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimheaderreferenceinformation.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimline.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlineadjustmentcode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlineambulancecertificationdetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinecn1.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinecobamount.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinecr3.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinecrccode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinedate.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinedentaltoothsurfacecode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlineedit.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinehcp.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinek3.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinente.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlineprovider.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinepwk.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimlinereferenceinformation.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimsegmentextension.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__claimsegmentoutputresult.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__duplicateclaimresult.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.cache__scrubresult.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.encounter__batch.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__batchfileoutbound.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__batchfileresponsedetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__batchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__claimdataaudit.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__scrublog.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.history__voidmustmatchoriginalhistoricalclaiminfo.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277cabillingprovider.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277capatient.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277caresponse.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277caserviceline.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277drabillingprovider.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277drapatient.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277draresponse.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277draserviceline.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277pdetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277psummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277udetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__277usummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__999contextelementerror.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__999contextsegmenterror.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__999errorclaim.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__999responsedetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__999responsesummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__cmsrejectionsummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__crencounterdetail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__crencounterstatuscode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__crencountersummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao001detail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao001summary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao002detail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao002error.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao002summary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao004detail.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao004responsefile.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__mao004summary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responseclaim.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responseclaimarchive.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responseclaimstatuscode.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responseclaimstatuscodearchive.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__responsefile.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__rjrejectionsummary.sql ;
!load ../Schemas/encounter_data_management_reportedmdb_stage/Tables/encounter_data_management_reportedmdb_stage.response__ta1summary.sql ;

--CoreEDM
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheader.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderadjustmentcode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderambulancecertificationdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercn1.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercobamount.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercobpayer.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercr3.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadercrccode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderdate.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderdentaltoothstatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderflag.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderhcp.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderk3.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadermember.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheadernte.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderprovider.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderpwk.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimheaderreferenceinformation.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimline.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlineadjustmentcode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlineambulancecertificationdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinecn1.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinecobamount.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinecr3.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinecrccode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinedate.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinedentaltoothsurfacecode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlineedit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinehcp.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinek3.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinente.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlineprovider.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinepwk.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimlinereferenceinformation.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimsegmentextension.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__claimsegmentoutputresult.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__duplicateclaimresult.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.cache__scrubresult.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__adjdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__adjdetailerrorcode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__batch.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__batchformtype.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__claimedituserdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__excludebrscrubforschedule.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__schedule.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__scheduleclaim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__scheduleformtype.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__schedulescrublist.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__schedulesource.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__scheduletransactiontype.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.encounter__telemetrydata.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__batchfileclaimdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__batchfileoutbound.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__batchfileresponse.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__batchfileresponsedetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__batchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claimdataaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claimsegmentpositiondetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claimseriesdisposition.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claimseriessubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__claimsplitingcrosswalk.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__configurationaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__donotsubmitclaimaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__editmedicalclaimdetailsaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__enrollmentscrublog.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimbatchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimduplicatecheck.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimlinebatchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimscrublog.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimsubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__medicalclaimsubmissionaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__membermaster.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__memberprofilebatchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__memberprofilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__scrublog.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__submission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__supplementaldiagclaimbatchfilesubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__supplementaldiagclaimscrublog.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__supplementaldiagclaimsubmission.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.history__supplementaldiagclaimsubmissionaudit.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277cabillingprovider.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277cabillingproviderstatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277cabillingproviderstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277capatient.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277capatientclaim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277capatientclaimstatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277capatientclaimstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caresponse.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caresponsestatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caresponsestatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caserviceline.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caservicelinestatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277caservicelinestatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drabillingprovider.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drabillingproviderstatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drabillingproviderstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drapatient.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drapatientclaim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drapatientclaimstatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277drapatientclaimstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draresponse.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draresponsestatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draresponsestatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draserviceline.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draservicelinestatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277draservicelinestatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277uclaim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277uclaimprovider.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277uclaimstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277uclaimsubscriber.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277userviceline.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277uservicelinestatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__277utransactiongroup.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999acknowledgementerror.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999acknowledgementgroup.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999acknowledgementtssyntaxerrormapping.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999acknowlegementts.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999contextelementerror.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999contextsegmenterror.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999dataelementnote.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__999errorclaim.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__crencounter.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__crencounterdetail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__crencounterstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao001detail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao001header.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao001trailer.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao002detail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao002error.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao002header.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao002trailer.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao004detail.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao004header.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__mao004trailer.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__responsefile.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.response__ta1segmentacknowledgement.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.config__encounterresponsestatus.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.config__claimstatuscode.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.config__scrub.sql ;
!load ../Schemas/encounter_data_management_coreedmdb_stage/Tables/encounter_data_management_coreedmdb_stage.config__claimstatuscodelevel.sql ;

--encounter_data_management_edmstagingloaderdb_stage
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.archive__claimcodes.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.archive__claimlines.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.archive__claimprovidertypes.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.archive__claims.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimcodes.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimcodes_all.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimlines.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimlines_all.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimprovidertypes.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claimprovidertypes_all.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claims.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__claims_all.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__edm_exclude_claim_filter.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__edm_include_claim_filter.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__membercobpayers.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__memberplans.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__members.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__provideraddresses.sql ;
!load ../Schemas/encounter_data_management_edmstagingloaderdb_stage/Tables/encounter_data_management_edmstagingloaderdb_stage.load__providers.sql ;
-- genesys
!load ../Schemas/genesys_stage/Tables/genesys_stage.biteam__gen_campaign_results_cotiviti.sql;
!load ../Schemas/genesys_stage/Tables/genesys_stage.biteam__ivr_redeterm_cotiviti.sql;
!load ../Schemas/genesys_stage/Tables/genesys_stage.biteam__blasteroptout.sql;
!load ../Schemas/genesys_stage/Tables/genesys_stage.biteam__gen_campaign_results_ma_appt.sql;
--lab
!load ../Schemas/lab/Tables/lab.epic_mars.sql;
--piwik
!load ../Schemas/piwik/Tables/piwik.daily_events.sql;
!load ../Schemas/piwik/Tables/piwik.daily_sessions.sql;
----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--claim
!load ../Schemas/claim/Functions/claim.fxn_sqlldr_zoned_to_number.sqlproc;
--cms
!load ../Schemas/cms/Functions/cms.fxn_overpunch.sqlproc;
--util
!load ../Schemas/util/Functions/util.fxn_array_hash.sqlproc;

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--assessment
!load ../Schemas/assessment/Views/assessment.helios_assessment_data_vw.sql;
!load ../Schemas/assessment/Views/assessment.helios_assessment_form_vw.sql;
!load ../Schemas/assessment/Views/assessment.helios_client_vw.sql;
!load ../Schemas/assessment/Views/assessment.helios_eav_assessment_vw.sql;
!load ../Schemas/assessment/Views/assessment.helios_eav_assessment_ext_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_has_assessmentresponses_id_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_scan_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_scan_current_cms_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_scan_backdate_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_scan_current_cms_backdate_vw.sql;
!load ../Schemas/assessment/Views/assessment.snp_scan_current_cms_backdate_invalid_vw.sql;


--claim

!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_det_current_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_hdr_current_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_tlr_current_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_det_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_hdr_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_cvs_stoploss_tlr_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_det_current_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_hdr_current_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_tlr_current_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_det_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_hdr_vw.sql;
!load ../Schemas/claim/Views/claim.cvs_stoploss_tlr_vw.sql;
!load ../Schemas/claim/Views/claim.drug_event_cms_ddps_return_vw.sql;
!load ../Schemas/claim/Views/claim.esi_claim_record_adj_f14_vw.sql;
!load ../Schemas/claim/Views/claim.esi_claim_record_daily_vw.sql;
!load ../Schemas/claim/Views/claim.esi_claim_record_weekly_vw.sql;
!load ../Schemas/claim/Views/claim.esi_spe384_current_vw.sql;
!load ../Schemas/claim/Views/claim.esi_spe384_new_gcn_codes_vw.sql;
!load ../Schemas/claim/Views/claim.cotiviti_ppm_data_hdr_vw.sql;
!load ../Schemas/claim/Views/claim.cotiviti_ppm_data_det_vw.sql;
!load ../Schemas/claim/Views/claim.cotiviti_ppm_data_tlr_vw.sql;
!load ../Schemas/claim/Views/claim.pharmacy_hra_hia_audit_vw.sql;
!load ../Schemas/claim/Views/claim.stage_nadac_pricing_vw.sql;
!load ../Schemas/claim/Views/claim.wex_data_final_vw.sql;
!load ../Schemas/claim/Views/claim.spanish_not_covered_reason_vw.sql;
!load ../Schemas/claim/Views/claim.rx_carve_out_somerset_vw.sql;
!load ../Schemas/claim/Views/claim.proact_stoploss_claims_current_vw.sql;
!load ../Schemas/claim/Views/claim.proact_stoploss_claims_vw.sql;
!load ../Schemas/claim/Views/claim.cmu_aetna_stoploss_vw.sql;

--cms

!load ../Schemas/cms/Views/cms.mmr_vw_pre062026.sql;
!load ../Schemas/cms/Views/cms.mmr_vw_current.sql;
!load ../Schemas/cms/Views/cms.mmr_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_header_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v21_ptc_beg_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v22_ptc_cf_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v22_ptc_d_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v24_ptc_j_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v24_ptc_l_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v22_ptc_k_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v23_ptc_i_vw.sql;
!load ../Schemas/cms/Views/cms.mor_hcc_v28_ptc_m_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_header_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_ptd_2_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_ptd_4_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_ptd_5_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_ptd_6_vw.sql;
!load ../Schemas/cms/Views/cms.mor_rxhcc_ptd_7_vw.sql;
!load ../Schemas/cms/Views/cms.mao_001_detail_vw.sql;
!load ../Schemas/cms/Views/cms.mao_001_header_vw.sql;
!load ../Schemas/cms/Views/cms.mao_001_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.mao_002_detail_vw.sql;
!load ../Schemas/cms/Views/cms.mao_002_header_vw.sql;
!load ../Schemas/cms/Views/cms.mao_002_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.mao_004_detail_vw.sql;
!load ../Schemas/cms/Views/cms.mao_004_header_vw.sql;
!load ../Schemas/cms/Views/cms.mao_004_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.transaction_reply_vw.sql;
!load ../Schemas/cms/Views/cms.late_enrollment_penalty_header_vw.sql;
!load ../Schemas/cms/Views/cms.late_enrollment_penalty_detail_vw.sql;
!load ../Schemas/cms/Views/cms.late_enrollment_penalty_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_premium_withholding_report_header_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_premium_withholding_report_detail_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_premium_withholding_report_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.batch_completion_status_summary_counts_vw.sql;
!load ../Schemas/cms/Views/cms.batch_completion_status_summary_failed_detail_vw.sql;
!load ../Schemas/cms/Views/cms.batch_completion_status_summary_header_vw.sql;
!load ../Schemas/cms/Views/cms.batch_completion_status_summary_processing_vw.sql;
!load ../Schemas/cms/Views/cms.lis_history_header_vw.sql;
!load ../Schemas/cms/Views/cms.lis_history_detail_vw.sql;
!load ../Schemas/cms/Views/cms.lis_history_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.full_enrollment_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_norx_header_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_norx_detail_vw.sql;
!load ../Schemas/cms/Views/cms.monthly_norx_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.lis_part_d_premium_vw.sql;
!load ../Schemas/cms/Views/cms.ma_full_dual_auto_assignment_notification_header_vw.sql;
!load ../Schemas/cms/Views/cms.ma_full_dual_auto_assignment_notification_detail_vw.sql;
!load ../Schemas/cms/Views/cms.ma_full_dual_auto_assignment_notification_trailer_vw.sql;
!load ../Schemas/cms/Views/cms.medicare_advantage_medicaid_status_header_vw.sql;
!load ../Schemas/cms/Views/cms.medicare_advantage_medicaid_status_identification_vw.sql;
!load ../Schemas/cms/Views/cms.medicare_advantage_medicaid_status_detail_vw.sql;
!load ../Schemas/cms/Views/cms.medicare_advantage_medicaid_status_trailer_vw.sql;
!load ../schemas/cms/Views/cms.monthly_medicare_secondary_payer_part_c_header_vw.sql;
!load ../schemas/cms/Views/cms.monthly_medicare_secondary_payer_part_c_primary_vw.sql;
!load ../schemas/cms/Views/cms.monthly_medicare_secondary_payer_part_c_detail_vw.sql;
!load ../schemas/cms/Views/cms.monthly_medicare_secondary_payer_part_c_trailer_vw.sql;
!load ../schemas/cms/Views/cms.part_b_claims_type_one_vw.sql;
!load ../schemas/cms/Views/cms.part_b_claims_type_two_vw.sql;
!load ../schemas/cms/Views/cms.agent_broker_compensation_report_detail_vw.sql;
!load ../schemas/cms/Views/cms.agent_broker_compensation_report_trailer_vw.sql;
!load ../schemas/cms/Views/cms.loss_of_subsidy_vw.sql;
!load ../schemas/cms/Views/cms.no_premium_due_vw.sql;
!load ../schemas/cms/Views/cms.annual_cob_ohi_full_replacement_detail_vw.sql;
!load ../schemas/cms/Views/cms.annual_cob_ohi_full_replacement_primary_vw.sql;
!load ../schemas/cms/Views/cms.annual_cob_ohi_full_replacement_supplemental_vw.sql;
!load ../schemas/cms/Views/cms.cob_ohi_annual_summary_header_vw.sql;
!load ../schemas/cms/Views/cms.cob_ohi_annual_summary_subheader_vw.sql;
!load ../schemas/cms/Views/cms.cob_ohi_annual_summary_column_header_vw.sql;
!load ../schemas/cms/Views/cms.cob_ohi_annual_summary_detail_vw.sql;
!load ../schemas/cms/Views/cms.cob_ohi_annual_summary_total_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_bhd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_btr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_hdr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_rpt_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_bhd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_btr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_hdr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_err_sum_rpt_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_chd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_ctr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_det_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_rhd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_rtr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_chd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_ctr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_det_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_rhd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_41cov_rtr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_chd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_ctr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_det_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_phd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_ptr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_chd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_ctr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_det_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_phd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_42cov_ptr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_chd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_ctr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_det_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_shd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_str_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_chd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_ctr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_det_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_shd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_43cov_str_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_chd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_ctr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_det_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_phd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_ptr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_chd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_ctr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_det_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_phd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40cov_ptr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_chd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_ctr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_det_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_phd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_ptr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_chd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_ctr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_det_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_phd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_40otc_ptr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_bhd_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_bhd_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_btr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_btr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_hdr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_hdr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_tlr_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_ret_tlr_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_cov_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_cov_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_otc_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_otc_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_return_post2025_vw.sql;
!load ../schemas/cms/Views/cms.drug_event_cms_ddps_return_vw.sql;

--dhs
!load ../Schemas/dhs/Views/dhs.medicaid_pend_enroll_vw.sql; 

--logdata
!load ../Schemas/logdata/Views/util.ADF_DB_EXTRACT_PIPELINE_LOGGING_VW.sql;
!load ../Schemas/logdata/Views/util.ADF_IDAP_LAKE_PIPELINE_LOGGING_VW.sql;

--marketing_prospects
!load ../Schemas/marketing_prospects/Views/marketing_prospects.prospect_address_smarty_select_vw.sql;

--member
!load ../Schemas/member/Views/member.Qualtrics_Survey_Responses_vw.sql;
!load ../Schemas/member/Views/member.member_preferences_current_row_vw.sql;
!load ../Schemas/member/Views/member.member_preferences_json_vw.sql;
!load ../Schemas/member/Views/member.member_preferences_vw.sql;
!load ../Schemas/member/Views/member.member_preferences_addresses_vw.sql;
!load ../Schemas/member/Views/member.member_preferences_campaigns_vw.sql;
!load ../Schemas/member/Views/member.inspira_subscriber_fsa_header_record_vw.sql;
!load ../Schemas/member/Views/member.inspira_subscriber_fsa_detail_record_vw.sql;
!load ../Schemas/member/Views/member.inspira_subscriber_fsa_trailer_record_vw.sql;
--member_communications
!load ../Schemas/member_communications/Views/member_communications.tbl_sp_email_responses_vw.sql;
!load ../Schemas/member_communications/Views/member_communications.tbl_mp_sms_responses_vw.sql;
!load ../Schemas/member_communications/Views/member_communications.mktg_campaign_contact_history_sfmc_vw.sql;
!load ../Schemas/member_communications/Views/member_communications.mktg_campaign_contact_history_unica_vw.sql;


--network
!load ../Schemas/network/Views/network.simplify_plan_package_current_row_vw.sql;
!load ../Schemas/network/Views/network.simplify_plan_package_vw.sql;
!load ../Schemas/network/Views/network.simplify_plan_package_flatten_vw.sql;
!load ../Schemas/network/Views/network.simplify_benefit_review_vw.sql;
!load ../Schemas/network/Views/network.simplify_cascading_cost_share_vw.sql;
!load ../Schemas/network/Views/network.simplify_general_cost_share_vw.sql;
!load ../Schemas/network/Views/network.simplify_network_vw.sql;
!load ../Schemas/network/Views/network.simplify_network_flatten_vw.sql;
!load ../Schemas/network/Views/network.simplify_product_rules_vw.sql;
!load ../Schemas/network/Views/network.simplify_standard_services_vw.sql;
!load ../Schemas/network/Views/network.simplify_innetwork_flatten_vw.sql;
!load ../Schemas/network/Views/network.simplify_outnetwork_flatten_vw.sql;

--premium
!load ../Schemas/premium/Views/premium.dts_premiums_detail_final_dnv_vw.sql;

--provider
!load ../Schemas/provider/Views/provider.affiliations_non_participant_vw.sql;
!load ../Schemas/provider/Views/provider.contract_non_participant_vw.sql;
!load ../Schemas/provider/Views/provider.directory_non_participant_vw.sql;
!load ../Schemas/provider/Views/provider.legal_address_relationship_vw.sql;
!load ../Schemas/provider/Views/provider.prv414_vw.sql;
!load ../Schemas/provider/Views/provider.lexisnexis_attestationlocationsummary_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_attestationsummary_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_officemanagerlocations_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_payerproviderhospitalaffiliation_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_payerproviderlocationgroups_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_payerproviderlocationplans_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_payerproviderspecialties_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_practicelocations_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_providerinfo_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_providerlanguages_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_providerlocationlanguages_vw.sql
!load ../Schemas/provider/Views/provider.lexisnexis_providerschool_vw.sql;
!load ../Schemas/provider/Views/provider.specialty_nucc_vw.sql;
!load ../Schemas/provider/Views/provider.facility_whitelist_code_key_vw.sql;
!load ../Schemas/provider/Views/provider.facility_service_whitelist_vw.sql;


--reference
!load ../Schemas/reference/Views/reference.proc_code_combo_vw.sql;

--lab
!load ../Schemas/lab/Views/lab.epic_mars_historical_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/StoredProcedures/util.spu_file_loader.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_file_loader_filename_only.sqlproc;
!load ../Schemas/util/StoredProcedures/util.SPU_GENERIC_COPY_INTO.sqlproc;
!load ../Schemas/util/StoredProcedures/util.SPU_COPY_INTO_TABLE_IDAP_LAKE.sqlproc;
!load ../Schemas/util/StoredProcedures/util.SPU_IDAP_LAKE_INCREMENTAL_FILE_LOADER.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_build_query.sqlproc;
!load ../Schemas/util/StoredProcedures/util.update_adf_oracle_filename_load_history.sqlproc;
!load ../Schemas/util/StoredProcedures/util.update_zenoss_history_table.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_sqldb_copy_into.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_file_load_hpds_datalake.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_create_file_format.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_infer_file_ddl.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_mysqldb_copy_into.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_adls_files_table_refresh.sqlproc;


--claim
!load ../Schemas/claim/StoredProcedures/claim.spu_load_medicaid_nadac.sqlproc;
!load ../Schemas/claim/StoredProcedures/claim.spu_load_greenback_rx_plan_design.sqlproc;
!load ../Schemas/claim/StoredProcedures/claim.spu_load_greenback_rx_history.sqlproc;


--cms
!load ../Schemas/cms/StoredProcedures/cms.spu_load_mao01.sqlproc;
!load ../Schemas/cms/StoredProcedures/cms.spu_load_mao02.sqlproc;
!load ../Schemas/cms/StoredProcedures/cms.spu_load_npi.sqlproc;

--application_events
!load ../Schemas/application_events/StoredProcedures/application_events.spu_Load_apimlogs.sqlproc;
!load ../Schemas/application_events/StoredProcedures/application_events.spu_Load_sms_message_logs.sqlproc;
!load ../Schemas/application_events/StoredProcedures/application_events.spu_Load_member_notifications.sqlproc;
!load ../Schemas/application_events/StoredProcedures/application_events.spu_Load_member_notificationerrors.sqlproc;
!load ../Schemas/application_events/StoredProcedures/application_events.spu_Load_authorizations.sqlproc;

--marketing_prospects
!load ../Schemas/marketing_prospects/StoredProcedures/marketing_prospects.spu_load_prospect_address.sqlproc;
!load ../Schemas/marketing_prospects/StoredProcedures/marketing_prospects.spu_load_unverified_acxiom_prospect_address.sqlproc;

--quality (procedures)
!load ../Schemas/quality/StoredProcedures/quality.spu_insert_ccd_control.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_insert_raw_xml.sqlproc;
!load ../Schemas/quality/StoredProcedures/quality.spu_parse_clearsense_filename.sqlproc;

--provider
!load ../Schemas/provider/StoredProcedures/provider.spu_load_cosmos_deletes_json.sqlproc;
!load ../Schemas/provider/StoredProcedures/provider.spu_load_cosmos_sync_json.sqlproc;
!load ../Schemas/provider/StoredProcedures/provider.spu_load_staging_file_kyruus_provider_urls.sqlproc;

--member
!load ../Schemas/member/StoredProcedures/member.spu_load_member_preferences.sqlproc;

--network
!load ../Schemas/network/StoredProcedures/network.spu_load_bpl_rider_network_crosswalk.sqlproc;
!load ../Schemas/network/StoredProcedures/network.spu_load_lob_plan_type.sqlproc;

--acxiomdb
!load ../Schemas/acxiomdb/StoredProcedures/acxiomdb.create_latest_prospects_view_1865.sqlproc;
!load ../Schemas/acxiomdb/StoredProcedures/acxiomdb.create_latest_prospects_view_66plus.sqlproc;
!load ../Schemas/acxiomdb/StoredProcedures/acxiomdb.spu_load_acxiom_data_table_create.sqlproc;
--piwik
!load ../Schemas/piwik/StoredProcedures/piwik.spu_load_daily_events_sessions.sqlproc;
----------------------------------------------------------------------------------------------------------
-- PIPES
----------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------
-- CODE REVIEW SCRIPT
----------------------------------------------------------------------------------------------------------
--!load ../../ValidationScripts/CodeReview.sql;


!exit
