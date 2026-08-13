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
!load ../DatabaseLevelObjects/Schemas/adl_prod.schema.sql;
!load ../DatabaseLevelObjects/Schemas/adl_stage.schema.sql;
!load ../DatabaseLevelObjects/Schemas/ccadmin.schema.sql;
!load ../DatabaseLevelObjects/Schemas/cm_internal.schema.sql;
!load ../DatabaseLevelObjects/Schemas/da_powerbi.schema.sql;
!load ../DatabaseLevelObjects/Schemas/data_load.schema.sql;
!load ../DatabaseLevelObjects/Schemas/dhs_edi.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edi_mapping.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_load.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_rpt.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_shared.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_usr_tab.schema.sql;
!load ../DatabaseLevelObjects/Schemas/engagement.schema.sql;
!load ../DatabaseLevelObjects/Schemas/gpsupport.schema.sql;
!load ../DatabaseLevelObjects/Schemas/hcc_user.schema.sql;
!load ../DatabaseLevelObjects/Schemas/hedis_common.schema.sql;
!load ../DatabaseLevelObjects/Schemas/hpanalytics.schema.sql;
!load ../DatabaseLevelObjects/Schemas/idfs.schema.sql;
!load ../DatabaseLevelObjects/Schemas/logdata.schema.sql;

!load ../DatabaseLevelObjects/Schemas/marketing.schema.sql;
!load ../DatabaseLevelObjects/Schemas/medhok.schema.sql;
!load ../DatabaseLevelObjects/Schemas/member_staging.schema.sql;
!load ../DatabaseLevelObjects/Schemas/mkt_cmtdb.schema.sql;
!load ../DatabaseLevelObjects/Schemas/mkt_integration.schema.sql;
!load ../DatabaseLevelObjects/Schemas/myhealth.schema.sql;
!load ../DatabaseLevelObjects/Schemas/pharmacyanalytics.schema.sql;
!load ../DatabaseLevelObjects/Schemas/saca.schema.sql;
!load ../DatabaseLevelObjects/Schemas/ss_finance.schema.sql;
!load ../DatabaseLevelObjects/Schemas/staging.schema.sql;
!load ../DatabaseLevelObjects/Schemas/util.schema.sql;
!load ../DatabaseLevelObjects/Schemas/uwpr.schema.sql;
!load ../DatabaseLevelObjects/Schemas/upmc_tab.schema.sql;
!load ../DatabaseLevelObjects/Schemas/wpdw.schema.sql;
!load ../DatabaseLevelObjects/Schemas/edw_misc_data.schema.sql;
!load ../DatabaseLevelObjects/Schemas/covid19.schema.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/Stages/util.hpdsdatalake_dbextract_idw_lake.sql;
!load ../Schemas/util/Stages/util.snowflakedata_idw_lake_file_data.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------

--engagement
!load ../Schemas/engagement/FileFormats/engagement.db_extract_csv_file_format.sql;

--logdata
!load ../Schemas/logdata/FileFormats/logdata.idw_lake_adf_logging_file_format.sql;

--util
!load ../Schemas/util/FileFormats/util.db_extract_parquet_file_format.sql;

--edw_misc_data

!load ../Schemas/edw_misc_data/FileFormats/edw_misc_data.aces_data_registry_vbid_file_format.sql;

--data_load
!load ../Schemas/data_load/FileFormats/data_load.amplifon_data_file_format.sql ;
!load ../Schemas/data_load/FileFormats/data_load.conversio_claims_csv_file_format.sql;

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

--adl_prod
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_rx_hist.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_kpi_fss_milliman.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.ref_conditions_map.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_procedure_master_final.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_procedure_member_mo.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_discharge_master.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_discharge_master_mtrn.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_discharge_master_nicu.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_discharge_master.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_hospital_census_rpt.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_maternity_hist.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_mbr_rx_coverage.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.events_library.sql;

!load ../Schemas/adl_prod/Tables/adl_prod.info_hit.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_hit_cc_date.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_ceg_crosswalk.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_chc_kpi_master.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_hospice_mc_history.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_household_id.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_kpi_member.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_kpi_revenue.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_mds_master_hp.sql;

!load ../Schemas/adl_prod/Tables/adl_prod.info_sba_oncology_hospice_dates.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_sba_oncology_medical_claims.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_sba_oncology_member_eligibility.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_sba_oncology_pharmacy_claims.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_strat_history.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_dwoao_claims_hist.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_cm_2022.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_cm_2023.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_cm_2024.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_ma_2022.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_ma_2023.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_ma_2024.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_mc_2022.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_mc_2023.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_dxcg_mc_2024.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_health_acuity.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_dwoao_auth_claims.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.ref_no_rx_plans.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_cpr_daily.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_sched_hist.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_pem.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_mcp_categories.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_mbr_enrl_curr.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_episode_hist.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_high_risk_maternity.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.episode_hist_idfs.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_edm_dexa_appt.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.ide_wellbe_eligible_hpnet_vw.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.info_rx_medrec_flag.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_ma_call_success.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_call_success_ma_gaps.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.mod_call_success.sql;
!load ../Schemas/adl_prod/Tables/adl_prod.ref_rx_rebates.sql;

--adl_stage
!load ../Schemas/adl_stage/Tables/adl_stage.ide_wellbe_eligible_vw.sql;

--ccadmin
!load ../Schemas/ccadmin/Tables/ccadmin.pcmh_sharedsavings_practices.sql;

