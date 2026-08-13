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
!load ../Schemas/DatabaseLevelObjects/Schemas/dimdata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/infa.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/logdata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/odsdata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/reportdata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/stage_reportdata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/stagedata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/util.sql;
--!load ../Schemas/DatabaseLevelObjects/Schemas/edw_usr_tab.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/referencedata.sql;
!load ../Schemas/DatabaseLevelObjects/Schemas/rawdata.sql;


----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
!load ../Schemas/dimdata/Stages/dimdata.hpdsdatalake_idapsql_idapfull.sql;
!load ../Schemas/infa/Stages/infa.snowflakedata_stagedata.sql;
!load ../Schemas/odsdata/Stages/odsdata.hpdsdatalake_idapsql.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--dimdata
!load ../Schemas/dimdata/FileFormats/dimdata.idap_csv_file_format_notnull_quoted.sql;
!load ../Schemas/dimdata/FileFormats/dimdata.idap_csv_file_format_notnull.sql;
!load ../Schemas/dimdata/FileFormats/dimdata.idap_csv_file_format_nullable_quoted.sql;
!load ../Schemas/dimdata/FileFormats/dimdata.idap_csv_file_format_nullable.sql;
--infa
!load ../Schemas/infa/FileFormats/infa.idap_csv_file_format_notnull_quoted.sql;
!load ../Schemas/infa/FileFormats/infa.idap_csv_file_format_notnull.sql;
!load ../Schemas/infa/FileFormats/infa.idap_csv_file_format_nullable_quoted.sql;
!load ../Schemas/infa/FileFormats/infa.idap_csv_file_format_nullable.sql;

--stagedata
!load ../Schemas/stagedata/FileFormats/stagedata.ml_json_format.sql;

--odsdata
!load ../Schemas/odsdata/FileFormats/odsdata.provider_ods_file_format.sql;
!load ../Schemas/odsdata/FileFormats/odsdata.provider_ods_practitioner_file_format.sql;

--util
!load ../Schemas/util/FileFormats/util.db_extract_parquet_file_format.sql;
----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--dimdata
!load ../Schemas/dimdata/Sequences/dimdata.dim_provider_identifier_key_seq.sql;

