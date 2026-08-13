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
!load ../Schemas/DatabaseLevelObjects/UPMCVH_PROD.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

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
--virtual_health_stage
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.eav_assessment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.eav_assessment_ext.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.user.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_form.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator_departments.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_data.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_data_layouts.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.attestation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.authorizations.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.care_team.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.care_team_history.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_caremanager_attributes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_departments.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_languages.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_lob.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_plans.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_roles.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_service_areas.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_service_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_supervisors.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator_credentials.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator_mode.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator_roles.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.administrator_service_areas.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.api_form_version.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.api_form_version_alias.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.appeal_status_reasons.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.appeal_status_reasons_to_appeal_overall_determination.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_export_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_form_version.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assessment_form_version_alias.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_distance_matrix_call_log.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_holding_tank.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_profile.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_profile_language.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_profile_lobs.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_profile_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_profile_roles.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_queue_launch_log.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_threshold_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_ws_care_manager.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_holding_tank_assignment_pathway.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_pathway_assignment_profile.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.assignment_ws_care_manager_assignment_profile.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.authorization_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.authorizations_log.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.calendar.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.care_team_history_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.caremanager_caseload.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_isp_rug_costlimit.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_isp_rug_service.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_isp_stcw_category_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_api.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_association.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_credentials.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_email_log.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_import_active_list.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_language.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_notes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_notes_addendum.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_npi.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_pfin.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_roles.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_service_area.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_service_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_service_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_specialization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider_state_id.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cccd_codes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cccd_filemap.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cccd_map_immuno.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_careprovider.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_encounter.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_family_member_condition.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_form.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_guardian.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_habit.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_hospitalization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_hospitalization_source.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_hospitalization_status_discharge.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_commercial.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_commercial_only.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_medicaid.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_medicaid_future.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_medicare.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_insurance_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_lar.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_mailing.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_other_contact.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_parent.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_partner_contact.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_poa.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_procedure.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_race.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_report.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_service.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_service_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_spouse.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_state_data.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_visit.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.contact_list.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.credentials.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.custom_report.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.discharge_lace_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.disenrollment_terminated_insurance.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.enrollment_history.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.hcpcs_codes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.health_summary_tile.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.hedis_report_data.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.historical_data_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_cpt_map_to_cvx.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_cvx.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_map_cvx_vacine.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_map_ndc_to_cvx_mvx.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_map_pr_names_to_cvx_mvx.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.iis_mvx.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.lab.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.lab_flag.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.lab_result.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.lab_unit.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc_class_term.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc_method_typ.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc_property.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc_system.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.loinc_time_aspct.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.ltss_billing_matrix_codes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.ltss_service_category.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.ltss_service_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.membership_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_auth_service_type_settings.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_auth_service_type_settings_request_category.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_auth_service_type_settings_request_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_authorization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_authorization_diagnosis.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_authorization_number.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_authorization_service.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.prior_authorization_service_modifier.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.product_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.provider_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.publication.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.publication_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.qrs_value_sets_to_codes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.risk.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.risk_cdps_weight.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.risk_memo.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.risk_ndc_cdps_map.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.screen.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.screen_access_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.screen_access_rule.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.screen_alternative_url.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.setting_of_care.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.settings_um_permissions.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sig.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_admin_profile_field.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_care_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_criteria.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_criteria_assessment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_criteria_option.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_criteria_rank.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_criteria_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_dynamic_parameters_cache.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_eligibility_verification.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_episode.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_episode_status_from_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_episode_type_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_message.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_performed_log.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_referral.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_referral_sub_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_service_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_service_plan_amount_dynamic.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_task.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_task_auto_resolve_trigger.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_task_department.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_task_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_task_role.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_temporary_member.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_trigger.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_trigger_assessment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_trigger_category.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_trigger_option.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.system_rule_trigger_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.user_external.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.user_screen_access_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.vas_billing_matrix_codes.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.vas_service_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.zip_code_distance.sql;

!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_additional_sign.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_changelog.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_member_sign.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_problem.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_problem_detail.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_problem_reference.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_problem_reference_need_range.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_problem_reference_tag.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_program.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_activities_and_supports.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_authorizations.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_back_ups.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_emergency_preparedness_plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_emergency_shelter_information.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_member_sign.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_schedule.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_services.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_service_plan_sign.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careplan_sign.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.careprovider.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.city.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.city_county.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_allergy.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_caregiver_contact.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_caremanager.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_cohort.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_communication_preference.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_condition.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_delegated_entity.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_emergency_contact.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_episode_managed_status.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_immunization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_memo.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_prescription.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_prescription_frequency_value.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_prescription_route_value.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_prescription_source.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_prescription_source_value.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_profile_changelog.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_profile_custom_field.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.client_special_needs.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cohort.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_auth_status_reason_cohorts.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_auth_status_reason_settings.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_auth_status_reason_statuses.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_auth_status_relation_settings.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_authorization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_authorization_attachment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_authorization_number.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_authorization_service_detail.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.common_ltss_authorization_service_note_history.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.country.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.county.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cpt_code.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.cpt_code_modifier.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.department.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.designation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.document_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.document_report.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.eav_general_careplan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.eav_general_careplan_ext.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode_changelog.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode_id_queue.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode_owner.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode_referral.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.episode_referral_sub_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.external_doc_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.external_doc_file_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.external_doc_import_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_additional_participant.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_assessment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_assessment_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_consent_to_enroll.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_mode.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_opting_out.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_reason_for_service.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_reason_for_service_complex.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_required_incidence.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interaction_verified_identity.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.interactions.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.language.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.letter_correspondence.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.letters_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.letters_file_attach.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.letters_template.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.letters_template_cover_page_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.lob.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.plan.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.plan_waiver.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.postal_code.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.primary_participant.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.primary_risk_score_values.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.region.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.roles.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_area.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_description_activity_link.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_description_service_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_description_service_unit.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_location.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_location_service_area.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_location_service_description.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_location_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.service_plan_reference.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_outcome.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_outcome_tag.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_reason_for_service_category.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_reason_for_service_sub_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_reason_for_service_sub_type_tag.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_reason_for_service_type.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interaction_reason_for_service_type_tag.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_interactions_reasons.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.sp_profile_custom_field_setting.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.special_needs.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.specialization.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.supervisor.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_attachment.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_memo.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_related_source.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_relation.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_standard_import_file.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.task_templates.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.termination_reason.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.unit_term.sql;
!load ../Schemas/upmcvh_prod/Views/upmcvh_prod.user_log_ins_history.sql;




----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
!set variable_substitution=false;
!exit