--cm_internal
!load ../Schemas/cm_internal/Tables/cm_internal.hm_idp.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_absence.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_ccs2_detail_v2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fmla.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fullpart_gh_members_arch.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hapu.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hm.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hra_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_back_202203.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_key_gh.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_plan.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_safety_scores.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_5_15_80.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_ccs2_detail.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_department_stats.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_empi.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_back.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_costs.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_test.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_ctl_202103.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_key_ctl.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_mxp_seg.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_myvoice.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_myvoice_engage.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_pharm.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_prov.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.wpv_idp.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_eap_detail.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cancer_members.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_control.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_crosswalk.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_epr.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fam_seg_gh.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_healthmanagement.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hra.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave_new.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave_retired_20180412.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave_test.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_mapping.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_ctl.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_min_costs.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_qa.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_svcdensity_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_wc_clm_detail_backup.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_wc_clm_detail_backup_2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_adi.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_awc.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cd4.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fullpart_gh_members.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fullpart_gh_members_adhoc.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hand.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_healthmanagement2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hra_201406_202202.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave_proportions.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_wk_202004.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_opioid.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_vte.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_wc_clm_detail.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_wc_clm_detail_test.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cauti.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_ccs1.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clabs.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic4.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic_new.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_control_archive.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_deductible_key.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_eap_detail_daybreak_arch.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_knova.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_member_wage.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_proportions.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_prov2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_rvu.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_rx.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_safety_stage.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_sd.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_wc.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_bu_epr.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_bu_proportions.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_calc.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cc_proportions.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_dim_date.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_drug.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_fam_decile.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_gh.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_2015.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_m2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_key.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_key_back.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_prov_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_sd2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_std_clm_detail.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_std_clm_detail_hist_202012.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_tahs.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_bu_leave.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cc_leave.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic3.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_clinic5.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_dental.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_drug_cnt_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_drug_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_healthmanagement_copy.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hr.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hr_1.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_back_ctl.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_m_20211020.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_integrated_m_aad_202004.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_mmi.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_mn.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_predictor_table_master.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_std_clm_detail_test.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_ccs2.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_cc_epr.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_contract_demo.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_costdensity_m.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hit.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_hm_by_program.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_leave_20211020.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_med.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_gh.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_key_gh_nurse.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_members_test.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_myvoice_favorable_perc.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_safety.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_std.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_vision.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.wl_vw_hris_data.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.wl_hris_data.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.upmc_bu_map.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.wl_hris_paycodes.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.paycode_descriptions.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.idp_paycode_categories.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.ueg_tahs_mbrnbr_jobfam_mkting.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.ueg_email_results_eap_20260122.sql;
!load ../Schemas/cm_internal/Tables/cm_internal.phkpi_comm.sql;

--util
!load ../Schemas/util/Tables/util.adf_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_oracle_copy_control.sql;
!load ../Schemas/util/Tables/util.adf_file_copy_control.sql;

--logdata
!load ../Schemas/logdata/Tables/logdata.adf_oracle_filename_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.adf_table_load_history.sql;
!load ../Schemas/logdata/Tables/logdata.table_load_history.sql;

!load ../Schemas/logdata/Tables/logdata.adf_file_load_history.sql;

!load ../Schemas/logdata/Tables/logdata.adf_filename_load_history.sql;

--data_load
!load ../Schemas/data_load/Tables/data_load.ecoba_claims_stg.sql;
!load ../Schemas/data_load/Tables/data_load.ecoba_claims_hist.sql;
!load ../Schemas/data_load/Tables/data_load.ecoba_duplicate_audit.sql;
!load ../Schemas/data_load/Tables/data_load.amplifon_data.sql;
!load ../Schemas/data_load/Tables/data_load.conversio_claims.sql;

!load ../Schemas/dhs_edi/Tables/dhs_edi.dhs834_daily_detail.sql;
!load ../Schemas/dhs_edi/Tables/dhs_edi.dhs834_daily_detail_cob.sql;
!load ../Schemas/dhs_edi/Tables/dhs_edi.dhs834_daily_detail_hd.sql;
!load ../Schemas/dhs_edi/Tables/dhs_edi.dhs834_daily_header.sql;
!load ../Schemas/dhs_edi/Tables/dhs_edi.idw834tbl.sql;

--da_powerbi
!load ../Schemas/da_powerbi/Tables/da_powerbi.comm_pad_population.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.covid_ueg_quaronly_for_idfs.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.fact_hp_gtwy_care_activity.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.fact_hp_gtwy_rxwell.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.fact_hp_retention_rates_cpr.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.fact_wellbeing_population.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_baseline.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_date.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_employer.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_lifestyle_mnmgt.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_lifestyle_mnmgt_cust.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_member.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_member_cust.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_member_month.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_dim_onsite_events.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_pbi_lm_distinct.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_pbi_lm_oe_distinct.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_pbi_lm_rollup.sql;
!load ../Schemas/da_powerbi/Tables/da_powerbi.ohp_pbi_oe_rollup.sql;


--edi_mapping
!load ../Schemas/edi_mapping/Tables/edi_mapping.claim_detail_ecoba.sql;
!load ../Schemas/edi_mapping/Tables/edi_mapping.claim_file_ecoba.sql;
!load ../Schemas/edi_mapping/Tables/edi_mapping.claim_header_ecoba.sql;

--edw_load
!load ../Schemas/edw_load/Tables/edw_load.temp_ma_member_month.sql;