----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--odsdata
/*

******COMMENTED OUT 2024/02/29 Not being used!  GG

!load ../Schemas/odsData/Tables/odsData.Accreditation_Agency.sql
!load ../Schemas/odsData/Tables/odsData.Data_Source.sql
!load ../Schemas/odsData/Tables/odsData.Accreditation_Agency_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Country.sql
!load ../Schemas/odsData/Tables/odsData.State.sql
!load ../Schemas/odsData/Tables/odsData.Address.sql
!load ../Schemas/odsData/Tables/odsData.Address_Specialty_Service_Area_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Address_Usage_Type.sql
!load ../Schemas/odsData/Tables/odsData.Address_Usage_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Board_Certification.sql
!load ../Schemas/odsData/Tables/odsData.Board_Certification_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Board_Certification_Status.sql
!load ../Schemas/odsData/Tables/odsData.Board_Certification_Status_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Care_Type.sql
!load ../Schemas/odsData/Tables/odsData.Contract_Level.sql
!load ../Schemas/odsData/Tables/odsData.Contract_Level_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Degree.sql
!load ../Schemas/odsData/Tables/odsData.Degree_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Education_Type.sql
!load ../Schemas/odsData/Tables/odsData.Education_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Educational_Department.sql
!load ../Schemas/odsData/Tables/odsData.Educational_Department_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.EMR_System.sql
!load ../Schemas/odsData/Tables/odsData.EMR_System_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Physician_Hospital_Organization.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Role_Type.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Sub_Type.sql
!load ../Schemas/odsData/Tables/odsData.TPA_Hierarchy.sql
!load ../Schemas/odsData/Tables/odsData.Provider.sql
!load ../Schemas/odsData/Tables/odsData.Facility.sql
!load ../Schemas/odsData/Tables/odsData.Facility_Accreditation_Agency_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Gender.sql
!load ../Schemas/odsData/Tables/odsData.Institution.sql
!load ../Schemas/odsData/Tables/odsData.Institution_Address_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Institution_Function.sql
!load ../Schemas/odsData/Tables/odsData.Institution_Function_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Institution_Function_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Language.sql
!load ../Schemas/odsData/Tables/odsData.Language_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Language_Support.sql
!load ../Schemas/odsData/Tables/odsData.Language_Support_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.License_Status.sql
!load ../Schemas/odsData/Tables/odsData.License_Status_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.License_Type.sql
!load ../Schemas/odsData/Tables/odsData.License_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Line_Of_Business.sql
!load ../Schemas/odsData/Tables/odsData.Medical_Group.sql
!load ../Schemas/odsData/Tables/odsData.Product.sql
!load ../Schemas/odsData/Tables/odsData.Product_Type.sql
!load ../Schemas/odsData/Tables/odsData.Network.sql
!load ../Schemas/odsData/Tables/odsData.Owning_Medical_Group_Office_Status.sql
!load ../Schemas/odsData/Tables/odsData.Patient_Restriction.sql
!load ../Schemas/odsData/Tables/odsData.Patient_Restriction_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Pharmacy.sql
!load ../Schemas/odsData/Tables/odsData.Pharmacy_Type.sql
!load ../Schemas/odsData/Tables/odsData.Pharmacy_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Physician_Hospital_Organization_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Practitioner.sql
!load ../Schemas/odsData/Tables/odsData.Practitioner_Board_Certification_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Practitioner_Education_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Product_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Product_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Ownership_Status.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Termination_Type.sql
!load ../Schemas/odsData/Tables/odsData.Termination_Reason.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Contract.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Contract_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Language_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Week_Day.sql
!load ../Schemas/odsData/Tables/odsData.Schedule_Type.sql
!load ../Schemas/odsData/Tables/odsData.Time.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Schedule_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Service_Category.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Service_Category_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Address_Specialty_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Affiliation_Gateway_Type.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Affiliation_Type.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Affiliation_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Institution_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Language_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_License_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Ownership_Status_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Rel_Type.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Provider_Role_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Schedule_Hold.sql
!load ../Schemas/odsData/Tables/odsData.Schedule_Type_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Service_Area.sql
!load ../Schemas/odsData/Tables/odsData.Service_Area_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Service_Category_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Care_Type_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Category.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Category_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Category_Specialty_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Specialty_Line_Of_Business_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Termination_Reason_Data_Source_Rel.sql
!load ../Schemas/odsData/Tables/odsData.Termination_Type_Data_Source_Rel.sql
*/
--rawdata
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_authorization_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_authorization_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_adjustment_reason_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_not_covered_reason_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_procedure_category_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_procedure_modifier_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_processing_reason_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_detail_service_reason_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_diagnosis_related_group.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_header_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_header_icd_diagnosis_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_claim_header_icd_procedure_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_drug_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_pharmacy_claim_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_pharmacy_claim_header_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_pharmacy_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_pharmacy_prescriber_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_member_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_provider_detail_base.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_provider_identifier.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_refdata_claim_icd_diagnosis_category.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_rider_codes.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_refdata_claim_procedure_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_refdata_claim_revenue_code.sql;
!load ../Schemas/rawdata/Tables/rawdata.datahub_refdata_data_source.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_APPermanentPayment.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_APPermanentPayment_GL.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_APWork.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_APWork_GL.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_Claims.sql;
!load ../Schemas/rawdata/Tables/rawdata.MC400_Dwoao_ClaimsDetail.sql;

