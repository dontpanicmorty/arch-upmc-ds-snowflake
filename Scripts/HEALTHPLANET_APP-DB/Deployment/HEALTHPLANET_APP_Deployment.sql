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
!load ../Schemas/DatabaseLevelObjects/DBO.schema.sql;
!load ../Schemas/DatabaseLevelObjects/audit.schema.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
-- None to Run
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--DBO
--DBO
--DBO
--DBO
----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--DBO
--DBO
--DBO
--DBO
----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--DBO
--DBO
--DBO
--DBO
----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--DBO
--DBO
--DBO
--DBO
----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
!load ../Schemas/audit/Views/audit.condition_center.sql;
!load ../Schemas/dbo/Views/dbo.bd_elgibility_subscriber.sql;
!load ../Schemas/dbo/Views/dbo.bd_enrollee_address.sql;
!load ../Schemas/dbo/Views/dbo.bd_enrollee.sql;
!load ../Schemas/dbo/Views/dbo.bd_group_package_network.sql;
!load ../Schemas/dbo/Views/dbo.bd_group_package.sql;
!load ../Schemas/dbo/Views/dbo.bd_group.sql;
!load ../Schemas/dbo/Views/dbo.bd_network_type.sql;
!load ../Schemas/dbo/Views/dbo.bd_network.sql;
!load ../Schemas/dbo/Views/dbo.bd_provider.sql;
!load ../Schemas/dbo/Views/dbo.cms_case.sql;
!load ../Schemas/dbo/Views/dbo.cms_contact.sql;
!load ../Schemas/dbo/Views/dbo.cms_level_of_care.sql;
!load ../Schemas/dbo/Views/dbo.mtn_act_action.sql;
!load ../Schemas/dbo/Views/dbo.mtn_activity_category.sql;
!load ../Schemas/dbo/Views/dbo.mtn_activity_response.sql;
!load ../Schemas/dbo/Views/dbo.mtn_case_status.sql;
!load ../Schemas/dbo/Views/dbo.mtn_condition_level.sql;
!load ../Schemas/dbo/Views/dbo.mtn_condition_program_module.sql;
!load ../Schemas/dbo/Views/dbo.mtn_condition_referral_type.sql;
!load ../Schemas/dbo/Views/dbo.mtn_contact_category.sql;
!load ../Schemas/dbo/Views/dbo.mtn_diag_proc_history.sql;
!load ../Schemas/dbo/Views/dbo.mtn_diag_proc_type.sql;
!load ../Schemas/dbo/Views/dbo.mtn_diag_proc.sql;
!load ../Schemas/dbo/Views/dbo.mtn_disease_category.sql;
!load ../Schemas/dbo/Views/dbo.mtn_goal_reason.sql;
!load ../Schemas/dbo/Views/dbo.mtn_goal.sql;
!load ../Schemas/dbo/Views/dbo.mtn_level_of_care.sql;
!load ../Schemas/dbo/Views/dbo.mtn_outcome.sql;
!load ../Schemas/dbo/Views/dbo.mtn_setting.sql;
!load ../Schemas/dbo/Views/dbo.mtn_staff_department.sql;
!load ../Schemas/dbo/Views/dbo.mtn_staff_designation.sql;
!load ../Schemas/dbo/Views/dbo.mtn_staff_specialty.sql;
!load ../Schemas/dbo/Views/dbo.mtn_staff_type.sql;
!load ../Schemas/dbo/Views/dbo.sec_staff.sql;
!load ../Schemas/dbo/Views/dbo.sys_care_program.sql;

--DBO
--DBO
--DBO
--DBO
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--DBO
--DBO
--DBO
--DBO

!exit