--edw_shared
!load ../Schemas/edw_shared/Tables/edw_shared.taxonomy_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.dnv_lob_plan_type_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.gcn_specialty_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.icd_description_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.lob_plan_type_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.location_code_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.mc4_discharge_status_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.mc4_drg_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.npi.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.revenue_code_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.rx_country_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.rx_state_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.service_type_lkp.sql;
!load ../Schemas/edw_shared/Tables/edw_shared.stg_hcpcs_level_ii.sql;


--edw_rpt
!load ../Schemas/edw_rpt/Tables/edw_rpt.rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.health_planet_lab_fact_vw_verify.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_diagnosis_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_dpw_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_processing_explanation.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.processing_explanation_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_financial_service_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.financial_service_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.claim_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_financial_service_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.lab_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.lab_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member_month_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_member_month_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_lab_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_lab_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_premium_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_lab_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_lab_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_claim_number.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_claim_number.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_financial_service_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_claim_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category_group_chc.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_processing_explanation_grp.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_diagnosis_poa_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_dpw_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_cpt4_modifier_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_total_sum_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_claim_number.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_premium_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_member_month_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_claim_number.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_financial_service_group_org.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_premium_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dental_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_lab_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_lab_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.claim_lab_association.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider_service.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider_referring.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider_service_vw.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider_pcp.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_member_month_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_premium_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member_restricted.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.capitation_ccbh_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_rate_cell.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_pharmacy_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_pharmacy_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_pharmacy_claim_npi.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_member_month_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_claim_lab_association.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_claim_lab_association.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.hix_member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.aca_membership.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_procedure_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.vision_provider.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mco_recipient.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.claim_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_dental_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.rider.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.physician.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.prescriber.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_claim_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.affiliation.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_member_disenrollment_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_claim_type.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_member.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.prescriber_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category_group_3mos.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.division.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_current_rider_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy_claim_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_claim_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.drug.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cpt4_procedure_short_desc.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cpt4_procedure.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_vision_icd_diag_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.plan_broker_group.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dim_date.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_vision_claim_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_vision_unresolved.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.division_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_diagnosis.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.loinc_test.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_claim_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_procedure.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dim_time.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dental_provider.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.health_status.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.pharmacy.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_current_membership_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.capitation_pcp_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mco_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_service_location.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.zip_county.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.lab_result_range.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.drg.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_premium_fact.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.completion_factor_mc.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.completion_factor_ma.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.completion_factor.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.third_party_payer.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cpt4_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.service_location.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_mco_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_plan.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_completion_factor.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.revenue_procedure.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.provider_group_specialty.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_service_location.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.doral_claim_type.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cdt4_procedure.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_curr_jv_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.h9670_mbrs.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.w_division.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mco_payment_cycle.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.processing_explanation.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.processing_reason.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member_demographic.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.ma_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.cm_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.payable.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_service_location.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.budget_comp_factor_stat.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.disenrollment_reason.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.financial_service_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_mco_payment_cycle.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_unit_cnt_exceeds_length.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category_chc.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.diagnostic_cost_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.demographic.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.lab_source.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.icd_qualifier.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.member_grouping.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.line_of_business.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.funding.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.chc_unit_cnt_exceeds_length_vw.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mc_segment.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.product_line.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.capitation_type.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.joint_ventures.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.mtm_load_date.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.dpw_category_group_chip_vw.sql;
!load ../Schemas/edw_rpt/Tables/edw_rpt.m3p_mc_benefit_year_thresholds.sql;