--stagedata
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Adjustment_Reason_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Adjustment_Reason_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Not_Covered_Reason_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Not_Covered_Reason_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Procedure_Category_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Procedure_Category_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Procedure_Modifier_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Procedure_Modifier_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Service_Reason_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Detail_Service_Reason_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_ICD_Diagnosis_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_ICD_Diagnosis_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_ICD_Procedure_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_ICD_Procedure_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_Rider_Code.sql;
!load ../Schemas/stagedata/Tables/stagedata.Claim_Header_Rider_Code_Grp.sql;
!load ../Schemas/stagedata/Tables/stagedata.Data_Source.sql;
!load ../Schemas/stagedata/Tables/stagedata.Deleted_Document.sql;
!load ../Schemas/stagedata/Tables/stagedata.Diagnosis_Related_Group.sql;
!load ../Schemas/stagedata/Tables/stagedata.Dim_Enrollment_Span_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Dim_Diagnosis_Related_Group_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Drug.sql;
!load ../Schemas/stagedata/Tables/stagedata.Fact_Claim_Line_Datahub.sql;
!load ../Schemas/stagedata/Tables/stagedata.Fact_Claim_Line_MarkLogic.sql;
!load ../Schemas/stagedata/Tables/stagedata.FSS_Claims_Data.sql;
!load ../Schemas/stagedata/Tables/stagedata.FSS_Decision_Data.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Adjustment_Reason_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Adjustment_Reason.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Claim_Rider_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Claim_Rider.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_ICD_Diagnosis_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_ICD_Diagnosis.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_ICD_Procedure_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_ICD_Procedure.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Not_Covered_Reason_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Not_Covered_Reason.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Procedure_Category_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Procedure_Category.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Procedure_Modifier_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Procedure_Modifier.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Service_Reason_Lookup.sql;
!load ../Schemas/stagedata/Tables/stagedata.Grp_Service_Reason.sql;
!load ../Schemas/stagedata/Tables/stagedata.Member_Demographic.sql;
!load ../Schemas/stagedata/Tables/stagedata.Provider_Address.sql;
!load ../Schemas/stagedata/Tables/stagedata.Provider_Detail.sql;
!load ../Schemas/stagedata/Tables/stagedata.Provider_ODS_Data_Source.sql;
!load ../Schemas/stagedata/Tables/stagedata.Reference_Data_Singular.sql;

--dimdata
!load ../Schemas/dimdata/Tables/dimdata.Dim_TPA_Hierarchy.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Data_Source.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Date_Day.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_App_Device.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_App_Event_Parameter.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_App_Event.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Claim_Authorization.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Claim_Authorization_Detail.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Claim_Detail.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Claim_Header.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Claim_Procedure.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Diagnosis_Related_Group.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Drug.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Eligibility_Type.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Enrollment_Span.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Facility_Accreditation.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Financial_Service_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_GL_Distribution.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Group.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_ICD_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_ICD_Diagnosis.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_ICD_Procedure.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Language.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Member.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Member_Address.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Member_Demographic.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Member_Identifier.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Not_Covered_Reason.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Office_Hours.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Pharmacy_Claim_Detail.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Pharmacy_Claim_Header.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Place_Of_Service.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Plan.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Plan_Segment.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Practitioner_Education.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Procedure_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Procedure_Modifier.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Processing_Reason.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Address.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Affiliation.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Certification.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Contact_Info.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Contract.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Contract_Attribute.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Identifier.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Specialty.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Provider_Taxonomy.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Rate_Cell.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Rider.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Sales_Channel.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Sub_Group.sql;
!load ../Schemas/dimdata/Tables/dimdata.Dim_Revenue_Procedure.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_App_Event_Parameter.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Claim_Detail_Authorization_Detail.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Claim_Detail_Financial_Service_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Facility_Accreditation.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_ICD_Diagnosis_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_ICD_Procedure_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Practitioner_Education.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Provider_Affiliation.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Provider_Language.sql;
!load ../Schemas/dimdata/Tables/dimdata.Provider_Specialty_Grouping.sql;
!load ../Schemas/dimdata/Tables/dimdata.Bridge_Provider_Specialty.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Adjustment_Reason.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Claim_Rider.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_ICD_Diagnosis.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_ICD_Procedure.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Not_Covered_Reason.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Procedure_Category.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Procedure_Modifier.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_ICD_Diagnosis_Flat.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Procedure_Modifier_Flat.sql;
!load ../Schemas/dimdata/Tables/dimdata.Grp_Service_Reason.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_App_Mobile_Event.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Claim_Authorization_Detail.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Claim_Line.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Enrollment.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Enrollment_Snapshot.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Pharmacy_Claim_Line.sql;
!load ../Schemas/dimdata/Tables/dimdata.Fact_Provider_Contract.sql;

