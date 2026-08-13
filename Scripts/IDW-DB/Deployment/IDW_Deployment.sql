/*----------------------------------------------------------------------------------------------------------
This is the master deployment procedure for the database. Only the items in this script will be 
deployed to the target database.

Connection option example for deployment via SnowSQL:
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
!load ../DatabaseLevelObjects/Schemas/adl_prod.schema.sql;
!load ../DatabaseLevelObjects/Schemas/adl_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/ccadmin.schema.sql;
!load ../DatabaseLevelObjects/Schemas/dhs_edi.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_load.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_shared.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_usr_tab.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_rpt.schema.sql;
!load ../DatabaseLevelObjects/Schemas/engagement.schema.sql;
!load ../DatabaseLevelObjects/Schemas/gpsupport.schema.sql;
!load ../DatabaseLevelObjects/Schemas/hcc_user.schema.sql;
!load ../DatabaseLevelObjects/Schemas/hedis_common.schema.sql;
!load ../DatabaseLevelObjects/Schemas/idfs.schema.sql;
!load ../DatabaseLevelObjects/Schemas/logdata.schema.sql;
!load ../DatabaseLevelObjects/Schemas/marketing.schema.sql;
!load ../DatabaseLevelObjects/Schemas/medhok.schema.sql;
!load ../DatabaseLevelObjects/Schemas/mkt_cmtdb.schema.sql;
!load ../DatabaseLevelObjects/Schemas/mkt_integration.schema.sql;
!load ../DatabaseLevelObjects/Schemas/myhealth.schema.sql;
!load ../DatabaseLevelObjects/Schemas/saca.schema.sql;
!load ../DatabaseLevelObjects/Schemas/ss_finance.schema.sql;
!load ../DatabaseLevelObjects/Schemas/staging.schema.sql;
!load ../DatabaseLevelObjects/Schemas/upmc_immediate.schema.sql;
!load ../DatabaseLevelObjects/Schemas/upmc_tab.schema.sql;
!load ../DatabaseLevelObjects/Schemas/util.schema.sql;
!load ../DatabaseLevelObjects/Schemas/uwpr.schema.sql;



----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
--util

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--adl_prod
!load ../Schemas/adl_prod/FileFormats/adl_prod.info_edm_discharge_master_file_format.sql;
!load ../Schemas/adl_prod/FileFormats/adl_prod.info_edm_hospital_census_rpt_file_format.sql;

--edw_usr_tab
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.completion_factors_cc_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.completion_factors_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.dwh_plan_map_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.medical_home_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.drug_event_cms_ddps_return_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.esi_claim_record_daily_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.mmr_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.cactus_facilities_file_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.cactus_facilities_service_file_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.cactus_hosp_priv_file_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.cactus_provider_file_file_format.sql;
!load ../Schemas/edw_usr_tab/FileFormats/edw_usr_tab.lishist_vw_file_format.sql;

--engagement
!load ../Schemas/engagement/FileFormats/engagement.db_extract_csv_file_format.sql;

--mkt_integration
!load ../Schemas/mkt_integration/FileFormats/mkt_integration.odcompletedsurveyresponse_file_format.sql;

--saca
!load ../Schemas/saca/FileFormats/saca.gs_and_sc_all_status_vw_file_format.sql;


--util
!load ../Schemas/util/FileFormats/util.db_extract_file_format.sql;

----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--none to run
----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--adl_prod


--edw_usr_tab


--edwrpt
!load ../Schemas/edwrpt/Tables/edw_rpt.fss_extract.sql;


--logdata

--mkt_integration


--saca


--edw_shared

--util


--hcc_user

--idfs

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--none to run

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--adl_prod
!load ../Schemas/adl_prod/Views/adl_prod.events_library.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_rx_hist.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_kpi_fss_milliman.sql;
!load ../Schemas/adl_prod/Views/adl_prod.ref_conditions_map.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_procedure_master_final.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_procedure_member_mo.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_discharge_master.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_discharge_master_mtrn.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_discharge_master_nicu.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_discharge_master.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_hospital_census_rpt.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_maternity_hist.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_hit.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_hit_cc_date.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_ceg_crosswalk.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_chc_kpi_master.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_hospice_mc_history.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_household_id.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_kpi_member.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_kpi_revenue.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_mds_master_hp.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_primary_ins.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_sba_oncology_hospice_dates.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_sba_oncology_medical_claims.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_sba_oncology_member_eligibility.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_sba_oncology_pharmacy_claims.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_strat_history.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_dwoao_claims_hist.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_fss_extract_oao.sql;

!load ../Schemas/adl_prod/Views/adl_prod.info_edm_mbr_rx_coverage.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_cm_2022.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_cm_2023.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_cm_2024.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_ma_2022.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_ma_2023.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_ma_2024.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_mc_2022.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_mc_2023.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_dxcg_mc_2024.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_health_acuity.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_dwoao_auth_claims.sql;
!load ../Schemas/adl_prod/Views/adl_prod.ref_no_rx_plans.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_cpr_daily.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_sched_hist.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_pem.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_mcp_categories.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_mbr_enrl_curr.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_episode_hist.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_high_risk_maternity.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_edm_dexa_appt.sql;
!load ../Schemas/adl_prod/Views/adl_prod.episode_hist_idfs.sql;
!load ../Schemas/adl_prod/Views/adl_prod.ide_wellbe_eligible_hpnet_vw.sql;
!load ../Schemas/adl_prod/Views/adl_prod.info_rx_medrec_flag.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_ma_call_success.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_call_success_ma_gaps.sql;
!load ../Schemas/adl_prod/Views/adl_prod.mod_call_success.sql;
!load ../Schemas/adl_prod/Views/adl_prod.ref_rx_rebates.sql;


--adl_stage
!load ../Schemas/adl_stage/Views/adl_stage.ide_wellbe_eligible_vw.sql;

--ccadmin
!load ../Schemas/ccadmin/Views/ccadmin.pcmh_sharedsavings_practices.sql;


--dhs_edi
!load ../Schemas/dhs_edi/Views/dhs_edi.dhs834_daily_detail.sql;
!load ../Schemas/dhs_edi/Views/dhs_edi.dhs834_daily_detail_cob.sql;
!load ../Schemas/dhs_edi/Views/dhs_edi.dhs834_daily_detail_hd.sql;
!load ../Schemas/dhs_edi/Views/dhs_edi.dhs834_daily_header.sql;
!load ../Schemas/dhs_edi/Views/dhs_edi.idw834tbl.sql;


--edw_load
!load ../Schemas/edw_load/Views/edw_load.temp_ma_member_month.sql;

--edw_shared
!load ../Schemas/edw_shared/Views/edw_shared.taxonomy_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.dnv_lob_plan_type_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.gcn_specialty_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.icd_description_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.lob_plan_type_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.location_code_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.mc4_discharge_status_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.mc4_drg_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.npi.sql;
!load ../Schemas/edw_shared/Views/edw_shared.rx_country_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.rx_state_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.service_type_lkp.sql;
!load ../Schemas/edw_shared/Views/edw_shared.stg_hcpcs_level_ii.sql;


--edw_usr_tab
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_vision_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_vision_claims_restricted.sql;


!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_visits_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_combined.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_workhistory.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_servdetail_all.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_combined_reject.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.health_planet_lab_fact_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esc_suppl.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_servdetail_cy_all.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_servdetail_surveillance.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_append_work.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.quest_results_lab_full_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_operatorstatistics.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_claim_record_f14_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_claimline.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_cov_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_ddps_return_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medicaid_newserhist_medical.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_report_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.oim_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.sl_stoploss_history.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_operatorproductivity.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_results_all.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_pendcodes.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_pharmacy_rejects.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_results_cy_all.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_pde_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.q_results_surveillance.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_evv_visit.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_work.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_newserhist_medical.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mmr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_pharmacy_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_pharmacy_bat_rec_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_ante.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ndc_claim_master.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.full_enrollment.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lishist_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_authorization_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medical_home.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.action_rewards_master_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_vision_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_vision_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.action_rewards_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_claim_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medicaid_newserhist_pharmacy.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_file_caqh.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_quest_reject.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_demographics_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_quest_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stg_county_codes_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.in820_shop_ppr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_dental_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_dental_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_notes_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ecoba_claims_hist_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ecoba_duplicate_audit_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.caa_main.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_evv_visit_filtered_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.tpl_chc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mspcobma_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dwoao_premiums_incurred_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dwoao_premium_incurr_detail_1.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mor_v24_edps_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_newserhist_pharmacy.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.wex_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lsc_household_3.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.npi.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stg_skygen_claim.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.caa_summary.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cologuard_claims.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mars_results_lab_lkp_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_ddps_ret_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.in820_ind_det.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.oim_header.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.transaction_reply_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medicaid_newserhist_revenue.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_washington_reject.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.idap_empi_daily_global_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.tivity_partic_report.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_pace.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_file_dhs.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.nva_paid_claim_extract.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_subreport_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_pharmacy_record_f14.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_caregiver_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_act_adjustment_req_intake.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stg_doral_claim.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cc_hia_transactions.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_pace.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.highmark_wellness.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mpwrd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mor_rxhcc_v08.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mars_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_otc_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.highmark_eqt.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_newserhist_revenue.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_captureloginlogout.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.healthsparq_source.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.healthy_frontiers.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_locationplans.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ucci_dental.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.wellness_medical_claims.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_report_master.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mbrid_mrn_xref.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_prior_authorization.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cms_case_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_file_cms.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_esi_claim_record_f14_final.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.agent_broker_comp_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.quest_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_scm_data_audit.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_optum_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pa_hub_test_claims.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dwdnv_premiums_incurred_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cts_encounter.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_lancaster_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.time_and_outcome_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medicaid_newserhist_inpatient.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dhs_chc_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hq2_wellmed_new_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pa_hub_all_eoc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cc_pharmacy_tx.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cavulus_ext.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_mds_data_1.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.in820_shop_det.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mh_cactus_pcp.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_mds_data_2.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_authorization_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_pharmcare_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_heritage_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pahub_user_productivity_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mor_v28_non_esrd.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_affiliation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_nonresponder.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_newserhist_inpatient.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pa_hub_prior_authorizations.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_locationgroups.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_attestation_location.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_cov_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.sl_stoploss.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_otc_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cc_spending_acct_balances.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.health_screening_test_level_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.healthyu_account_balance_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.equitrans_midstream_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cdh_contracts_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_somerset_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.care_connect.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cmu_cvs_stoploss_det.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_practicelocation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mon_valley_claims_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.washington_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.memberothereligibilityall_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_washington_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cavulus_sales_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_taxonomy.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.brain_manager_staging_master.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_hospitalaffiliation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_daily_mbr_enroll.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_workbasket.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_license.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.memberothereligibility_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.caa_d6_summary.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_adjustment_case_details.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_demographics_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_providerspecialties.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_attestation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_file_hms.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cactus_provider_file.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_express_scripts.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_caregiver_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chathamclinic.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.irt_detail.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_provider_loc_lang.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.oasis_empi.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_master.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_npi.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_providerinfo.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_beaver_county.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_beavcnt_finance.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_vision_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_vision_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dha_condition_management.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_providerlanguages.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.m25mddb_key_identifier_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_err_sum_rpt_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dsnp_rx_combo.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.excela_results_lab.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cvs_stoploss_det.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_medschool.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_42cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_enh_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_dea.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.edw_health_screening.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.digital_health_assessment.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.gateway_adm_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medipac_encounter_diagnosis.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.wk_comp_npi_claim_rec_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.user_summary_new.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_locations.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_40cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chathamclinic_member.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_facility.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexdt.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.aetna_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cactus_hosp_priv_file.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.senior_has_demographics_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.edw_flu_all.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.convey_order_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_providerschool.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.omw_report_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mq_yesno.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.chc_weekly_mbr_disenroll.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.truescripts_rx_stoploss.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.kirby_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_geocensus.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cob_file_syrtis_rx.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_hra_hia_audit.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.aetna_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.united_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.apple_health_screening.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.healthyu_debit_utilization_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.facility_nonresponder_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_provider_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_act_adjustment_case_intake.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.wellness_ssn_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medipac_insurance_info.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.plan_benefit_design.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.gateway_rx_dsnp_new_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.gateway_rx_dsnp_new.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_giant_eagle_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medipac_encounter_icd_proc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medipac_encounter_cpt_hcpc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.care_connect_magellan.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.medipac_encounters.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ecoba_claims_stg_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cigna_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_carve_out_somerset.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.aon_health_exchange.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ucci_dental_pa_cyber_claims.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_ddps_ret_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_facility_attestation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.verify_facility.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_43cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_err_sum_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_err_sum_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_err_sum_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.senior_medicare_hq2_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.tivity_pittsburgh_ys.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mor_v24_esrd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cactus_facilities_service_file.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.copd_mc_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.proact_stoploss_claims.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_ddps_ret_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_41cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cactus_facilities_file.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.vbid_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.plan_benefit_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.care_connect_perform.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.completion_factor.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.completion_factor_ma.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.completion_factor_mc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.humana_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lab_kirby_reject.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.humana_dsnp_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.tivity_sewickly_ymca.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_operatorskills.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cigna_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.proc_code_combo.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.completion_factors_cc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_file_batch_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_43cov_shd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_43cov_str_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.amplifon_data.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_41cov_rhd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_41cov_rtr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_idvboard_sanc.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.nations_benefits_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_indexoperator.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.healthyu_non_debit_utilization_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_ddps_ret_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.wk_comp_npi_comp_det_rec_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pahw_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.health_ptnr_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_40cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_40cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stop_loss_threshold.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_42cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_42cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_operator_wb_list.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_otc_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_otc_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cms_err_sum_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cms_err_sum_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_enh_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cmsddps_ret_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_42cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_enh_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_40cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_40cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_42cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_42cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.h6_alternate_address_hist_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_operator.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_enh_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_enh_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_otc_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drug_event_cms_otc_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cmsddps_ret_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.completion_factors.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_43cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_43cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_41cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_41cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40otc_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cmsddps_ret_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cmu_aetna_stoploss.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.in820_shop_hdr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mpwrd_header_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cws_worklist.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.myhealth_at_work_order.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexbt_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexbh.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexbt.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.h6_alternate_address_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexpt_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexph.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexpt.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lsc_script_validation.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mor_hcc_header.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_42cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_42cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.amerihealth_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_42cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_42cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.in820_ind_hdr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stop_loss_domestic_tax_id.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40otc_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40otc_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40otc_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40otc_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40enh_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drgevt_cmsddps_ret_tlr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.drug_event_cms_ddps_ret_tlr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_43cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_43cov_shd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_43cov_str_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexct.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.partdexcluswarn_pexch.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cvs_stoploss_tlr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cvs_stoploss_hdr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40enh_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40enh_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40enh_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_40enh_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_43cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cli_drugevent_cms_43cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.enclarity_collapse.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cmu_cvs_stoploss_hdr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cmu_cvs_stoploss_tlr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.rx_prior_authorization_hold.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.stop_loss_thresh_ind_laser.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_dental_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_dental_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.hha_patient_visits_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.epic_hl7_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.lsc_individual_3.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.health_screening_mbr_level_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.membercob.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.policyholdercob.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ndc_hic4_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.mc_dental_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ltc_rpt_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.dwh_plan_map.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.pharmacy_hra_hia_exceptions.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ppl_voucher.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.ppl_voucher_monthly.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.geisinger_rx_dsnp_new.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.greenback_claim_record_f14_final_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.holon_gap_resp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.evv_acceptance_outcomes_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.conversio_claims_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.m25mddb_awp_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.m25mddb_gpi_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.esi_claim_record_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.opioid_master_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.m25mddb_vw.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.info_geo_provider.sql;
!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.fms_formulary_ndc.sql;

--edw_rpt
!load ../Schemas/edw_rpt/Views/edw_rpt.rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.health_planet_lab_fact_vw_verify.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_diagnosis_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_dpw_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_processing_explanation.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.processing_explanation_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_financial_service_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.financial_service_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.claim_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_financial_service_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.lab_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.lab_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member_month_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_member_month_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_lab_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_lab_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_premium_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_lab_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_lab_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_claim_number.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_claim_number.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_financial_service_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category_group_chc.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_dpw_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_total_sum_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_claim_number.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_premium_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_member_month_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_claim_number.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_premium_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dental_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_lab_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_lab_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.claim_lab_association.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider_service.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider_referring.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider_service_vw.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider_pcp.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_member_month_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_premium_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member_restricted.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.capitation_ccbh_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_rate_cell.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_member_month_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_claim_lab_association.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_claim_lab_association.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.hix_member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.aca_membership.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_procedure_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.vision_provider.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mco_recipient.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.claim_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.rider.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.physician.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.prescriber.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_claim_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.affiliation.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_claim_type.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_member.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.prescriber_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category_group_3mos.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.division.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy_claim_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_claim_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.drug.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cpt4_procedure_short_desc.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cpt4_procedure.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.plan_broker_group.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dim_date.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.division_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_diagnosis.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.loinc_test.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_claim_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_procedure.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dim_time.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dental_provider.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.health_status.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.pharmacy.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.capitation_pcp_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mco_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_service_location.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.zip_county.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.lab_result_range.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.drg.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_premium_fact.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.completion_factor_mc.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.completion_factor_ma.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.completion_factor.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.third_party_payer.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cpt4_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.service_location.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_mco_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_plan.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_completion_factor.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.revenue_procedure.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.provider_group_specialty.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_service_location.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.doral_claim_type.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cdt4_procedure.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.h9670_mbrs.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.w_division.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mco_payment_cycle.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.processing_explanation.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.processing_reason.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member_demographic.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.ma_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.cm_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.payable.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_service_location.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.budget_comp_factor_stat.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.disenrollment_reason.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.financial_service_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_mco_payment_cycle.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category_chc.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.diagnostic_cost_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.demographic.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.lab_source.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.icd_qualifier.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.member_grouping.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.line_of_business.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.funding.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.chc_unit_cnt_exceeds_length_vw.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mc_segment.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.product_line.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.capitation_type.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.joint_ventures.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.mtm_load_date.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.dpw_category_group_chip_vw.sql;
!load ../Schemas/edw_rpt/Views/edw_rpt.m3p_mc_benefit_year_thresholds.sql;

--engagement
!load ../Schemas/engagement/Views/engagement.etl_ods_tbl_member_events.sql;
!load ../Schemas/engagement/Views/engagement.etl_ods_tbl_member_accounts.sql;
!load ../Schemas/engagement/Views/engagement.etl_stgedw_medical_home_pcp.sql;
!load ../Schemas/engagement/Views/engagement.lsc_household_3.sql;
!load ../Schemas/engagement/Views/engagement.etl_stg_eut_cavulus_ext.sql;
!load ../Schemas/engagement/Views/engagement.etl_ods_tbl_member_conditions.sql;
!load ../Schemas/engagement/Views/engagement.lsc_individual_3.sql;
!load ../Schemas/engagement/Views/engagement.etl_stg_dwoao_rider_type.sql;
!load ../Schemas/engagement/Views/engagement.etl_stgdbo_riders_dnv.sql;
!load ../Schemas/engagement/Views/engagement.etl_ods_tbl_individual_extattr.sql;
!load ../Schemas/engagement/Views/engagement.etl_ods_tbl_sp_email_response.sql;
!load ../Schemas/engagement/Views/engagement.valid_emails.sql;
--!load ../Schemas/engagement/Views/engagement.rpt_sms_broadcast_history_mpulse.sql;
!load ../Schemas/engagement/Views/engagement.mktmodels_tbl_model_outputs.sql;
!load ../Schemas/engagement/Views/engagement.etl_stg_tbl_member_prefeerences.sql;

--gpsupport

!load ../Schemas/gpsupport/Views/gpsupport.promise_providers.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_member_chc.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_parta_chc.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_partb_chc.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_837_data.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_ncpdp_data.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_member.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_parta.sql;
!load ../Schemas/gpsupport/Views/gpsupport.cob_partb.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_maternity_835.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_maternity_837.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_stats.sql;
!load ../Schemas/gpsupport/Views/gpsupport.caps_chip_prv_files.sql;
!load ../Schemas/gpsupport/Views/gpsupport.chip_prv414.sql;
!load ../Schemas/gpsupport/Views/gpsupport.chip_prv430.sql;
!load ../Schemas/gpsupport/Views/gpsupport.chip_prv435.sql;
!load ../Schemas/gpsupport/Views/gpsupport.fb_upmc_trad_hdr.sql;
!load ../Schemas/gpsupport/Views/gpsupport.fb_upmc_trad_inst_dtl.sql;
!load ../Schemas/gpsupport/Views/gpsupport.fb_upmc_trad_prof_dtl.sql;
!load ../Schemas/gpsupport/Views/gpsupport.fb_upmc_trad_rx_dtl.sql;
!load ../Schemas/gpsupport/Views/gpsupport.home_nursing.sql;
!load ../Schemas/gpsupport/Views/gpsupport.master_promise_table.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_837_data_test.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_837_filter_rejects.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_chc_277_rpt.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_ey_837_data.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_ey_ncpdp_data.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ma_force_void_rej.sql;
!load ../Schemas/gpsupport/Views/gpsupport.mc400_mpi.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ops5_chc_history.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ops5_chip_history.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ops5_excluded_list.sql;
!load ../Schemas/gpsupport/Views/gpsupport.ops5_ma_history.sql;
!load ../Schemas/gpsupport/Views/gpsupport.prv414.sql;
!load ../Schemas/gpsupport/Views/gpsupport.prv415.sql;
!load ../Schemas/gpsupport/Views/gpsupport.prv430.sql;
!load ../Schemas/gpsupport/Views/gpsupport.prv435.sql;
!load ../Schemas/gpsupport/Views/gpsupport.prv720.sql;
!load ../Schemas/gpsupport/Views/gpsupport.risk_score_upmc.sql;
!load ../Schemas/gpsupport/Views/gpsupport.tpl_flagging.sql;

--hcc_user
!load ../Schemas/hcc_user/Views/hcc_user.ihcc_data.sql;
!load ../Schemas/hcc_user/Views/hcc_user.member_info.sql;
!load ../Schemas/hcc_user/Views/hcc_user.healthplanet_open_hcc.sql;


--hedis_common
!load ../Schemas/hedis_common/Views/hedis_common.rel_member.sql;
!load ../Schemas/hedis_common/Views/hedis_common.hedis_vsd_mv_p.sql;
!load ../Schemas/hedis_common/Views/hedis_common.hedis_lob_lkp.sql;
!load ../Schemas/hedis_common/Views/hedis_common.hedis_provider_practice_type.sql;



--idfs 
!load ../Schemas/idfs/Views/idfs.ca_idfs_diagnosis.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_epic_flowsheet.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_epic_results.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_epic_visits.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_ob_bundle.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_procedures.sql;
!load ../Schemas/idfs/Views/idfs.ca_idfs_visits.sql;
!load ../Schemas/idfs/Views/idfs.ca_work_partners_covid.sql;
!load ../Schemas/idfs/Views/idfs.empi_daily_global_idfs.sql;
!load ../Schemas/idfs/Views/idfs.ihcc_data.sql;
!load ../Schemas/idfs/Views/idfs.aver_ob_data.sql;
!load ../Schemas/idfs/Views/idfs.member_pcp.sql;
!load ../Schemas/idfs/Views/idfs.vpd_discharge_summary_vw.sql;
!load ../Schemas/idfs/Views/idfs.yourcare_panel_for_hsd_vw.sql

--logdata
!load ../Schemas/logdata/Views/logdata.adf_db_extract_idw_lake_pipeline_logging_vw.sql;
!load ../Schemas/logdata/Views/logdata.adf_table_load_history.sql;



--marketing
!load ../Schemas/marketing/Views/marketing.members.sql;
!load ../Schemas/marketing/Views/marketing.members_tab.sql;
!load ../Schemas/marketing/Views/marketing.plan_tab.sql;
!load ../Schemas/marketing/Views/marketing.plan.sql;
!load ../Schemas/marketing/Views/marketing.member_plan.sql;
!load ../Schemas/marketing/Views/marketing.member_plan_tab.sql;
!load ../Schemas/marketing/Views/marketing.member_events_tab.sql;
!load ../Schemas/marketing/Views/marketing.individual.sql;
!load ../Schemas/marketing/Views/marketing.individual_tab.sql;
!load ../Schemas/marketing/Views/marketing.division_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_members_tab.sql;
!load ../Schemas/marketing/Views/marketing.household.sql;
!load ../Schemas/marketing/Views/marketing.office.sql;
!load ../Schemas/marketing/Views/marketing.provider_offices.sql;
!load ../Schemas/marketing/Views/marketing.member_conditions_tab.sql;
!load ../Schemas/marketing/Views/marketing.member_conditions.sql;
!load ../Schemas/marketing/Views/marketing.provider_offices_tab.sql;
!load ../Schemas/marketing/Views/marketing.provider_pcp.sql;
!load ../Schemas/marketing/Views/marketing.provider_pcp_tab.sql;
!load ../Schemas/marketing/Views/marketing.accounts.sql;
!load ../Schemas/marketing/Views/marketing.address.sql;
!load ../Schemas/marketing/Views/marketing.dnv_division.sql;
!load ../Schemas/marketing/Views/marketing.dnv_division_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_plan_tab.sql;
!load ../Schemas/marketing/Views/marketing.household_tab.sql;
!load ../Schemas/marketing/Views/marketing.member_counts.sql;
!load ../Schemas/marketing/Views/marketing.dnv_members.sql;
!load ../Schemas/marketing/Views/marketing.accounts_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_member_plan.sql;
!load ../Schemas/marketing/Views/marketing.dnv_member_rider_tab.sql;
!load ../Schemas/marketing/Views/marketing.provider.sql;
!load ../Schemas/marketing/Views/marketing.dnv_plan.sql;
!load ../Schemas/marketing/Views/marketing.member_spend.sql;
!load ../Schemas/marketing/Views/marketing.office_tab.sql;
!load ../Schemas/marketing/Views/marketing.address_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_riders.sql;
!load ../Schemas/marketing/Views/marketing.division.sql;
!load ../Schemas/marketing/Views/marketing.provider_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_member_plan_tab.sql;
!load ../Schemas/marketing/Views/marketing.dnv_member_rider.sql;
!load ../Schemas/marketing/Views/marketing.dnv_riders_tab.sql;
!load ../Schemas/marketing/Views/marketing.mmi_lkp.sql;

--medhok
!load ../Schemas/medhok/Views/medhok.address_audit.sql;
!load ../Schemas/medhok/Views/medhok.audit_audit.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_address.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_appeals.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_attachments.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_audit.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_casenotes.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_committeemember.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_contact.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_correspond.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_ctm.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_der.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_eligibility.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_grievance.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_ire.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_member.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_notes.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_prescrib_spec.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_prescriber.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_prov_dispute.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_subtask.sql;
!load ../Schemas/medhok/Views/medhok.careprominence_users.sql;
!load ../Schemas/medhok/Views/medhok.comp_test.sql;

--mkt_cmtdb

!load ../Schemas/mkt_cmtdb/Views/mkt_cmtdb.ua_upmc_contacthistory.sql


--mkt_integration
!load ../Schemas/mkt_integration/Views/mkt_integration.odcompletedsurveyresponse.sql

--myhealth
!load ../Schemas/myhealth/Views/myhealth.web_process__member_list.sql
!load ../Schemas/myhealth/Views/myhealth.web_rpt__problem_list.sql


--saca
!load ../Schemas/saca/Views/saca.gs_and_sc_all_status_vw.sql;
!load ../Schemas/saca/Views/saca.staff_assign_vw.sql;


--ss_finance
!load ../Schemas/ss_finance/Views/ss_finance.idfs_open_gap_list.sql;
!load ../Schemas/ss_finance/Views/ss_finance.ss_membership.sql;
!load ../Schemas/ss_finance/Views/ss_finance.ss_membership_ytd.sql;


--staging

!load ../Schemas/staging/Views/staging.admission_source_cd_adult_lkp.sql;
!load ../Schemas/staging/Views/staging.admission_type_code_lkp.sql;
!load ../Schemas/staging/Views/staging.claims_diagnosis_hold_lkp.sql;
!load ../Schemas/staging/Views/staging.claims_procedure_hold_lkp.sql;
!load ../Schemas/staging/Views/staging.corp_name_lkp.sql;
!load ../Schemas/staging/Views/staging.division_subgrp_lkp.sql;
!load ../Schemas/staging/Views/staging.dnv_medical_member_lkp.sql;
!load ../Schemas/staging/Views/staging.dnv_member_lkp.sql;
!load ../Schemas/staging/Views/staging.dnv_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.doral_adjustment_codes_lkp.sql;
!load ../Schemas/staging/Views/staging.doral_exception_codes_lkp.sql;
!load ../Schemas/staging/Views/staging.health_status_lkp.sql;
!load ../Schemas/staging/Views/staging.market_segment_zipcode_lkp.sql;
!load ../Schemas/staging/Views/staging.mc_claims_ipa_lkp.sql; 
!load ../Schemas/staging/Views/staging.mc4_apr_drg_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_benlevel_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_claim_type_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_cm_cur_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_cm_dental_person_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_cm_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_cm_pharm_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_cm_vision_person_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_ndc_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_plan_type_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_preferred_contact_meth_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_super_group_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_system_provider_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_w_cur_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.mc4_w_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Views/staging.medicare_ind_lkp.sql;
!load ../Schemas/staging/Views/staging.mh_step2_product_plantype_lkp.sql;
!load ../Schemas/staging/Views/staging.mit_contact_cut_mail_lkp.sql;
!load ../Schemas/staging/Views/staging.mit_contact_hp_lkp.sql;
!load ../Schemas/staging/Views/staging.mit_interaction_cut_mail_lkp.sql;
!load ../Schemas/staging/Views/staging.mit_letter_category_lkp.sql;  
!load ../Schemas/staging/Views/staging.non_ccbh_corp_lkp.sql;
!load ../Schemas/staging/Views/staging.paid_reason_code_lkp.sql;
!load ../Schemas/staging/Views/staging.pharmacy_npi_lkp.sql;
!load ../Schemas/staging/Views/staging.relationship_desc_lkp.sql;
!load ../Schemas/staging/Views/staging.rider_formulary_code_lkp.sql;
!load ../Schemas/staging/Views/staging.rx_carve_out_member_lkp.sql;
!load ../Schemas/staging/Views/staging.rx_npi_lkp.sql;
!load ../Schemas/staging/Views/staging.sepreason_desc_lkp.sql;
!load ../Schemas/staging/Views/staging.eligibilityhistory.sql;
!load ../Schemas/staging/Views/staging.genericcodes.sql;
!load ../Schemas/staging/Views/staging.hixmembermaster.sql;
!load ../Schemas/staging/Views/staging.mastermemberid.sql;
!load ../Schemas/staging/Views/staging.memberemail.sql;
!load ../Schemas/staging/Views/staging.members.sql;
!load ../Schemas/staging/Views/staging.premiums.sql;
!load ../Schemas/staging/Views/staging.subgroups.sql;
!load ../Schemas/staging/Views/staging.subscriberprofile.sql;
!load ../Schemas/staging/Views/staging.stg_county_codes_good.sql;
!load ../Schemas/staging/Views/staging.chc_member_alt_other_pho_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_alt_prefrd_pho_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_birthdate_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_case_nbr_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_deceased_date_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_email_address_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_lang_desc_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_mmi_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_prefrd_contact_hold.sql;
!load ../Schemas/staging/Views/staging.chc_member_race_code_hold.sql;
!load ../Schemas/staging/Views/staging.claimsdetail.sql;
!load ../Schemas/staging/Views/staging.procedurecodes.sql;
!load ../Schemas/staging/Views/staging.proceduremodifier.sql;
!load ../Schemas/staging/Views/staging.specialty_ndc.sql;

--util
!load ../Schemas/util/Views/util.adf_copy_control_vw.sql

--uwpr
!load ../Schemas/uwpr/Views/uwpr.companyiddata.sql;

--upmc_tab

!load ../Schemas/upmc_tab/Views/upmc_tab.original_claims_vw.sql;


--upmc_immediate
!load ../Schemas/upmc_immediate/Views/upmc_immediate.original_claims.sql;
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
!load ../Schemas/util/StoredProcedures/UTIL.SPU_COPY_INTO_TABLE_IDW.sqlproc

!exit