--edw_usr_tab
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_dental_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_vision_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_vision_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_visits_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_combined.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_workhistory.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_servdetail_all.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_combined_reject.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.health_planet_lab_fact_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esc_suppl.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_servdetail_cy_all.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_servdetail_surveillance.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_append_work.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.quest_results_lab_full_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_operatorstatistics.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_claim_record_f14_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_claimline.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_cov_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_ddps_return_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medicaid_newserhist_medical.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_report_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.oim_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.sl_stoploss_history.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_operatorproductivity.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_results_all.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_pendcodes.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_pharmacy_rejects.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_results_cy_all.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_pde_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.q_results_surveillance.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_evv_visit.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_work.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_newserhist_medical.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mmr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_pharmacy_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_pharmacy_bat_rec_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_ante.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ndc_claim_master.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.full_enrollment.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lishist_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_dental_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_dental_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_authorization_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medical_home.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.action_rewards_master_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_vision_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_vision_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.action_rewards_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_claim_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medicaid_newserhist_pharmacy.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_file_caqh.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_quest_reject.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_demographics_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_quest_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stg_county_codes_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.in820_shop_ppr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_dental_mbr_month_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_dental_mbr_month.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_notes_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ecoba_claims_hist_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ecoba_duplicate_audit_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.caa_main.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_evv_visit_filtered_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.tpl_chc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mspcobma_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dwoao_premiums_incurred_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dwoao_premium_incurr_detail_1.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mor_v24_edps_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_newserhist_pharmacy.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.wex_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lsc_household_3.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.npi.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stg_skygen_claim.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.caa_summary.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cologuard_claims.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mars_results_lab_lkp_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_ddps_ret_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.in820_ind_det.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.oim_header.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.transaction_reply_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medicaid_newserhist_revenue.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_washington_reject.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.idap_empi_daily_global_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.tivity_partic_report.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_pace.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_file_dhs.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.nva_paid_claim_extract.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_subreport_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_pharmacy_record_f14.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_caregiver_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_act_adjustment_req_intake.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stg_doral_claim.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cc_hia_transactions.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_pace.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.highmark_wellness.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mpwrd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mor_rxhcc_v08.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mars_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_otc_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.highmark_eqt.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_newserhist_revenue.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_captureloginlogout.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.healthsparq_source.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.healthy_frontiers.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_locationplans.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ucci_dental.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.wellness_medical_claims.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_report_master.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mbrid_mrn_xref.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_prior_authorization.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cms_case_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_file_cms.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_esi_claim_record_f14_final.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.agent_broker_comp_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.quest_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_scm_data_audit.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_optum_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pa_hub_test_claims.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dwdnv_premiums_incurred_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cts_encounter.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_lancaster_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.time_and_outcome_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medicaid_newserhist_inpatient.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dhs_chc_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hq2_wellmed_new_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pa_hub_all_eoc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cc_pharmacy_tx.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cavulus_ext.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_mds_data_1.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.in820_shop_det.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mh_cactus_pcp.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_mds_data_2.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_authorization_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_pharmcare_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_heritage_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pahub_user_productivity_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mor_v28_non_esrd.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_affiliation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_nonresponder.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_newserhist_inpatient.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pa_hub_prior_authorizations.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_locationgroups.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_attestation_location.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_cov_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.sl_stoploss.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_otc_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cc_spending_acct_balances.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.health_screening_test_level_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.healthyu_account_balance_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.equitrans_midstream_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cdh_contracts_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_somerset_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.care_connect.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cmu_cvs_stoploss_det.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_practicelocation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mon_valley_claims_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.washington_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.memberothereligibilityall_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_washington_reject_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cavulus_sales_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_taxonomy.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.brain_manager_staging_master.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_hospitalaffiliation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_daily_mbr_enroll.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_workbasket.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_license.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.memberothereligibility_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.caa_d6_summary.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_adjustment_case_details.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_demographics_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_providerspecialties.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_attestation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_file_hms.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cactus_provider_file.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_express_scripts.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_caregiver_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chathamclinic.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.irt_detail.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_provider_loc_lang.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.oasis_empi.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_master.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_npi.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_providerinfo.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_beaver_county.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_beavcnt_finance.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_vision_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_vision_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dha_condition_management.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_dental_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cm_dental_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_providerlanguages.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.m25mddb_key_identifier_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_err_sum_rpt_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dsnp_rx_combo.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.excela_results_lab.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cvs_stoploss_det.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_medschool.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_42cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_enh_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_dea.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.edw_health_screening.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.digital_health_assessment.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.gateway_adm_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medipac_encounter_diagnosis.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.wk_comp_npi_claim_rec_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.user_summary_new.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_locations.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_40cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chathamclinic_member.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_facility.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexdt.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.aetna_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cactus_hosp_priv_file.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.senior_has_demographics_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.edw_flu_all.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.convey_order_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_providerschool.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.omw_report_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mq_yesno.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.chc_weekly_mbr_disenroll.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.truescripts_rx_stoploss.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.kirby_results_lab_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_geocensus.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cob_file_syrtis_rx.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_hra_hia_audit.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.aetna_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.united_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.apple_health_screening.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.healthyu_debit_utilization_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.facility_nonresponder_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_provider_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_act_adjustment_case_intake.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.wellness_ssn_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medipac_insurance_info.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.plan_benefit_design.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.gateway_rx_dsnp_new_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.gateway_rx_dsnp_new.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_giant_eagle_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medipac_encounter_icd_proc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medipac_encounter_cpt_hcpc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.care_connect_magellan.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.medipac_encounters.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ecoba_claims_stg_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cigna_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_carve_out_somerset.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.aon_health_exchange.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ucci_dental_pa_cyber_claims.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_ddps_ret_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_facility_attestation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.verify_facility.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_43cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_err_sum_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_err_sum_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_err_sum_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.senior_medicare_hq2_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.tivity_pittsburgh_ys.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mor_v24_esrd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cactus_facilities_service_file.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.copd_mc_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.proact_stoploss_claims.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_ddps_ret_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_41cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cactus_facilities_file.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.vbid_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.plan_benefit_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.care_connect_perform.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.completion_factor.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.completion_factor_ma.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.completion_factor_mc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.humana_rx_dsnp.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lab_kirby_reject.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.humana_dsnp_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.tivity_sewickly_ymca.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_operatorskills.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cigna_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.proc_code_combo.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.completion_factors_cc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_file_batch_record_daily_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_43cov_shd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_43cov_str_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.amplifon_data.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_41cov_rhd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_41cov_rtr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_idvboard_sanc.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.nations_benefits_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_indexoperator.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.healthyu_non_debit_utilization_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_ddps_ret_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.wk_comp_npi_comp_det_rec_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pahw_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.health_ptnr_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_40cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_40cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stop_loss_threshold.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_42cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_42cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_operator_wb_list.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_otc_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_otc_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cms_err_sum_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cms_err_sum_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_enh_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cmsddps_ret_bhd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_42cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_enh_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_40cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_40cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_42cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_42cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.h6_alternate_address_hist_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_operator.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_enh_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_enh_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_otc_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drug_event_cms_otc_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cmsddps_ret_hdr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.completion_factors.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_43cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_43cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_41cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_41cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40otc_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cmsddps_ret_btr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cmu_aetna_stoploss.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.in820_shop_hdr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mpwrd_header_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cws_worklist.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.myhealth_at_work_order.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexbt_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexbh.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexbt.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.h6_alternate_address_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexpt_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexph.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexpt.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lsc_script_validation.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mor_hcc_header.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_42cov_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_42cov_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.amerihealth_dsnp_data_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_42cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_42cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.in820_ind_hdr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stop_loss_domestic_tax_id.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40otc_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40otc_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40otc_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40otc_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40enh_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drgevt_cmsddps_ret_tlr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.drug_event_cms_ddps_ret_tlr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_43cov_det_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_43cov_shd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_43cov_str_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexct.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.partdexcluswarn_pexch.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cvs_stoploss_tlr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cvs_stoploss_hdr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40enh_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40enh_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40enh_phd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_40enh_ptr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_43cov_chd_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cli_drugevent_cms_43cov_ctr_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.enclarity_collapse.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cmu_cvs_stoploss_hdr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.cmu_cvs_stoploss_tlr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.rx_prior_authorization_hold.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.stop_loss_thresh_ind_laser.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_dental_curr_mbr.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_dental_curr_mbr_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.hha_patient_visits_filter_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.epic_hl7_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.lsc_individual_3.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.health_screening_mbr_level_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.membercob.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.policyholdercob.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ndc_hic4_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.mc_dental_claims_restricted.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ltc_rpt_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.dwh_plan_map.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.pharmacy_hra_hia_exceptions.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ppl_voucher.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.ppl_voucher_monthly.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.geisinger_rx_dsnp_new.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.greenback_claim_record_f14_final_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.m25mddb_awp_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.m25mddb_gpi_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.esi_claim_record_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.opioid_master_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.m25mddb_vw.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.info_geo_provider.sql;
!load ../Schemas/edw_usr_tab/Tables/edw_usr_tab.fms_formulary_ndc.sql;