--referencedata
!load ../Schemas/referencedata/Tables/referencedata.member_network_templates.sql;
!load ../Schemas/referencedata/Tables/referencedata.provdir_behavioral_health_vendor_crosswalk.sql;
!load ../Schemas/referencedata/Tables/referencedata.provdir_service_area_product.sql;
!load ../Schemas/referencedata/Tables/referencedata.provdir_service_area_sub_product.sql;
!load ../Schemas/referencedata/Tables/referencedata.provider_network_crosswalk.sql;
-- These materialized view that act as tables need to be created now for dependency reasons
!load ../Schemas/dimdata/Views/dimdata.Dim_Adjustment_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Copay_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Coinsurance_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Deductible_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Not_Covered_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Service_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_Address_Physical_vw.sql

--infa
!load ../Schemas/infa/Tables/infa.Bridge_Facility_Accreditation.sql;
!load ../Schemas/infa/Tables/infa.Bridge_Practitioner_Education.sql;
!load ../Schemas/infa/Tables/infa.Bridge_Provider_Affiliation.sql;
!load ../Schemas/infa/Tables/infa.Bridge_Provider_Language.sql;
!load ../Schemas/infa/Tables/infa.Bridge_Provider_Specialty.sql;
!load ../Schemas/infa/Tables/infa.Dim_Date_Day.sql;
!load ../Schemas/infa/Tables/infa.Dim_Eligibility_Type.sql;
!load ../Schemas/infa/Tables/infa.Dim_Enrollment_Span.sql;
!load ../Schemas/infa/Tables/infa.Dim_Facility_Accreditation.sql;
!load ../Schemas/infa/Tables/infa.Dim_GL_Distribution.sql;
!load ../Schemas/infa/Tables/infa.Dim_Group.sql;
!load ../Schemas/infa/Tables/infa.Dim_Language.sql;
!load ../Schemas/infa/Tables/infa.Dim_Member.sql;
!load ../Schemas/infa/Tables/infa.Dim_Member_Address.sql;
!load ../Schemas/infa/Tables/infa.Dim_Member_Identifier.sql;
!load ../Schemas/infa/Tables/infa.Dim_Office_Hours.sql;
!load ../Schemas/infa/Tables/infa.Dim_Plan.sql;
!load ../Schemas/infa/Tables/infa.Dim_Plan_Segment.sql;
!load ../Schemas/infa/Tables/infa.Dim_Practitioner_Education.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Address.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Affiliation.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Certification.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Contact_Info.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Contract.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Contract_Attribute.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Identifier.sql;
!load ../Schemas/infa/Tables/infa.Dim_Provider_Specialty.sql;
!load ../Schemas/infa/Tables/infa.Dim_Rate_Cell.sql;
!load ../Schemas/infa/Tables/infa.Dim_Rider.sql;
!load ../Schemas/infa/Tables/infa.Dim_Sales_Channel.sql;
!load ../Schemas/infa/Tables/infa.Dim_Sub_Group.sql;
!load ../Schemas/infa/Tables/infa.Dim_TPA_Hierarchy.sql;
!load ../Schemas/infa/Tables/infa.Fact_Enrollment.sql;
!load ../Schemas/infa/Tables/infa.Fact_Enrollment_Snapshot.sql;
!load ../Schemas/infa/Tables/infa.Fact_Provider_Contract.sql;
!load ../Schemas/infa/Tables/infa.Provider_Specialty_Grouping.sql;

