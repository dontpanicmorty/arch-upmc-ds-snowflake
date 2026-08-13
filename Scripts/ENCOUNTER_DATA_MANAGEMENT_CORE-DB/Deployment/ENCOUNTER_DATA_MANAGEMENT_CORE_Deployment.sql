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
!load ../DatabaseLevelObjects/Schemas/cache.schema.sql;
!load ../DatabaseLevelObjects/Schemas/encounter.schema.sql;
!load ../DatabaseLevelObjects/Schemas/history.schema.sql;
!load ../DatabaseLevelObjects/Schemas/response.schema.sql;
!load ../DatabaseLevelObjects/Schemas/config.schema.sql;
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
--cache
!load ../Schemas/cache/views/cache.claimheader_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderadjustmentcode_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderambulancecertificationdetail_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercn1_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercobamount_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercobpayer_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercode_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercr3_vw.sql;
!load ../Schemas/cache/views/cache.claimheadercrccode_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderdate_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderdentaltoothstatus_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderflag_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderhcp_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderk3_vw.sql;
!load ../Schemas/cache/views/cache.claimheadermember_vw.sql;
!load ../Schemas/cache/views/cache.claimheadernte_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderprovider_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderpwk_vw.sql;
!load ../Schemas/cache/views/cache.claimheaderreferenceinformation_vw.sql;
!load ../Schemas/cache/views/cache.claimline_vw.sql;
!load ../Schemas/cache/views/cache.claimlineadjustmentcode_vw.sql;
!load ../Schemas/cache/views/cache.claimlineambulancecertificationdetail_vw.sql;
!load ../Schemas/cache/views/cache.claimlinecn1_vw.sql;
!load ../Schemas/cache/views/cache.claimlinecobamount_vw.sql;
!load ../Schemas/cache/views/cache.claimlinecr3_vw.sql;
!load ../Schemas/cache/views/cache.claimlinecrccode_vw.sql;
!load ../Schemas/cache/views/cache.claimlinedate_vw.sql;
!load ../Schemas/cache/views/cache.claimlinedentaltoothsurfacecode_vw.sql;
!load ../Schemas/cache/views/cache.claimlineedit_vw.sql;
!load ../Schemas/cache/views/cache.claimlinehcp_vw.sql;
!load ../Schemas/cache/views/cache.claimlinek3_vw.sql;
!load ../Schemas/cache/views/cache.claimlinente_vw.sql;
!load ../Schemas/cache/views/cache.claimlineprovider_vw.sql;
!load ../Schemas/cache/views/cache.claimlinepwk_vw.sql;
!load ../Schemas/cache/views/cache.claimlinereferenceinformation_vw.sql;
!load ../Schemas/cache/views/cache.claimsegmentextension_vw.sql;
!load ../Schemas/cache/views/cache.claimsegmentoutputresult_vw.sql;
!load ../Schemas/cache/views/cache.duplicateclaimresult_vw.sql;
!load ../Schemas/cache/views/cache.scrubresult_vw.sql;
--encounter
!load ../Schemas/encounter/views/encounter.adjdetail_vw.sql;
!load ../Schemas/encounter/views/encounter.adjdetailerrorcode_vw.sql;
!load ../Schemas/encounter/views/encounter.batch_vw.sql;
!load ../Schemas/encounter/views/encounter.batchformtype_vw.sql;
!load ../Schemas/encounter/views/encounter.claimedituserdetail_vw.sql;
!load ../Schemas/encounter/views/encounter.excludebrscrubforschedule_vw.sql;
!load ../Schemas/encounter/views/encounter.schedule_vw.sql;
!load ../Schemas/encounter/views/encounter.scheduleclaim_vw.sql;
!load ../Schemas/encounter/views/encounter.scheduleformtype_vw.sql;
!load ../Schemas/encounter/views/encounter.schedulescrublist_vw.sql;
!load ../Schemas/encounter/views/encounter.schedulesource_vw.sql;
!load ../Schemas/encounter/views/encounter.scheduletransactiontype_vw.sql;
!load ../Schemas/encounter/views/encounter.telemetrydata_vw.sql;
--history
!load ../Schemas/history/views/history.batchfileclaimdetail_vw.sql;
!load ../Schemas/history/views/history.batchfileoutbound_vw.sql;
!load ../Schemas/history/views/history.batchfileresponse_vw.sql;
!load ../Schemas/history/views/history.batchfileresponsedetail_vw.sql;
!load ../Schemas/history/views/history.batchfilesubmission_vw.sql;
!load ../Schemas/history/views/history.claim_vw.sql;
!load ../Schemas/history/views/history.claimdataaudit_vw.sql;
!load ../Schemas/history/views/history.claimsegmentpositiondetail_vw.sql;
!load ../Schemas/history/views/history.claimseriesdisposition_vw.sql;
!load ../Schemas/history/views/history.claimseriessubmission_vw.sql;
!load ../Schemas/history/views/history.claimsplitingcrosswalk_vw.sql;
!load ../Schemas/history/views/history.configurationaudit_vw.sql;
!load ../Schemas/history/views/history.donotsubmitclaimaudit_vw.sql;
!load ../Schemas/history/views/history.editmedicalclaimdetailsaudit_vw.sql;
!load ../Schemas/history/views/history.enrollmentscrublog_vw.sql;
!load ../Schemas/history/views/history.medicalclaimbatchfilesubmission_vw.sql;
!load ../Schemas/history/views/history.medicalclaimduplicatecheck_vw.sql;
!load ../Schemas/history/views/history.medicalclaimlinebatchfilesubmission_vw.sql;
!load ../Schemas/history/views/history.medicalclaimscrublog_vw.sql;
!load ../Schemas/history/views/history.medicalclaimsubmission_vw.sql;
!load ../Schemas/history/views/history.medicalclaimsubmissionaudit_vw.sql;
!load ../Schemas/history/views/history.membermaster_vw.sql;
!load ../Schemas/history/views/history.memberprofilebatchfilesubmission_vw.sql;
!load ../Schemas/history/views/history.memberprofilesubmission_vw.sql;
!load ../Schemas/history/views/history.scrublog_vw.sql;
!load ../Schemas/history/views/history.submission_vw.sql;
!load ../Schemas/history/views/history.supplementaldiagclaimbatchfilesubmission_vw.sql;
!load ../Schemas/history/views/history.supplementaldiagclaimscrublog_vw.sql;
!load ../Schemas/history/views/history.supplementaldiagclaimsubmission_vw.sql;
!load ../Schemas/history/views/history.supplementaldiagclaimsubmissionaudit_vw.sql;
--response
!load ../Schemas/response/views/response.renamed_277cabillingprovider_vw.sql;
!load ../Schemas/response/views/response.renamed_277cabillingproviderstatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277cabillingproviderstatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277capatient_vw.sql;
!load ../Schemas/response/views/response.renamed_277capatientclaim_vw.sql;
!load ../Schemas/response/views/response.renamed_277capatientclaimstatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277capatientclaimstatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277caresponse_vw.sql;
!load ../Schemas/response/views/response.renamed_277caresponsestatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277caresponsestatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277caserviceline_vw.sql;
!load ../Schemas/response/views/response.renamed_277caservicelinestatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277caservicelinestatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277drabillingprovider_vw.sql;
!load ../Schemas/response/views/response.renamed_277drabillingproviderstatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277drabillingproviderstatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277drapatient_vw.sql;
!load ../Schemas/response/views/response.renamed_277drapatientclaim_vw.sql;
!load ../Schemas/response/views/response.renamed_277drapatientclaimstatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277drapatientclaimstatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277draresponse_vw.sql;
!load ../Schemas/response/views/response.renamed_277draresponsestatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277draresponsestatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277draserviceline_vw.sql;
!load ../Schemas/response/views/response.renamed_277draservicelinestatus_vw.sql;
!load ../Schemas/response/views/response.renamed_277draservicelinestatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277uclaim_vw.sql;
!load ../Schemas/response/views/response.renamed_277uclaimprovider_vw.sql;
!load ../Schemas/response/views/response.renamed_277uclaimstatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277uclaimsubscriber_vw.sql;
!load ../Schemas/response/views/response.renamed_277userviceline_vw.sql;
!load ../Schemas/response/views/response.renamed_277uservicelinestatuscode_vw.sql;
!load ../Schemas/response/views/response.renamed_277utransactiongroup_vw.sql;
!load ../Schemas/response/views/response.renamed_999acknowledgementerror_vw.sql;
!load ../Schemas/response/views/response.renamed_999acknowledgementgroup_vw.sql;
!load ../Schemas/response/views/response.renamed_999acknowledgementtssyntaxerrormapping_vw.sql;
!load ../Schemas/response/views/response.renamed_999acknowlegementts_vw.sql;
!load ../Schemas/response/views/response.renamed_999contextelementerror_vw.sql;
!load ../Schemas/response/views/response.renamed_999contextsegmenterror_vw.sql;
!load ../Schemas/response/views/response.renamed_999dataelementnote_vw.sql;
!load ../Schemas/response/views/response.renamed_999errorclaim_vw.sql;
!load ../Schemas/response/views/response.crencounter_vw.sql;
!load ../Schemas/response/views/response.crencounterdetail_vw.sql;
!load ../Schemas/response/views/response.crencounterstatuscode_vw.sql;
!load ../Schemas/response/views/response.mao001detail_vw.sql;
!load ../Schemas/response/views/response.mao001header_vw.sql;
!load ../Schemas/response/views/response.mao001trailer_vw.sql;
!load ../Schemas/response/views/response.mao002detail_vw.sql;
!load ../Schemas/response/views/response.mao002error_vw.sql;
!load ../Schemas/response/views/response.mao002header_vw.sql;
!load ../Schemas/response/views/response.mao002trailer_vw.sql;
!load ../Schemas/response/views/response.mao004detail_vw.sql;
!load ../Schemas/response/views/response.mao004header_vw.sql;
!load ../Schemas/response/views/response.mao004trailer_vw.sql;
!load ../Schemas/response/views/response.responsefile_vw.sql;
!load ../Schemas/response/views/response.ta1segmentacknowledgement_vw.sql;
--Config
!load ../Schemas/config/views/config.encounterresponsestatus_vw.sql;
!load ../Schemas/config/views/config.claimstatuscode_vw.sql;
!load ../Schemas/config/views/config.claimstatuscodelevel_vw.sql;
!load ../Schemas/config/views/config.scrub_vw.sql;
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
!set variable_substitution=false;
!exit