--engagement

!load ../Schemas/engagement/Tables/engagement.etl_ods_tbl_member_events.sql;
!load ../Schemas/engagement/Tables/engagement.etl_ods_tbl_member_accounts.sql;
!load ../Schemas/engagement/Tables/engagement.etl_stgedw_medical_home_pcp.sql;
!load ../Schemas/engagement/Tables/engagement.etl_ods_tbl_individual_extattr.sql;
!load ../Schemas/engagement/Tables/engagement.lsc_household_3.sql;
!load ../Schemas/engagement/Tables/engagement.etl_stg_eut_cavulus_ext.sql;
!load ../Schemas/engagement/Tables/engagement.etl_ods_tbl_member_conditions.sql;
!load ../Schemas/engagement/Tables/engagement.lsc_individual_3.sql;
!load ../Schemas/engagement/Tables/engagement.etl_stg_dwoao_rider_type.sql;
!load ../Schemas/engagement/Tables/engagement.etl_stgdbo_riders_dnv.sql;
!load ../Schemas/engagement/Tables/engagement.etl_ods_tbl_sp_email_response.sql;
!load ../Schemas/engagement/Tables/engagement.valid_emails.sql;
--!load ../Schemas/engagement/Tables/engagement.rpt_sms_broadcast_history_mpulse.sql;
!load ../Schemas/engagement/Tables/engagement.mktmodels_tbl_model_outputs.sql;
!load ../Schemas/engagement/Tables/engagement.etl_stg_tbl_member_prefeerences.sql;

--gpsupport
!load ../Schemas/gpsupport/Tables/gpsupport.promise_providers.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_member_chc.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_parta_chc.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_partb_chc.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_837_data.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_ncpdp_data.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_member.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_parta.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.cob_partb.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_maternity_835.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_maternity_837.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_stats.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.caps_chip_prv_files.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.chip_prv414.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.chip_prv430.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.chip_prv435.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.fb_upmc_trad_hdr.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.fb_upmc_trad_inst_dtl.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.fb_upmc_trad_prof_dtl.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.fb_upmc_trad_rx_dtl.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.home_nursing.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.master_promise_table.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_837_data_test.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_837_filter_rejects.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_chc_277_rpt.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_ey_837_data.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_ey_ncpdp_data.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ma_force_void_rej.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.mc400_mpi.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ops5_chc_history.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ops5_chip_history.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ops5_excluded_list.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.ops5_ma_history.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.prv414.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.prv415.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.prv430.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.prv435.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.prv720.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.risk_score_upmc.sql;
!load ../Schemas/gpsupport/Tables/gpsupport.tpl_flagging.sql;


--hcc_user
!load ../Schemas/hcc_user/Tables/hcc_user.ihcc_data.sql;
!load ../Schemas/hcc_user/Tables/hcc_user.member_info.sql;
!load ../Schemas/hcc_user/Tables/hcc_user.healthplanet_open_hcc.sql;


--hedis_common
!load ../Schemas/hedis_common/Tables/hedis_common.rel_member.sql;
!load ../Schemas/hedis_common/Tables/hedis_common.hedis_vsd_mv_p.sql;
!load ../Schemas/hedis_common/Tables/hedis_common.hedis_lob_lkp.sql;
!load ../Schemas/hedis_common/Tables/hedis_common.hedis_provider_practice_type.sql;



