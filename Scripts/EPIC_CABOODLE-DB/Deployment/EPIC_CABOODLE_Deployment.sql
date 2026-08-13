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
--caboodle
!load ../schemas/dbo/views/epic_caboodle.dbo.analyticscontentfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.authorizationfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.bedrequestfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.birthfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.bpafact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.caremanagementcasefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.caremanagementteamfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.careplaneventmappingfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.careplanfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.checklisttaskfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.clinicalnotefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.continuingcarerequestfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.coveragedim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.dashboardusagefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.diagnosisdim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.diagnosisterminologydim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.drgeventfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilityeventfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilitytransactionalternatepayerfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilitytransactionbenefitfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilitytransactioncoveragefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilitytransactionerrorfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.eligibilitytransactionfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.employeedim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.employergrouprenewalfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.encounterfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.episodeencountermappingfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.episodefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.episodemonthlyoutcomedatamart_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.episodetypedim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.flowsheetrowdim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.flowsheettemplatedim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.flowsheetvaluefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.healthmaintenanceactionfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.healthplanappealgrievancefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.interfaceerroreventfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.interfacemessageeventfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.lineofbusinessdim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.medicationtherapyproblemfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.memberinsightdatamart_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.memberinsightfeedbackactionfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.messagerecipientfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.mtpsentcommunicationfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.patientdim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.pregnancyfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.proceduredim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.providerdim_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.qualityoutcomefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.referralfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.reportrunfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.requireddocumentationfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.riskadjustmentcomponentdatamart_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.riskadjustmentevidencefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.riskadjustmentmodeldatamart_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.riskadjustmentproviderauditfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialcarecommattemptpatientmappingfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialcarecommunicationattemptfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialcareepisodeeventfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialcareepisodefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialdeterminantfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialdeterminantpatientdomainfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.socialdeterminanttrendingdatamart_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.useractionlogactivityhourfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.useractionlogshiftfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.utilmgmtauthorizationrequestfact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.utilmgmtauthorizationrequestservicefact_vw.sql;
!load ../schemas/dbo/views/epic_caboodle.dbo.utilmgmtcoverageguidancerequestfact_vw.sql;
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