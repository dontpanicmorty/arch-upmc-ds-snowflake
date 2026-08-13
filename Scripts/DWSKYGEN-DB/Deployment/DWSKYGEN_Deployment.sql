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
!load ../Schemas/DatabaseLevelObjects/dbo.schema.sql;

!load ../Schemas/DatabaseLevelObjects/util.schema.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
!load ../Schemas/dbo/FileFormats/dbo.dwskygen_parquet_file_format.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
--dbo
!load ../Schemas/dbo/Stages/dbo.hpdsdatalake_dbextract_dwskygen.sql;

----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--util
!load ../Schemas/util/Tables/util.adf_loader_control.sql;
!load ../Schemas/util/Tables/util.adf_sproc_control.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
!load ../Schemas/dbo/Views/dbo.bridgeadjustmentgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeallowablerulegroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeapprovalgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebenefitplancodeset_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebenefitplannetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebrokeragency_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebrokercontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebrokerpayeecontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgebrokerpayeetaxentity_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgecheckbenefitplan_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeclientcontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgecodeset_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgecountyregion_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgecredentialingagentbenefitplan_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgecredentialingagentnetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgedenialgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgedeterminationreasonlanguage_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgediagcodesetcode_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgediagnosisgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgedomainsourcebenefitplan_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgedomainsourcenetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeenrolleelanguage_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeenrolleesupplementalidentifier_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationaccessrestrictions_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationhours_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationlanguages_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationmethodofservice_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgematerialplanperiodbenefitlevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgemodulefeatures_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgepayeesupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgepayeetaxentity_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeperiodbenefitlevelnetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgepremiumgroupcontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgepremiumtypesubscribercontracttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeprovideraccessrestrictions_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeproviderculturalcompetency_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeproviderlanguages_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeproviderlicensures_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeprovidernetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeprovidersimplespecialty_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgeprovidersupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgerolloverbenefitprocessing_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgerolloverbenefitqualifyingevent_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgespecialtygroupspecialty_vw.sql;
!load ../Schemas/dbo/Views/dbo.canary_table_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimaccessrestriction_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimaddreasoncode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimadjustmentgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimadjustmentreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimage_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimaging_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimallowablerule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimallowablerulegroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimappealinitiatortype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimappealresolutionlevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimappealtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimappealtypes_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimapproval_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimapprovalgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationflag_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationguideline_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationnotetype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationschedule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimauthorizationworkqueue_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitaccumulatorscope_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitaccumulatortype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitlevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitperiodtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitplan_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitplanattribute_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitplanescalationtier_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbenefitplanperiod_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillingadministrator_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillingattribute_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillinglevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillingprocessingstate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillingschedule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbillingtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimboardcertification_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbroker_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokeradjustmentreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokeradjustmenttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokercommissionpaymentstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokercommissionschedule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokercommissionstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokercontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokerlicensetype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokerpayee_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbrokerstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimbusinesstype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcallertype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcheck_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcheckingaccount_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclaimadjudication_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclaiminventoryissuetypes_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclaiminventorytype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclaimstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclaimtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclient_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimclientdeliquentcriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcodeset_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcodesubcodeset_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcommissiontype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcommunicationtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcompensationaccount_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcomplaintcategory_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcomplainttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcontact_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcontactresolution_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcontract_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcounty_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingagent_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingperiodstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingperiodstatusreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingperiodtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingrequirements_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingrequirementstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingrequirementstatusreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingsanctionreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingtrainingtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimcredentialingverificationsource_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimculturalcompetency_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdemographic_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdenial_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdenialgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdepartment_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdeterminationreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdeterminationreasonlanguage_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdeterminationstate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdiagnosiscode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdiagnosiscodeset_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdiagnosisgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdocument_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdocumentaccesslevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdocumentfiletype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdocumentstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdocumenttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdomain_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdomaingroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimdomainsource_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimeducationalinstutition_vw.sql;
!load ../Schemas/dbo/Views/dbo.DimEmploymentStatus_VW.sql;
!load ../Schemas/dbo/Views/dbo.dimenrollee_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimenrolleecontract_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimenrolleesupplementalidentifier_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimenrolleesupplementaltype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimentitytype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfacility_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfeature_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfeeschedule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfieldname_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimflag_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfollowupstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfulfillmentsources_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimfulfillmenttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.diminquirytype_vw.sql;
!load ../Schemas/dbo/Views/dbo.diminsurer_vw.sql;
!load ../Schemas/dbo/Views/dbo.diminventoryclaimtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.diminvoicecreditreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.diminvoiceitemtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlab_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlanguage_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlatepaymentinterestresubmitformulas_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlicensures_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlocation_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlocationhour_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlocationsupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimlogtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimmaterialallowanceformula_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimmaterialgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimmaterialplan_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimmethodofservice_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimmodule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimnetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimotheramountindicator_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpatientresponsibilityrule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpayee_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpayeesupplementalidentifier_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpaymentdeletionreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpaymentgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpaymentmethod_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpaymentrecipient_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimperiodbenefitlevel_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimphiaccesstype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimphirelationshipcode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimplaceofservice_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimplaceofservicetype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimportal_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgroupbillingcriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgroupdepartment_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgroupenrollmentcriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgrouppremiumtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumgroupsupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpremiumratechangereason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpricingrequeststatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprintexclusioncriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprocessinggroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprocessingstate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprovideraccessstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimproviderchangereason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimproviderentitytype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprovidermalpracticeinsurance_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprovidersimple_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimprovidersupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimproviderterminationreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimreasoncode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrecordsource_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrecordsourcesubtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrefundtype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimregion_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimreimbursementmethod_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimreimbursementschedule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrelationship_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimremovedpaymentstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimresolutionstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimresolutiontype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrolloverbenefit_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrolloverbenefitprocessing_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimrolloverqualifyingevent_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimservicestate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimspecialty_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimspecialtygroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimsqlrule_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimstate_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimsubcode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimsubcodegroup_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimsubscribercontracttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimsurface_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimtaxentity_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimterminationreasoncode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimtime_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimtooth_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimtransactionstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimtransactiontype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvendor_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvendorpaymentstatuses_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvendorpaymenttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvendorreasoncode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisionorderflag_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisionorderstatus_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisionordertype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisionredoreason_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisionredotype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimvisittype_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimwellnessprogram_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimworkqueue_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimzip_vw.sql;
!load ../Schemas/dbo/Views/dbo.factappealcomplaintgrievances_vw.sql;
!load ../Schemas/dbo/Views/dbo.factappealcomplaintgrievenceslifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factassignmentofbenefits_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationjournal_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationlifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationnotes_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationrequirements_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationresolutions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizations_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationservicenotes_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationserviceresolutions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.factauthorizationworkqueue_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitnoncoveredservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplancoinsurance_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplancopayments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplanprintexclusioncriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplanrolloverbenefits_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplanservicecopayments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitplanthresholds_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbenefitservicelimitations_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokercommissionadjustmentdetails_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokercommissionadjustments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokercommissions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokercommissionschedules_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokercommissionsdetail_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokerlicenses_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokerparticipation_vw.sql;
!load ../Schemas/dbo/Views/dbo.factbrokerpaymentcyclepayeechecks_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcheckregister_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcheckvendordata_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimimport_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaiminventory_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimlifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimotherinsurance_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimrecodedservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimresolutions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaims_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimserviceresolutions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclaimworkqueue_vw.sql;
!load ../Schemas/dbo/Views/dbo.factclientdeliquentpremiumcriteria_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcodeswitches_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcommunicationinquiries_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcommunications_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcoveragerules_vw.sql;
!load ../Schemas/dbo/Views/dbo.factcredentialingperiodlifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factdeletedclaimservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.factdocuments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factdomaingroupdocumenttypes_vw.sql;
!load ../Schemas/dbo/Views/dbo.facteligibility_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleebroker_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleefulfillmentrequests_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleeinvoiceadjustments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleeotherinsurance_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleeproviders_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenrolleesupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.factenterprisesystemfeatureusage_vw.sql;
!load ../Schemas/dbo/Views/dbo.factfeescheduledetail_vw.sql;
!load ../Schemas/dbo/Views/dbo.factfeeschedulefactors_vw.sql;
!load ../Schemas/dbo/Views/dbo.factfollowuplifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factfollowupnotes_vw.sql;
!load ../Schemas/dbo/Views/dbo.factinvoicedclaims_vw.sql;
!load ../Schemas/dbo/Views/dbo.factinvoicedenrollment_vw.sql;
!load ../Schemas/dbo/Views/dbo.factinvoicedenrollmentindividual_vw.sql;
!load ../Schemas/dbo/Views/dbo.factinvoicedpremiumrates_vw.sql;
!load ../Schemas/dbo/Views/dbo.factinvoicerevenueadjustment_vw.sql;
!load ../Schemas/dbo/Views/dbo.factlatepaymentinterestrules_vw.sql;
!load ../Schemas/dbo/Views/dbo.factmaterialplandetail_vw.sql;
!load ../Schemas/dbo/Views/dbo.factmaterialtradeoffs_vw.sql;
!load ../Schemas/dbo/Views/dbo.factmemberaccumulators_vw.sql;
!load ../Schemas/dbo/Views/dbo.factmemberlifecycle_vw.sql;
!load ../Schemas/dbo/Views/dbo.factnetworkparticipationexceptions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factnetworkreimbursementexceptions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factotheramounts_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpayeeadjustments_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpayeeadjustmentshistory_vw.sql;
!load ../Schemas/dbo/Views/dbo.factportalusage_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpredeterminationservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpremiumgroupbenefitplans_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpremiumgroupplanperiods_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpremiumgroupplanperiodsupplemental_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpremiumgrouppremiumrates_vw.sql;
!load ../Schemas/dbo/Views/dbo.factprerequisitecare_vw.sql;
!load ../Schemas/dbo/Views/dbo.factpricingrequests_vw.sql;
!load ../Schemas/dbo/Views/dbo.factproductguidelines_vw.sql;
!load ../Schemas/dbo/Views/dbo.factproviderboardcertification_vw.sql;
!load ../Schemas/dbo/Views/dbo.factprovidercredentialing_vw.sql;
!load ../Schemas/dbo/Views/dbo.factprovidercredentialingrequirements_vw.sql;
!load ../Schemas/dbo/Views/dbo.factprovidernetwork_vw.sql;
!load ../Schemas/dbo/Views/dbo.factproviderresidencies_vw.sql;
!load ../Schemas/dbo/Views/dbo.factproviderschooling_vw.sql;
!load ../Schemas/dbo/Views/dbo.factreceivables_vw.sql;
!load ../Schemas/dbo/Views/dbo.factreceivedpaymentdetail_vw.sql;
!load ../Schemas/dbo/Views/dbo.factrefunds_vw.sql;
!load ../Schemas/dbo/Views/dbo.factreimbursementscheduledetail_vw.sql;
!load ../Schemas/dbo/Views/dbo.factsecurityroles_vw.sql;
!load ../Schemas/dbo/Views/dbo.factservicedocumentrequirements_vw.sql;
!load ../Schemas/dbo/Views/dbo.factservices_vw.sql;
!load ../Schemas/dbo/Views/dbo.facttelephonestats_vw.sql;
!load ../Schemas/dbo/Views/dbo.facttransactions_vw.sql;
!load ../Schemas/dbo/Views/dbo.factvisionorders_vw.sql;
!load ../Schemas/dbo/Views/dbo.pesdw_runtimes_vw.sql;
!load ../Schemas/dbo/Views/dbo.premium_group_detail_vw.sql;
!load ../Schemas/dbo/Views/dbo.reconciliation_vw.sql;
!load ../Schemas/dbo/Views/dbo.refappealcomplaintgrievances_vw.sql;
!load ../Schemas/dbo/Views/dbo.refauthorizationserviceextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refbrokerparticipationdetailrejects_vw.sql;
!load ../Schemas/dbo/Views/dbo.refclaimextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refclaiminventory_vw.sql;
!load ../Schemas/dbo/Views/dbo.refclaiminventoryissues_vw.sql;
!load ../Schemas/dbo/Views/dbo.refclaimserviceadjustmentextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refclaimserviceextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refcodelocallanguages_vw.sql;
!load ../Schemas/dbo/Views/dbo.refcommunications_vw.sql;
!load ../Schemas/dbo/Views/dbo.refeligibilityrejects_vw.sql;
!load ../Schemas/dbo/Views/dbo.refenrolleephiaccess_vw.sql;
!load ../Schemas/dbo/Views/dbo.refenrolleereportingcategories_vw.sql;
!load ../Schemas/dbo/Views/dbo.refenterprisesystemconfiguration_vw.sql;
!load ../Schemas/dbo/Views/dbo.refinsuredcontracttype_vw.sql;
!load ../Schemas/dbo/Views/dbo.refinvoicerevenueadjustmentsextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refmemberaccumulatorsextended_vw.sql;
!load ../Schemas/dbo/Views/dbo.refpayeesdetailrejects_vw.sql;
!load ../Schemas/dbo/Views/dbo.refpaymentcyclepayeechecks_vw.sql;
!load ../Schemas/dbo/Views/dbo.refpremiumgroupplanperiodrejects_vw.sql;
!load ../Schemas/dbo/Views/dbo.refprovidercredentialingnotes_vw.sql;
!load ../Schemas/dbo/Views/dbo.reftaxentitywithholdings_vw.sql;
!load ../Schemas/dbo/Views/dbo.reftransactionexceptions_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_processing_reconciliation_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_reload_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_row_counts_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_schema_change_history_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_schema_vw.sql;
!load ../Schemas/dbo/Views/dbo.test_vw.sql;
!load ../Schemas/dbo/Views/dbo.vwperiodlimits_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationaccessibilityaccommodation_vw.sql;
!load ../Schemas/dbo/Views/dbo.bridgelocationpublictransportationmode_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimaccessibilityaccommodation_vw.sql;
!load ../Schemas/dbo/Views/dbo.dimpublictransportationmode_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_indexstatements_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_primarykey_vw.sql;
!load ../Schemas/dbo/Views/dbo.table_foreignkey_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------



!exit