--hpanalytics
!load ../Schemas/hpanalytics/Tables/hpanalytics.aca_enrollment.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.cmfi_member_premium.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ipa_code_desc_crosswalk.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_avg_membership.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_biometric_summ.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_book.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_book_hold.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_book_stg.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_claims_strat.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_claims_strat_new.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_corps.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_covid_est_paid.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_covid_pos_dx.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_covid_vax_est_paid.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_demographics.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_diagnostic.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_divisions.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_er.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss_exec.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss_new.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss_util.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss_util_exec.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_fss_util_exec_new.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_groups.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_hospital.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_hra_benchmarks_temp.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_hra_population.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_hra_summ.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_ip_facilities.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_mdc.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_medical.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_member_detail.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_member_months.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_members.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_msk_claims.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_mss.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_op_facilities.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_outpatient.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_paid.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_paid_sum_fss.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_paid_sum_provider.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_paid_sum_stg.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_paid_sum_summary.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_pharmacy.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_plans.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_premium.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_premium_update.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_prevalence.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_rx.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_rx_brand_vs_generic.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_rx_brand_vs_generic_nocov.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_rx_new.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_rx_retail_vs_mail.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_specialist.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_specialty_rx.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_telehealth.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_test_fas.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_ther.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_top_providers.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_w_corps.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_w_divisions.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_w_groups.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.care_opp_claims.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.drug_class.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.drg_weight_versions.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.med_therapy_classifications.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.cm_criteria.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.cm_lookup.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.book_w_plans.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.exec_summ_ccs_dx.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.exec_summ_ccs_dx_icd10.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.exec_summ_ccs_dx_icd10_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.exec_summ_ccs_dx_icd10_2019.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.gcs_pharmacy.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.gcs_ip_count.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.health_management.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.health_management_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.health_management_webmd.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.hp_anywherecare.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ia_aca_plans.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ia_aca_plans_extended.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.vw_ia_mem.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_cmfi_fss_rx_detail.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_fss.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_fss_aso.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_fss_prem.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_fss_ueg.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_gov_clients.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_ind_fss.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_ind_fss_las.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_ind_fss_prem.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_ind_fss_rx_detail.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_lookup.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_lookup_new_plans.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.product_map.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.salesforce_sg_aca.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.sched_registrationarchive.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.sg_aca_plans.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.sg_aca_plans_extended.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.upmc_plan_map.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ref_ccsr_dx_vw.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ref_ccs_cpt_vw.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.cm_ind_rating_areas.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.glp_weightloss_products.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ia_rx_rebates.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.milliman_drg_mapping_dohe.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.milliman_hcpcs_family_2025.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy12.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy13.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy14.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy15.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy16.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy17.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy18.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy19.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy20.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy21.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy22.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy23.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy24.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy25.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.pcg_master_cy26.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.rx_rebate.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.template_xray_categories.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cm_mc.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy15.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy16.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy17.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy18.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy19.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy20.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy20_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy20_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy21_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy21_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy21.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy22.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy22_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy22_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy23_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy23_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy23.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy24.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy24_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy24_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy25_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy25_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy25.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy26.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy26_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_cy26_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy15.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy16.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy17.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy18.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy19.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy20.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy20_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy20_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy21_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy21_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy21.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy22.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy22_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy22_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy23_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy23_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy23.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy24.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy24_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy24_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy25_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy25.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy26.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy26_1.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classifications_fy26_2.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202507.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202508.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202509.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202510.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202511.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_2025110.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202512.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202601.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202602.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202603.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202604.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.u249_classification_202605.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.ccsr_dx_body_systems.sql;
!load ../Schemas/hpanalytics/Tables/hpanalytics.zips_counties_states_nodups.sql;

--idfs
!load ../Schemas/idfs/Tables/idfs.ca_idfs_diagnosis.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_epic_flowsheet.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_epic_results.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_epic_visits.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_ob_bundle.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_procedures.sql;
!load ../Schemas/idfs/Tables/idfs.ca_idfs_visits.sql;
!load ../Schemas/idfs/Tables/idfs.ca_work_partners_covid.sql;
!load ../Schemas/idfs/Tables/idfs.empi_daily_global_idfs.sql;
!load ../Schemas/idfs/Tables/idfs.ihcc_data.sql;
!load ../Schemas/idfs/Tables/idfs.yourcare_panel_for_hsd_vw.sql;



--marketing
!load ../Schemas/marketing/Tables/marketing.members.sql;
!load ../Schemas/marketing/Tables/marketing.members_tab.sql;
!load ../Schemas/marketing/Tables/marketing.plan_tab.sql;
!load ../Schemas/marketing/Tables/marketing.plan.sql;
!load ../Schemas/marketing/Tables/marketing.member_plan.sql;
!load ../Schemas/marketing/Tables/marketing.member_plan_tab.sql;
!load ../Schemas/marketing/Tables/marketing.member_events_tab.sql;
!load ../Schemas/marketing/Tables/marketing.individual.sql;
!load ../Schemas/marketing/Tables/marketing.individual_tab.sql;
!load ../Schemas/marketing/Tables/marketing.division_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_members_tab.sql;
!load ../Schemas/marketing/Tables/marketing.household.sql;
!load ../Schemas/marketing/Tables/marketing.office.sql;
!load ../Schemas/marketing/Tables/marketing.provider_offices.sql;
!load ../Schemas/marketing/Tables/marketing.member_conditions_tab.sql;
!load ../Schemas/marketing/Tables/marketing.member_conditions.sql;
!load ../Schemas/marketing/Tables/marketing.provider_offices_tab.sql;
!load ../Schemas/marketing/Tables/marketing.provider_pcp.sql;
!load ../Schemas/marketing/Tables/marketing.provider_pcp_tab.sql;
!load ../Schemas/marketing/Tables/marketing.accounts.sql;
!load ../Schemas/marketing/Tables/marketing.address.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_division.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_division_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_plan_tab.sql;
!load ../Schemas/marketing/Tables/marketing.household_tab.sql;
!load ../Schemas/marketing/Tables/marketing.member_counts.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_members.sql;
!load ../Schemas/marketing/Tables/marketing.accounts_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_member_plan.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_member_rider_tab.sql;
!load ../Schemas/marketing/Tables/marketing.provider.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_plan.sql;
!load ../Schemas/marketing/Tables/marketing.member_spend.sql;
!load ../Schemas/marketing/Tables/marketing.office_tab.sql;
!load ../Schemas/marketing/Tables/marketing.address_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_riders.sql;
!load ../Schemas/marketing/Tables/marketing.division.sql;
!load ../Schemas/marketing/Tables/marketing.provider_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_member_plan_tab.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_member_rider.sql;
!load ../Schemas/marketing/Tables/marketing.dnv_riders_tab.sql;
!load ../Schemas/marketing/Tables/marketing.mmi_lkp.sql;