--logdata
!load ../Schemas/logdata/Tables/logdata.Build_Validation_Result.sql;
!load ../Schemas/logdata/Tables/logdata.FSS_Table_Load_History.sql;
!load ../Schemas/logdata/Tables/logdata.Table_Load_History.sql;
!load ../Schemas/logdata/Tables/logdata.Job_Log.sql;
!load ../Schemas/logdata/Tables/logdata.Data_Validation_Result.sql;
!load ../Schemas/logdata/Tables/logdata.Build_Threshold_Result.sql;

--util
!load ../Schemas/util/Tables/util.ml_json_dependencies.sql;
!load ../Schemas/util/Tables/util.ml_stage_domain.sql;
!load ../Schemas/util/Tables/util.ml_stage_entity.sql;
!load ../Schemas/util/Tables/util.ml_stage_domain_to_entity.sql;
!load ../Schemas/util/Tables/util.Threshold_Validation.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------


--logdata
!load ../Schemas/logdata/Functions/logdata.fxn_get_pk_columns.sqlproc;
!load ../Schemas/logdata/Functions/logdata.fxn_get_uk_columns.sqlproc;

--rawdata
!load ../Schemas/rawdata/Functions/rawdata.fxn_get_claim_line_nbr_mc400.sql;
!load ../Schemas/rawdata/Functions/rawdata.fxn_get_claim_line_procedure_adj_code_mc400.sql;

-- dimdata
!load ../Schemas/dimdata/Functions/dimdata.fxn_mask_field(date,varchar).sqlproc;
!load ../Schemas/dimdata/Functions/dimdata.fxn_mask_field(double,varchar).sqlproc;
!load ../Schemas/dimdata/Functions/dimdata.fxn_mask_field(number,varchar).sqlproc;
!load ../Schemas/dimdata/Functions/dimdata.fxn_mask_field(timestamp,varchar).sqlproc;
!load ../Schemas/dimdata/Functions/dimdata.fxn_mask_field(varchar,varchar).sqlproc;

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--rawdata
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_authorization_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_authorization_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_adjustment_reason_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_not_covered_reason_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_procedure_category_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_procedure_modifier_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_processing_reason_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_detail_service_reason_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_diagnosis_related_group_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_header_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_header_icd_diagnosis_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_claim_header_icd_procedure_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_drug_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_pharmacy_claim_header_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_pharmacy_claim_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_pharmacy_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_pharmacy_prescriber_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_drug_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_member_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_provider_detail_base_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_provider_identifier_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_refdata_claim_icd_diagnosis_category_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_rider_codes_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_refdata_claim_procedure_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_refdata_claim_revenue_code_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.datahub_refdata_data_source_select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_APPermanentPayment_Select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_APPermanentPayment_GL_Select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_APWork_Select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_APWork_GL_Select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_Claims_Select_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.MC400_Dwoao_ClaimsDetail_Select_vw.sql;

--stagedata
!load ../Schemas/stagedata/Views/stagedata.Apim_Logs_Mobile_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Deleted_Document_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Reference_Data_Singular_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Reference_Data_Singular_Current_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Reference_Data_Singular_Child_Ids_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Provider_Detail_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Header_Raw_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Header_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_Raw_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_Adjustment_Reason_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_Not_Covered_Reason_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_Procedure_Category_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Detail_Procedure_Modifier_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Header_ICD_Diagnosis_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Header_ICD_Procedure_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Claim_Header_Rider_Codes_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Diagnosis_Related_Group_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_App_Device_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_App_Event_Parameter_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_App_Event_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Member_Demographic_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Provider_Detail_Identifiers_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Claim_Authorization_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Claim_Authorization_Detail_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Claim_Detail_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Claim_Header_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Claim_Procedure_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Data_Source_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Diagnosis_Related_Group_Lookup_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Diagnosis_Related_Group_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Drug_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Financial_Service_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_ICD_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_ICD_Diagnosis_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_ICD_Procedure_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Not_Covered_Reason_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Pharmacy_Claim_Detail_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Pharmacy_Claim_Header_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Place_Of_Service_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Procedure_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Procedure_Modifier_select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Processing_Reason_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Provider_MarkLogic_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Provider_Upmchp_Datahub_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Provider_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Provider_Identifier_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Rider_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Revenue_Procedure_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Pharmacy_Dim_Provider_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Pharmacy_Dim_Provider_Address_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Pharmacy_Dim_Provider_Contact_Info_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Pharmacy_Dim_Provider_Identifier_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Pharmacy_Dim_Provider_Taxonomy_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Bridge_App_Event_Parameter_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Bridge_Claim_Detail_Authorization_Detail_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Bridge_Claim_Detail_Financial_Service_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Bridge_ICD_Diagnosis_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Bridge_ICD_Procedure_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Adjustment_Reason_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Claim_Rider_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_ICD_Diagnosis_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_ICD_Procedure_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Not_Covered_Reason_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Procedure_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Procedure_Modifier_select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Service_Reason_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_ICD_Diagnosis_Flat_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Grp_Procedure_Modifier_Flat_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_App_Mobile_Event_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_Claim_Authorization_Detail_Upmchp_Datahub_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_Claim_Line_MarkLogic_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_Claim_Line_Upmchp_Datahub_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_Claim_Line_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Fact_Pharmacy_Claim_Line_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Dim_Provider_Upmchp_Datahub_Select_Vw.sql;
!load ../Schemas/stagedata/Views/stagedata.FSS_Claims_Data_Select_vw.sql;

