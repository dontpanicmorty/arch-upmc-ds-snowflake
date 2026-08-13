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
!load ../Schemas/DatabaseLevelObjects/biteam.schema.sql;
!load ../Schemas/DatabaseLevelObjects/dbo.schema.sql;
!load ../Schemas/DatabaseLevelObjects/util.schema.sql;
!load ../Schemas/DatabaseLevelObjects/rds.schema.sql;
!load ../Schemas/DatabaseLevelObjects/assessment.schema.sql;


----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
-- None to Run
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--!load ../Schemas/UTIL/FileFormats/<filename>.sql

----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--util

----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--util

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--util

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
-- biteam
!load ../Schemas/biteam/Views/biteam.adt_discharge_disposition_codes.sql;
!load ../Schemas/biteam/Views/biteam.can_successful_cross_reference.sql;
!load ../Schemas/biteam/Views/biteam.census_final.sql;
!load ../Schemas/biteam/Views/biteam.dischargedispositionmaster.sql;
!load ../Schemas/biteam/Views/biteam.epic_gap_documentation_can.sql;
!load ../Schemas/biteam/Views/biteam.epic_hmd_documentation_can.sql;
!load ../Schemas/biteam/Views/biteam.epic_ond_documentation_can.sql;
!load ../Schemas/biteam/Views/biteam.epic_ongoing_documentation_can.sql;
!load ../Schemas/biteam/Views/biteam.epic_post_disch_can.sql;
!load ../Schemas/biteam/Views/biteam.epic_visit_documentation_can.sql;
!load ../Schemas/biteam/Views/biteam.master_member_eligibility_provider.sql;
!load ../Schemas/biteam/Views/biteam.masterpatienttype.sql;
!load ../Schemas/biteam/Views/biteam.mltss_assessment_data.sql;
!load ../Schemas/biteam/Views/biteam.mtm_base_yearly.sql;
!load ../Schemas/biteam/Views/biteam.mtm_can_yearly.sql;
!load ../Schemas/biteam/Views/biteam.mtm_med_review_yearly.sql;
!load ../Schemas/biteam/Views/biteam.pfworder.sql;
!load ../Schemas/biteam/Views/biteam.retention_rates_cpr_5yr_rolling.sql;
!load ../Schemas/biteam/Views/biteam.snp_has_assessment_data.sql;

--dbo
!load ../Schemas/dbo/Views/dbo.adt_admittypenew.sql;
!load ../Schemas/dbo/Views/dbo.adt_dischargedispositionnew.sql;
!load ../Schemas/dbo/Views/dbo.adt_patienttypenew.sql;
!load ../Schemas/dbo/Views/dbo.adt_pavillionnew.sql;
!load ../Schemas/dbo/Views/dbo.olap_bd_enrollee.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_activity.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_claim_note.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_dxproc.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_finalized.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_finalized_overturned.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_requested.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_authorization_requested_ids.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_case.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_case_custom.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_case_sbtest.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_contact.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_discharge.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_dxproc_sbtest.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_dxproc_tbd.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_flag.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_goal.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_intervention.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_level_of_care.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_ltr_sent.sql;
!load ../Schemas/dbo/Views/dbo.olap_cms_problem.sql;
!load ../Schemas/dbo/Views/dbo.olap_medipacreporting.sql;
!load ../Schemas/dbo/Views/dbo.olap_umclosedcase.sql;
!load ../Schemas/dbo/Views/dbo.olap_umopencase.sql;
!load ../Schemas/dbo/Views/dbo.vw_snp_has_with_icp.sql;
!load ../Schemas/dbo/Views/dbo.mtn_flag_category.sql;

--util

--rds
!load ../Schemas/rds/Views/rds.chc_has_assessment_data.sql;

--assessment
!load ../Schemas/assessment/Views/assessment.assessment.sql;
!load ../Schemas/assessment/Views/assessment.question_response.sql;
!load ../Schemas/assessment/Views/assessment.question_type.sql;
!load ../Schemas/assessment/Views/assessment.response_type.sql;
!load ../Schemas/assessment/Views/assessment.response.sql;
!load ../Schemas/assessment/Views/assessment.user_assessment_status.sql;
!load ../Schemas/assessment/Views/assessment.user_assessment.sql;
!load ../Schemas/assessment/Views/assessment.user_response.sql;
!load ../Schemas/assessment/Views/assessment.assessment_item.sql;
!load ../Schemas/assessment/Views/assessment.categorytype.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--util


!exit