--medhok
!load ../Schemas/medhok/Tables/medhok.address_audit.sql;
!load ../Schemas/medhok/Tables/medhok.audit_audit.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_address.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_appeals.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_attachments.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_audit.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_casenotes.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_committeemember.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_contact.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_correspond.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_ctm.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_der.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_eligibility.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_grievance.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_ire.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_member.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_notes.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_prescrib_spec.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_prescriber.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_prov_dispute.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_subtask.sql;
!load ../Schemas/medhok/Tables/medhok.careprominence_users.sql;
!load ../Schemas/medhok/Tables/medhok.comp_test.sql;


--member_staging
!load ../Schemas/member_staging/Tables/member_staging.empi_daily_global.sql;

--mkt_cmtdb

!load ../Schemas/mkt_cmtdb/Tables/mkt_cmtdb.ua_upmc_contacthistory.sql;


--mkt_integration
!load ../Schemas/mkt_integration/Tables/mkt_integration.odcompletedsurveyresponse.sql;

--myhealth
!load ../Schemas/myhealth/Tables/myhealth.web_process__member_list.sql;
!load ../Schemas/myhealth/Tables/myhealth.web_rpt__problem_list.sql;
--pharmacyanalytics
!load ../Schemas/pharmacyanalytics/Tables/pharmacyanalytics.aso_rebates.sql;

--saca
!load ../Schemas/saca/Tables/saca.gs_and_sc_all_status_vw.sql;
!load ../Schemas/saca/Tables/saca.staff_assign_vw.sql;


--ss_finance
!load ../Schemas/ss_finance/Tables/ss_finance.idfs_open_gap_list.sql;
!load ../Schemas/ss_finance/Tables/ss_finance.ss_membership.sql;
!load ../Schemas/ss_finance/Tables/ss_finance.ss_membership_ytd.sql;

--staging
!load ../Schemas/staging/Tables/staging.ecoba_formnbr.sql;
!load ../Schemas/staging/Tables/staging.admission_source_cd_adult_lkp.sql;
!load ../Schemas/staging/Tables/staging.admission_type_code_lkp.sql;
!load ../Schemas/staging/Tables/staging.claims_diagnosis_hold_lkp.sql;
!load ../Schemas/staging/Tables/staging.claims_procedure_hold_lkp.sql;
!load ../Schemas/staging/Tables/staging.corp_name_lkp.sql;
!load ../Schemas/staging/Tables/staging.division_subgrp_lkp.sql;
!load ../Schemas/staging/Tables/staging.dnv_medical_member_lkp.sql;
!load ../Schemas/staging/Tables/staging.dnv_member_lkp.sql;
!load ../Schemas/staging/Tables/staging.dnv_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.doral_adjustment_codes_lkp.sql;
!load ../Schemas/staging/Tables/staging.doral_exception_codes_lkp.sql;
!load ../Schemas/staging/Tables/staging.health_status_lkp.sql;
!load ../Schemas/staging/Tables/staging.market_segment_zipcode_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc_claims_ipa_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_apr_drg_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_benlevel_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_claim_type_lkp.sql;
--!load ../Schemas/staging/Tables/staging.mc4_claims_ipa_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_cm_cur_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_cm_dental_person_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_cm_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_cm_pharm_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_cm_vision_person_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_ndc_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_plan_type_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_preferred_contact_meth_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_super_group_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_system_provider_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_w_cur_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.mc4_w_personnbr_cnt_lkp.sql;
!load ../Schemas/staging/Tables/staging.medicare_ind_lkp.sql;
!load ../Schemas/staging/Tables/staging.mh_step2_product_plantype_lkp.sql;
!load ../Schemas/staging/Tables/staging.mit_contact_cut_mail_lkp.sql;
!load ../Schemas/staging/Tables/staging.mit_contact_hp_lkp.sql;
!load ../Schemas/staging/Tables/staging.mit_interaction_cut_mail_lkp.sql;
!load ../Schemas/staging/Tables/staging.mit_letter_category_lkp.sql;
!load ../Schemas/staging/Tables/staging.non_ccbh_corp_lkp.sql;
!load ../Schemas/staging/Tables/staging.paid_reason_code_lkp.sql;
!load ../Schemas/staging/Tables/staging.pharmacy_npi_lkp.sql;
!load ../Schemas/staging/Tables/staging.relationship_desc_lkp.sql;
!load ../Schemas/staging/Tables/staging.rider_formulary_code_lkp.sql;
!load ../Schemas/staging/Tables/staging.rx_carve_out_member_lkp.sql;
!load ../Schemas/staging/Tables/staging.rx_npi_lkp.sql;
!load ../Schemas/staging/Tables/staging.sepreason_desc_lkp.sql;
!load ../Schemas/staging/Tables/staging.eligibilityhistory.sql;
!load ../Schemas/staging/Tables/staging.genericcodes.sql;
!load ../Schemas/staging/Tables/staging.hixmembermaster.sql;
!load ../Schemas/staging/Tables/staging.mastermemberid.sql;
!load ../Schemas/staging/Tables/staging.memberemail.sql;
!load ../Schemas/staging/Tables/staging.members.sql;
!load ../Schemas/staging/Tables/staging.premiums.sql;
!load ../Schemas/staging/Tables/staging.subgroups.sql;
!load ../Schemas/staging/Tables/staging.subscriberprofile.sql;
!load ../Schemas/staging/Tables/staging.stg_county_codes_good.sql;
!load ../Schemas/staging/Tables/staging.chc_member_alt_other_pho_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_alt_prefrd_pho_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_birthdate_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_case_nbr_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_deceased_date_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_email_address_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_lang_desc_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_mmi_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_prefrd_contact_hold.sql;
!load ../Schemas/staging/Tables/staging.chc_member_race_code_hold.sql;
!load ../Schemas/staging/Tables/staging.claimsdetail.sql;
!load ../Schemas/staging/Tables/staging.procedurecodes.sql;
!load ../Schemas/staging/Tables/staging.proceduremodifier.sql;
!load ../Schemas/staging/Tables/staging.specialty_ndc.sql;
!load ../Schemas/staging/Tables/staging.bpl_rider_xref.sql;
!load ../Schemas/staging/Tables/staging.stg_county_codes.sql;