--dimdata
!load ../Schemas/dimdata/Views/dimdata.Dim_App_Device_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_App_Event_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_App_Event_Parameter_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_TPA_Hierarchy_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Data_Source_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Date_Day_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Claim_Authorization_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Claim_Authorization_Detail_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Claim_Detail_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Claim_Header_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Claim_Procedure_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Diagnosis_Related_Group_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Drug_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Eligibility_Type_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Enrollment_Span_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Facility_Accreditation_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Financial_Service_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_GL_Distribution_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Group_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_ICD_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_ICD_Diagnosis_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_ICD_Procedure_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Language_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_Address_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_Demographic_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_Identifier_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Office_Hours_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Pharmacy_Claim_Detail_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Pharmacy_Claim_Header_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Place_Of_Service_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Plan_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Plan_Segment_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Practitioner_Education_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Procedure_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Procedure_Modifier_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Processing_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Address_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Affiliation_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Certification_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Contact_Info_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Contract_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Contract_Attribute_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Identifier_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Specialty_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Provider_Taxonomy_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Rate_Cell_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Rider_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Sales_Channel_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Sub_Group_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_App_Event_Parameter_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Claim_Detail_Authorization_Detail_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Claim_Detail_Financial_Service_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Facility_Accreditation_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_ICD_Diagnosis_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_ICD_Procedure_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Practitioner_Education_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Provider_Affiliation_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Provider_Language_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Provider_Specialty_Grouping_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Bridge_Provider_Specialty_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Adjustment_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Claim_Rider_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_ICD_Diagnosis_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_ICD_Procedure_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Not_Covered_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Procedure_Category_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Procedure_Modifier_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Service_Reason_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_ICD_Diagnosis_Flat_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Grp_Procedure_Modifier_Flat_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_App_Mobile_Event_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Claim_Authorization_Detail_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Claim_Line_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Enrollment_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Enrollment_Snapshot_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Pharmacy_Claim_Line_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_Provider_Contract_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Empi_Provider_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Fact_QuickStats_Finance_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Member_Address_Physical_vw.sql;
!load ../Schemas/dimdata/Views/dimdata.Dim_Revenue_Procedure_vw.sql;

--edw_rpt

--edw_usr_tab
--!load ../Schemas/edw_usr_tab/Views/edw_usr_tab.cm_dental_claims.sql;

--reportdata
!load ../Schemas/reportdata/Views/reportdata.member_preferences_commercial_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_preferences_medicare_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_preferences_off_exchange_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_preferences_on_exchange_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.plantype_lkp_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_dental_Claims_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_dental_Enrollment_vw.sql;
!load ../Schemas/reportdata/Views/reportdata.member_demographics_vw.sql;

