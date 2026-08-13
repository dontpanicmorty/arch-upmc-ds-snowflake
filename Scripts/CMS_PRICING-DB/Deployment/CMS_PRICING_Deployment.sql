/*----------------------------------------------------------------------------------------------------------
This is the master deployment procedure for the database. Only the items in this script will be 
deployed to the target database.

Connection options for deployment via SnowSQL:
    -f CMS_PRICING_Deployment.sql 
    --variable build_number="<your build number>" 
    --variable environment="<DEV, TST, PRD>" 
    -o log_level=debug 
    -o timing=false 
    -o header=false 
    -o echo=true 
    -o exit_on_error=true 
    -o output_file=CMS_PRICING_Deployment.log
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
!load ../DatabaseLevelObjects/Schemas/extractdata.sql;
!load ../DatabaseLevelObjects/Schemas/logdata.sql;
!load ../DatabaseLevelObjects/Schemas/rawdata.sql;
!load ../DatabaseLevelObjects/Schemas/reingestdata.sql;
!load ../DatabaseLevelObjects/Schemas/stagedata.sql;
!load ../DatabaseLevelObjects/Schemas/util.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
-- rawdata

!load ../Schemas/rawdata/Stages/rawdata.hpdsdatalake_dbextract_cms_pricing.sql;

--extractdata
!load ../Schemas/extractdata/Stages/extractdata.hpdsdatalake_outgoing.sql;
!load ../Schemas/extractdata/Stages/extractdata.websolutions_publicweb.sql;

----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--extractdata
!load ../Schemas/extractdata/FileFormats/extractdata.websolutions_publicweb_export_file_format.sql;

--rawdata
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_APCPricingExclusion_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ASAConversionFactorSet_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ASCPaymentGroupLevel_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_CaseType_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_Contracts_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_DRGIncludeExclude_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_Modifiers_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_PerDiemCaseRateSchedule_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_PerDiemPriceCategory_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_PriceCategoryFile_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_PriceCategoryProcedure_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_PricingHistPriceCatg_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderAffiliation_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderPricingHistory_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_Providers_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderAffiliation_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderSpecialty_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProcedureCodes_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderSubPart_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderTypeFeeSchedules_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_ProviderTypeSchedule_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_SNFPricingExclusion_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_UsualCustomaryReasonable_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_Vendors_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.Dwoao_Out_Of_Network_Claims_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.ReferenceData_Level2_ProductType_Override_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.ReferenceData_ProvDir_Level2_Product_Exclusion_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.ReferenceData_Provdir_Level_2_Network_Crosswalk_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.ReferenceData_Provider_Network_Crosswalk_file_format.sql;
!load ../Schemas/rawdata/FileFormats/rawdata.referencedata_dbextract_file_format.sql;

--reingestdata
!load ../Schemas/reingestdata/FileFormats/reingestdata.reingest_csv_file_format.sql;



----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--rawdata


----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--logdata
!load ../Schemas/logdata/Tables/logdata.Table_Load_History.sql;
!load ../Schemas/logdata/Tables/logdata.Extract_History.sql;
!load ../Schemas/logdata/Tables/logdata.Job_Log.sql;
!load ../Schemas/logdata/Tables/logdata.Competitor_Ingest_History.sql;
!load ../Schemas/logdata/Tables/logdata.Data_Validation_Result.sql;
!load ../Schemas/logdata/Tables/logdata.Build_Validation_Result.sql;

--rawdata
!load ../Schemas/rawdata/Tables/rawdata.Cactus_ADDRESSES.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_GROUPADDRESS.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_GROUPS.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_GROUPSPROVIDERSADDRESSES.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_PROVIDERADDRESSES.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_PROVIDERS.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_REFTABLE.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_GROUPID.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_ENTITYASSIGNMENTS.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_SERVICECATEGORYREFERENCES.sql;
!load ../Schemas/rawdata/Tables/rawdata.Cactus_PROVIDERSPECIALTIES.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_Contracts.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_DRGIncludeExclude.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_PriceCategoryFile.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_PriceCategoryProcedure.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_PricingHistPriceCatg.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderAffiliation.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderPricingHistory.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_Providers.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderSpecialty.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProcedureCodes.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderSubPart.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_CaseType.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_PerDiemCaseRateSchedule.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_PerDiemPriceCategory.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderTypeFeeSchedules.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ProviderTypeSchedule.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_Vendors.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_APCPricingExclusion.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ASAConversionFactorSet.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_ASCPaymentGroupLevel.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_Modifiers.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_SNFPricingExclusion.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_UsualCustomaryReasonable.sql;
!load ../Schemas/rawdata/Tables/rawdata.Dwoao_Out_Of_Network_Claims.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_DATA_SOURCE.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_LICENSE_STATUS.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_LICENSE_TYPE.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_MEDICAL_GROUP.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_PRACTITIONER.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_PROVIDER_ADDRESS_REL.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_PROVIDER_LICENSE_REL.sql;
!load ../Schemas/rawdata/Tables/rawdata.ODSDATA_PROVIDER.sql;
!load ../Schemas/rawdata/Tables/rawdata.ReferenceData_Level2_ProductType_Override.sql;
!load ../Schemas/rawdata/Tables/rawdata.ReferenceData_ProvDir_Level2_Product_Exclusion.sql;
!load ../Schemas/rawdata/Tables/rawdata.ReferenceData_Provdir_Level_2_Network_Crosswalk.sql;
!load ../Schemas/rawdata/Tables/rawdata.ReferenceData_Provider_Network_Crosswalk.sql;

--stagedata
!load ../Schemas/stagedata/Tables/stagedata.IPA.sql;
!load ../Schemas/stagedata/Tables/stagedata.Plan_Type.sql;
!load ../Schemas/stagedata/Tables/stagedata.Price_Category.sql;
!load ../Schemas/stagedata/Tables/stagedata.Group_Carrier_Price_Group.sql;
!load ../Schemas/stagedata/Tables/stagedata.Provider_Grouping.sql;
!load ../Schemas/stagedata/Tables/stagedata.Pricing_Network.sql;
!load ../Schemas/stagedata/Tables/stagedata.Pricing_Network_Crosswalk.sql;
!load ../Schemas/stagedata/Tables/stagedata.Practitioner_Fee_Schedule_Select_Hold.sql;
!load ../Schemas/stagedata/Tables/stagedata.Negotiated_Price_Internal_Hold.sql;
!load ../Schemas/stagedata/Tables/stagedata.Provider_Set_Internal_Hold.sql;
!load ../Schemas/stagedata/Tables/stagedata.Inpatient_Fee_Schedule_Select_Hold.sql;
!load ../Schemas/stagedata/Tables/stagedata.Legal_Entity.sql;



--extractdata
!load ../Schemas/extractdata/Tables/extractdata.Billing_Code.sql;
!load ../Schemas/extractdata/Tables/extractdata.Reporting_Entity.sql;
!load ../Schemas/extractdata/Tables/extractdata.Pricing_File.sql;
!load ../Schemas/extractdata/Tables/extractdata.In_Network_Base.sql;
!load ../Schemas/extractdata/Tables/extractdata.Provider_Set.sql;
!load ../Schemas/extractdata/Tables/extractdata.Negotiated_Price.sql;
!load ../Schemas/extractdata/Tables/extractdata.Pricing_Provider_Group.sql;
!load ../Schemas/extractdata/Tables/extractdata.Negotiated_Rates.sql;
!load ../Schemas/extractdata/Tables/extractdata.Bundle_Code_Rel.sql;
!load ../Schemas/extractdata/Tables/extractdata.Pricing_Plan.sql;
!load ../Schemas/extractdata/Tables/extractdata.Out_Of_Network_Base.sql;
!load ../Schemas/extractdata/Tables/extractdata.Allowed_Amounts.sql;
!load ../Schemas/extractdata/Tables/extractdata.Payments.sql;
!load ../Schemas/extractdata/Tables/extractdata.Pricing_Plan_File_Rel.sql;
!load ../Schemas/extractdata/Tables/extractdata.Provider_Group_File.sql;
!load ../Schemas/extractdata/Tables/extractdata.Payment_Providers.sql;

----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--extractdata
!load ../Schemas/extractdata/Functions/extractdata.fxn_array_sort.sqlproc;
!load ../Schemas/extractdata/Functions/extractdata.fxn_get_current_tic_date.sqlproc;
!load ../Schemas/extractdata/Functions/extractdata.fxn_make_url_path.sqlproc;
!load ../Schemas/extractdata/Functions/extractdata.fxn_prepend_staging_container_url.sqlproc;
!load ../Schemas/extractdata/Functions/extractdata.fxn_string_array_sort.sqlproc;

--logdata
!load ../Schemas/logdata/Functions/logdata.fxn_get_pk_columns.sqlproc;
!load ../Schemas/logdata/Functions/logdata.fxn_get_uk_columns.sqlproc;

--stagedata
!load ../Schemas/stagedata/Functions/stagedata.fxn_make_in_network_file_desc.sqlproc;
!load ../Schemas/stagedata/Functions/stagedata.fxn_make_allowed_amounts_file_desc.sqlproc;

----------------------------------------------------------------------------------------------------------
-- VIEWS
----------------------------------------------------------------------------------------------------------
--stagedata
!load ../Schemas/stagedata/Views/stagedata.MRF_CONTRACTS_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_ACTIVE_PROVIDER_PRICING_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_PROVIDER_PRICING_HISTORY_ANESTHESIA_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_PROVIDER_PRICING_HISTORY_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_FEE_SCHEDULE_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_PRICING_HIST_PRICE_CATG_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_VENDOR_PRICE_FINAL_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.MRF_PRICE_CATEGORY_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Price_Category_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.Provider_Grouping_Select_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.PROVIDER_NETWORKS_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.VENDOR_STATE_vw.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_RULE_009_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_RULE_041_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_RULE_065_VW.sql;


--stagedata, used to copy to extractdata
!load ../Schemas/stagedata/Views/stagedata.PRICING_FILE_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_PLAN_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_PLAN_FILE_REL_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.FEE_SCHEDULE_PROVIDER_NETWORK_XWALK_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PROVIDER_SET_INTERNAL_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PROVIDER_SET_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.LOCATION_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.NEGOTIATED_PRICE_INTERNAL_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.NEGOTIATED_PRICE_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_PROVIDER_GROUP_INTERNAL_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PRICING_PROVIDER_GROUP_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.BILLING_CODE_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.BILLING_CODE_INTERNAL_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.IN_NETWORK_BASE_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.NEGOTIATED_RATES_SELECT_VW.sql;

-- separate dependency chain
!load ../Schemas/stagedata/Views/stagedata.OUT_OF_NETWORK_CLAIMS_THRESHOLD_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.OUT_OF_NETWORK_BASE_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.ALLOWED_AMOUNTS_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PAYMENTS_SELECT_VW.sql;
!load ../Schemas/stagedata/Views/stagedata.PAYMENT_PROVIDERS_SELECT_VW.sql;


--extractdata
!load ../Schemas/extractdata/Views/extractdata.Payment_Providers_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Payments_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Allowed_Amounts_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Bundle_Code_Rel_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Negotiated_Price_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Negotiated_Rates_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Pricing_Provider_Group_File_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Pricing_Provider_Reference_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.In_Network_Base_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.In_Network_File_Base_SELECT_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.In_Network_File_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Out_Of_Network_Base_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Out_Of_Network_File_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Pricing_File_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Pricing_Plan_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.PRICING_FILE_SEGMENT_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Table_Of_Contents_File_JSON_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.TIN_NPI_TYPE_LKP_VW.sql;
!load ../Schemas/extractdata/Views/extractdata.Pricing_Rule_Individual_Validation_VW.sql;

--rawdata
!load ../Schemas/rawdata/Views/rawdata.level_2_product_type_override_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.provider_level_2_network_crosswalk_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.provider_level_2_product_exclusion_vw.sql;
!load ../Schemas/rawdata/Views/rawdata.provider_network_crosswalk_vw.sql;


----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------

--extractdata
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Clone_Archive_DB.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Clone_Archive_DB_NO_DATE.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Copy_View_To_Blob.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Allowed_Amounts_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Billing_Code_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Cigna_URL_From_IDAP_Lake.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_In_Network_Base_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Negotiated_Price_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Negotiated_Rates_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Out_Of_Network_Base_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Payment_Providers_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Payments_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Pricing_File_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Pricing_Plan_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Pricing_Plan_File_Rel_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Pricing_Provider_Group_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Merge_Provider_Set_From_Stagedata.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Run_Extract.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Write_Extract_Files.sqlproc;
!load ../Schemas/extractdata/StoredProcedures/extractdata.spu_Write_Extract_Files_NO_PARAMS.sqlproc;

--logdata
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Cigna_URL.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_dwOAO_Tables.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Set_Job_Id.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Dupe_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Primary_Key_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Foreign_Key_Check.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Data_Foreign_Key_Check_Bulk.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_Get_Results.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_Master.sqlproc;
!load ../Schemas/logdata/StoredProcedures/logdata.spu_Validate_Build_View_Compile.sqlproc;

--rawdata
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_clone_cactus_tables.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_clone_odsdata_tables.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_APCPRICINGEXCLUSION.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_ASACONVERSIONFACTORSET.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_ASCPAYMENTGROUPLEVEL.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_CASETYPE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_CONTRACTS.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_DRGINCLUDEEXCLUDE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_MODIFIERS.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PERDIEMCASERATESCHEDULE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PERDIEMPRICECATEGORY.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PRICECATEGORYFILE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PRICECATEGORYPROCEDURE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PRICINGHISTPRICECATG.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROCEDURECODES.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERAFFILIATION.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERPRICINGHISTORY.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERS.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERSPECIALTY.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERSUBPART.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERTYPEFEESCHEDULES.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_PROVIDERTYPESCHEDULE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_SNFPRICINGEXCLUSION.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_USUALCUSTOMARYREASONABLE.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_VENDORS.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_OUT_OF_NETWORK_CLAIMS.sqlproc;
!load ../Schemas/rawdata/StoredProcedures/rawdata.spu_load_CMS_RAWDATA.sqlproc;

--stagedata
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_IPA.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Negotiated_Price_Internal.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Plan_Type.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Practitioner_Fee_Schedule.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Price_Category.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Provider_Grouping.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Provider_Set_Internal.sqlproc;
!load ../Schemas/stagedata/StoredProcedures/stagedata.spu_InsertOverwrite_Inpatient_Fee_Schedule.sqlproc;

----------------------------------------------------------------------------------------------------------
-- CODE REVIEW SCRIPT
----------------------------------------------------------------------------------------------------------
--!load ../../ValidationScripts/CodeReview.sql;


!exit