--uwpr
!load ../Schemas/uwpr/Tables/uwpr.companyiddata.sql;
!load ../Schemas/uwpr/Tables/uwpr.tblrenewalinventory.sql;

--upmc_tab
!load ../Schemas/upmc_tab/Tables/upmc_tab.original_claims.sql;
!load ../Schemas/upmc_tab/Tables/upmc_tab.tpa_clients.sql;

--wpdw
!load ../Schemas/wpdw/Tables/wpdw.eap_benchmarks_detail.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_benchmarks_header.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_activity_detail.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_appt_type_offered.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_assessed_problems.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_client.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_client_type.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_demographics.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_employer.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_ethnicity.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_goals.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_impact.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_info_call_type.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_info_call_type_hist.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_marital_status.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_org_coaching_type.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_org_decision_plan.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_org_service_type.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_presenting_problems.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_recommendation.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_resolution.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_services_offered.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_supv_discipline.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_dim_supv_referral.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_case.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_case_activity.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_employer_month.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_info_calls.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_org_services.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_org_services_activity.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_fct_wos.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_lifeadvantages_skllbld.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_lifeadvantages_webhits.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_lifeadvantages_webhits_looker.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_lkp_demographics.sql;
!load ../Schemas/wpdw/Tables/wpdw.eap_lkp_presenting_problems.sql;
!load ../Schemas/wpdw/Tables/wpdw.hm_enrollee.sql;
!load ../Schemas/wpdw/Tables/wpdw.idp_risk_build.sql;
!load ../Schemas/wpdw/Tables/wpdw.idp_risk_lookup.sql;
!load ../Schemas/wpdw/Tables/wpdw.idp_risk_lookup_supp.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_access.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_empi_daily_global.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_epic_prod.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_epic_prod_bkp.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_epic_stage.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_mbr.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_p4p_base.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_p4p_config.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_portal.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_prod.sql;
!load ../Schemas/wpdw/Tables/wpdw.rx_for_wellness_spa_stage.sql;
!load ../Schemas/wpdw/Tables/wpdw.ueg_eap_data_ctl.sql;


--edw_misc_data
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.aces_data_registry_vbid.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.aon_health_exchange.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.cavulus_ext.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.chip_newserhist_medical.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.chip_newserhist_pharmacy.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.chip_newserhist_revenue.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.cmu_aetna_stoploss.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.in820_shop_det.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.in820_shop_hdr.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.in820_shop_ppr.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.mor_rxhcc_v08.sql ;
!load ../Schemas/edw_misc_data/Tables/edw_misc_data.ucci_dental_pa_cyber_claims.sql ;

--covid19


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

--logdata
!load ../Schemas/logdata/Views/logdata.adf_db_extract_idw_lake_pipeline_logging_vw.sql;
!load ../Schemas/logdata/Views/logdata.adf_idw_lake_file_pipeline_logging_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/StoredProcedures/util.spu_copy_into_table_idw_lake.sqlproc;

!load ../Schemas/util/StoredProcedures/util.update_adf_oracle_filename_load_history.sqlproc;

!load ../Schemas/util/StoredProcedures/util.spu_file_copy_into_table_idw_lake.sqlproc;

--edi_mapping
!load ../Schemas/edi_mapping/StoredProcedures/edi_mapping.spu_load_ecoba_claims.sqlproc;

--idfs
!load ../Schemas/idfs/StoredProcedures/idfs.spu_load_empi_daily_global_idfs.sqlproc;
--<schemaname>
--<schemaname>
--<schemaname>

!exit