--odsdata
!load ../Schemas/odsdata/Views/odsdata.Accreditation_Agency_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Accreditation_Agency_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Address_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Address_Specialty_Service_Area_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Address_Usage_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Address_Usage_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Board_Certification_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Board_Certification_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Board_Certification_Status_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Board_Certification_Status_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Care_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Contract_Level_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Contract_Level_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Country_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Data_Source_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Degree_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Degree_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Educational_Department_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Educational_Department_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Education_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Education_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.EMR_System_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.EMR_System_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Facility_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Facility_Accreditation_Agency_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Gender_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Institution_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Institution_Address_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Institution_Function_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Institution_Function_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Institution_Function_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Language_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Language_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Language_Support_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Language_Support_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.License_Status_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.License_Status_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.License_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.License_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Line_Of_Business_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Medical_Group_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Network_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Owning_Medical_Group_Office_Status_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Patient_Restriction_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Patient_Restriction_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Pharmacy_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Pharmacy_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Pharmacy_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Physician_Hospital_Organization_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Physician_Hospital_Organization_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Practitioner_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Practitioner_Board_Certification_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Practitioner_Education_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Product_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Product_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Product_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Product_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Contract_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Language_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Schedule_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Service_Category_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Address_Specialty_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Affiliation_Gateway_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Affiliation_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Affiliation_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Contract_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Institution_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Language_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_License_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Ownership_Status_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Ownership_Status_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Rel_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Role_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Role_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Provider_Sub_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Schedule_Hold_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Schedule_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Schedule_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Service_Area_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Service_Area_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Service_Category_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Service_Category_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Care_Type_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Category_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Category_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Category_Specialty_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Specialty_Line_Of_Business_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.State_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Termination_Reason_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Termination_Reason_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Termination_Type_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Termination_Type_Data_Source_Rel_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Time_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.TPA_Hierarchy_vw.sql;
!load ../Schemas/odsdata/Views/odsdata.Week_Day_vw.sql;

----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--infa
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Bridge_Facility_Accreditation_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Bridge_Practitioner_Education_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Bridge_Provider_Affiliation_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Bridge_Provider_Language_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Bridge_Provider_Specialty_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Date_Day_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Eligibility_Type_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Enrollment_Span_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Facility_Accreditation_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_GL_Distribution_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Group_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Language_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Member_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Member_Address_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Member_Identifier_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Office_Hours_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Plan_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Plan_Segment_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Practitioner_Education_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Address_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Affiliation_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Certification_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Contact_Info_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Contract_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Contract_Attribute_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Identifier_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Provider_Specialty_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Rate_Cell_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Rider_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Sales_Channel_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_Sub_Group_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Dim_TPA_Hierarchy_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Fact_Enrollment_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Fact_Provider_Contract_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Provider_Specialty_Grouping_FROM_STAGE.sqlproc;
!load ../Schemas/infa/StoredProcedures/infa.spu_Merge_Fact_Enrollment_Snapshot_FROM_STAGE.sqlproc;

--util
!load ../Schemas/util/StoredProcedures/util.spu_get_ml_dependencies.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_get_uk_columns.sqlproc;
!load ../Schemas/util/StoredProcedures/util.spu_set_query_tag.sqlproc;

--rawdata
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_authorization_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_authorization_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_adjustment_reason_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_not_covered_reason_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_procedure_category_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_procedure_modifier_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_processing_reason_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_detail_service_reason_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_datahub_claim_diagnosis_related_group.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_header_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_header_icd_diagnosis_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_claim_header_icd_procedure_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_drug_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_pharmacy_claim_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_pharmacy_claim_header_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_pharmacy_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_pharmacy_prescriber_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_member_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_provider_detail_base.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_provider_identifier.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_refdata_claim_icd_diagnosis_category.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_rider_codes.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_refdata_claim_procedure_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_refdata_claim_revenue_code.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_datahub_refdata_data_source.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_APPermanentPayment.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_APPermanentPayment_GL.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_APWork.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_APWork_GL.sqlproc;

!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_Claims.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_Load_MC400_Dwoao_ClaimsDetail.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_rawdata_schema.sqlproc;

--stagedata

!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Delete_Stagedata_Table.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_FSS_Decision_Algorithm_CHC_Part1.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_FSS_Decision_Algorithm_CHC_Part2.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_FSS_Decision_Algorithm_Non_CHC_Part1.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_FSS_Decision_Algorithm_Non_CHC_Part2.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Adjustment_Reason_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Adjustment_Reason_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Not_Covered_Reason_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Not_Covered_Reason_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Procedure_Category_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Procedure_Category_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Procedure_Modifier_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Procedure_Modifier_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Service_Reason_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Detail_Service_Reason_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_ICD_Diagnosis_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_ICD_Diagnosis_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_ICD_Procedure_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_ICD_Procedure_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_Rider_Code.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Claim_Header_Rider_Code_Grp.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Dim_Diagnosis_Related_Group_Lookup.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Dim_Enrollment_Span_Lookup.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_FSS_Claims_Data.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Adjustment_Reason.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Claim_Rider.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_ICD_Diagnosis.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_ICD_Procedure.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Lookup_Tables.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Not_Covered_Reason.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Procedure_Category.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Procedure_Modifier.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_Grp_Service_Reason.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_ML_Files_To_Stage.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_StageData_Table.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Load_StageData_Table_Deleted_Document.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_Temp_Claim_Detail_Dedupe.sqlproc;

--dimdata
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Bridge_App_Event_Parameter.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Bridge_Claim_Detail_Authorization_Detail.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Bridge_Claim_Detail_Financial_Service_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Bridge_ICD_Diagnosis_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Bridge_ICD_Procedure_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Claim_Dimensions.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_App_Device.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_App_Event_Parameter.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_App_Event.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Claim_Authorization.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Claim_Authorization_Detail.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Claim_Detail.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Claim_Header.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Claim_Procedure.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Data_Source.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Diagnosis_Related_Group.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Drug.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Financial_Service_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_ICD_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_ICD_Diagnosis.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_ICD_Procedure.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Member_Demographic.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Not_Covered_Reason.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Pharmacy_Claim_Detail.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Pharmacy_Claim_Header.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Place_Of_Service.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Procedure_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Procedure_Modifier.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Processing_Reason.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Provider.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Provider_Identifier.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Revenue_Procedure.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Dim_Rider.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Fact_App_Mobile_Event.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Fact_Claim_Authorization_Detail.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Fact_Claim_Line.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Fact_Pharmacy_Claim_Line.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_FSS_Master.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Adjustment_Reason.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Claim_Rider.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_ICD_Diagnosis.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_ICD_Procedure.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Not_Covered_Reason.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Procedure_Category.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Procedure_Modifier.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Service_Reason.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Member_Mobile_Dimensions.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Claim_Dimensions.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_ICD_Diagnosis_Flat.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Grp_Procedure_Modifier_Flat.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Dim_Provider.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Dim_Provider_Address.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Dim_Provider_Contact_Info.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Dim_Provider_Identifier.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_Load_Pharmacy_Dim_Provider_Taxonomy.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_LoadFullExtract_Provider.sqlproc;
!load ../Schemas/dimdata/StoredProcedures/dimdata.spu_LoadFullExtract_Member.sqlproc;

--logdata

!load ../Schemas/logdata/StoredProcedures/logdata.spu_Set_Job_Id_Endtime.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Set_Job_Id.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_Default_Dim_keys.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_Get_Results.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_View_Compile.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_Master.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Dupe_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Foreign_Key_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Primary_Key_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Unknown_Foreign_Key_Check.sqlproc;

--reportdata
!load ../Schemas/reportdata/StoredProcedures/reportdata.spu_Write_Member_Preference_Extract.sqlproc;



----------------------------------------------------------------------------------------------------------
-- Tasks
----------------------------------------------------------------------------------------------------------
--reportdata

----------------------------------------------------------------------------------------------------------
-- CODE REVIEW SCRIPT
----------------------------------------------------------------------------------------------------------
--!load ../../ValidationScripts/CodeReview.sql;

!exit
