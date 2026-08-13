/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for util.adf_sharepoint_copy_control

SELECT 'Updating static data table util.adf_sharepoint_copy_control';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY TABLE UTIL.tmp_ADF_SHAREPOINT_COPY_CONTROL
(
    IS_ACTIVE BOOLEAN NOT NULL,
    ADF_TRIGGER_NAME VARCHAR COMMENT 'The trigger name in ADF for when this file object is to be processed',
    DATA_DOMAIN_NAME VARCHAR NOT NULL COMMENT 'CLAIMS, MEMBER, PROVIDER, etc.',
    SHAREPOINT_SITE_NAME VARCHAR NOT NULL COMMENT 'Base URL for ADF dataset REST linked service',
    SHAREPOINT_RELATIVE_PATH VARCHAR NOT NULL COMMENT 'Relative URL folder location for ADF Rest Call',
    SHAREPOINT_FILENAME VARCHAR NOT NULL COMMENT 'Filename is Sharepoint location',
    ADLS_CONTAINER_NAME VARCHAR NOT NULL COMMENT 'The target storage container name in ADLS account',
    ADLS_DIRECTORY_NAME VARCHAR NOT NULL COMMENT 'The target directory path in the ADLS container',
    ADLS_FILENAME VARCHAR NOT NULL COMMENT 'The target filename',
    IS_CONVERT_XLS_TO_CSV BOOLEAN NOT NULL COMMENT 'Flag to determine if Excel file should be converted to CSV pipe delimited',
    CONSTRAINT PK_ADF_SHAREPOINT_COPY_CONTROL PRIMARY KEY (SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME),
    CONSTRAINT UK_ADF_SHAREPOINT_COPY_CONTROL UNIQUE (SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME)
) COMMENT = 'Control table for copying files from Sharepoint to ADLS via ADF'
;

-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.


INSERT INTO UTIL.tmp_ADF_SHAREPOINT_COPY_CONTROL (IS_ACTIVE, ADF_TRIGGER_NAME, DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME, ADLS_CONTAINER_NAME, ADLS_DIRECTORY_NAME, ADLS_FILENAME, IS_CONVERT_XLS_TO_CSV)
VALUES 
(true, 'Daily - 12_00', 'enterprise', 'idapcenterofexcellence', '/IDAP Reference Data Management/', 'source_data_mapping.xlsx', 'idaplake', 'referencedata', 'source_data_mapping.txt', true)
,(true, 'Daily - 12_00', 'enterprise', 'idapcenterofexcellence', '/IDAP Reference Data Management/Enterprise/', 'gender.xlsx', 'idaplake', 'referencedata/enterprise', 'gender.txt', true)
,(true, 'Daily - 12_00', 'enterprise', 'idapcenterofexcellence', '/IDAP Reference Data Management/Enterprise/', 'data_source.xlsx', 'idaplake', 'referencedata/enterprise', 'data_source.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/', 'rider_type.xlsx', 'idaplake', 'referencedata/member', 'rider_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_electronic_type.xlsx', 'idaplake', 'referencedata/claim', 'claim_electronic_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_icd_class.xlsx', 'idaplake', 'referencedata/claim', 'claim_icd_class.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_icd_diagnosis_qualifier.xlsx', 'idaplake', 'referencedata/claim', 'claim_icd_diagnosis_qualifier.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_location_type.xlsx', 'idaplake', 'referencedata/claim', 'claim_location_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_pay_status.xlsx', 'idaplake', 'referencedata/claim', 'claim_pay_status.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_place_of_service_location_type_rel.xlsx', 'idaplake', 'referencedata/claim', 'claim_place_of_service_location_type_rel.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_place_of_service.xlsx', 'idaplake', 'referencedata/claim', 'claim_place_of_service.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_quad_arch.xlsx', 'idaplake', 'referencedata/claim', 'claim_quad_arch.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_revenue_code.xlsx', 'idaplake', 'referencedata/claim', 'claim_revenue_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_service_type.xlsx', 'idaplake', 'referencedata/claim', 'claim_service_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_CPT_BASE.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_CPT_BASE.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_DENTAL_BASE.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_DENTAL_BASE.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_HCPCS_BASE.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_HCPCS_BASE.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_ICD10CM_BASE.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_ICD10CM_BASE.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_ICD10CM_HAC.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_ICD10CM_HAC.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_ICD10CM_IP_INDICATORS.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_ICD10CM_IP_INDICATORS.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_ICD10PCS_BASE.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_ICD10PCS_BASE.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Optum/', 'OPTUM_MODIFIER_FLAG_EFF.txt', 'idaplake', 'referencedata/claim/optum', 'OPTUM_MODIFIER_FLAG_EFF.txt', false)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Skygen/', 'Skygen_Not_Covered_Reason_Codes.xlsx', 'idaplake', 'referencedata/claim/skygen', 'Skygen_Not_Covered_Reason_Codes.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/NVA/', 'NVA_Not_Covered_Reason_Codes.xlsx', 'idaplake', 'referencedata/claim/nva', 'NVA_Not_Covered_Reason_Codes.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/NVA/', 'NVA_Processing_Reasons.xlsx', 'idaplake', 'referencedata/claim/nva', 'NVA_Processing_Reasons.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_adjudication_pharmacy_class_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_adjudication_pharmacy_class_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_adjustment_type_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_adjustment_type_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_claim_cob_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_claim_cob_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_claim_generic_price_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_claim_generic_price_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_claim_type_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_claim_type_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_compound_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_compound_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_dispense_pharmacy_type_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_dispense_pharmacy_type_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_drug_discount_applicable_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_drug_discount_applicable_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_drug_discount_exclusion_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_drug_discount_exclusion_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_fill_method_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_fill_method_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_formulary_flag_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_formulary_flag_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_funded_ind.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_funded_ind.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_low_income_subsidy_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_low_income_subsidy_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_m3p_origin.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_m3p_origin.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_manufacturer_discount_type.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_manufacturer_discount_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_other_coverage_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_other_coverage_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_partial_fill_status_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_partial_fill_status_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_patient_residence_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_patient_residence_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_prescription_origin_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_prescription_origin_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_supplemental_coverage_troop_qualification.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_supplemental_coverage_troop_qualification.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_transaction_adjustment_type_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_transaction_adjustment_type_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_transaction_type_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_transaction_type_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_price_source_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_price_source_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_dispense_code.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_dispense_code.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_pricing_used_ind.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_pricing_used_ind.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/Medispan/', 'medispan_awp_indication_code.xlsx', 'idaplake', 'referencedata/claim/medispan', 'medispan_awp_indication_code.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/', 'rider_formulary_code.xlsx', 'idaplake', 'referencedata/member', 'rider_formulary_code.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/', 'rider_type.xlsx', 'idaplake', 'referencedata/member', 'rider_type.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/', 'claim_diagnosis_related_group.xlsx', 'idaplake', 'referencedata/claim', 'claim_diagnosis_related_group.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_specialty_drug_indicator.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_specialty_drug_indicator.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_specialty_drug_indicator_exclusions.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_specialty_drug_indicator_exclusions.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/IDAP Reference Data Management/Claim/ESI/', 'esi_specialty_pharmacy_indicator.xlsx', 'idaplake', 'referencedata/claim/esi', 'esi_specialty_pharmacy_indicator.txt', true)
,(true, 'Daily - 12_00', 'claim', 'idapcenterofexcellence', '/Pharmacy Operations/', 'PharmacyCrosswalkData_Final.xlsx', 'idaplake', 'referencedata/claim/esi', 'pharmacy_crosswalk_data_final.txt', true)
,(true, 'Daily - 12_00', 'provider', 'idapcenterofexcellence', '/IDAP Reference Data Management/Provider/', 'Provider_Vision_Product_Crosswalk.xlsx', 'idaplake', 'referencedata/provider', 'Provider_Vision_Product_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'provider', 'idapcenterofexcellence', '/IDAP Reference Data Management/Provider/', 'Provider_Network_Crosswalk.xlsx', 'idaplake', 'referencedata/provider', 'Provider_Network_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'provider', 'idapcenterofexcellence', '/IDAP Reference Data Management/Provider/', 'Provider_Dental_CorpID_Product_Crosswalk.xlsx', 'idaplake', 'referencedata/provider', 'Provider_Dental_CorpID_Product_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'MemberNetwork_CorporateIdSubProduct_Override.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'MemberNetwork_CorporateIdSubProduct_Override.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'MemberNetwork_PharmacyLOBSubProduct_Crosswalk.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'MemberNetwork_PharmacyLOBSubProduct_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'MemberNetwork_PlanCodeSubProduct_Crosswalk.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'MemberNetwork_PlanCodeSubProduct_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'MemberNetwork_RiderCodeSubProduct_Crosswalk.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'MemberNetwork_RiderCodeSubProduct_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'MemberNetwork_RiderTypeCodeLOBSubProduct_Crosswalk.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'MemberNetwork_RiderTypeCodeLOBSubProduct_Crosswalk.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'Provider_MemberNetwork_PlanCode_Exclusion.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'Provider_MemberNetwork_PlanCode_Exclusion.txt', true)
,(true, 'Daily - 12_00', 'member', 'idapcenterofexcellence', '/IDAP Reference Data Management/Member/MemberNetwork/', 'Provider_MemberNetwork_PlanType_Exclusion.xlsx', 'idaplake', 'referencedata/member/membernetwork', 'Provider_MemberNetwork_PlanType_Exclusion.txt', true)
;


--3:  Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO UTIL.ADF_SHAREPOINT_COPY_CONTROL AS TGT
USING (SELECT IS_ACTIVE, ADF_TRIGGER_NAME, DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME, ADLS_CONTAINER_NAME, ADLS_DIRECTORY_NAME, ADLS_FILENAME, IS_CONVERT_XLS_TO_CSV
	FROM  UTIL.tmp_ADF_SHAREPOINT_COPY_CONTROL
	MINUS 
	SELECT IS_ACTIVE, ADF_TRIGGER_NAME, DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME, ADLS_CONTAINER_NAME, ADLS_DIRECTORY_NAME, ADLS_FILENAME, IS_CONVERT_XLS_TO_CSV
	FROM UTIL.ADF_SHAREPOINT_COPY_CONTROL
	) AS SRC

ON (TGT.DATA_DOMAIN_NAME = SRC.DATA_DOMAIN_NAME
AND TGT.SHAREPOINT_SITE_NAME = SRC.SHAREPOINT_SITE_NAME
AND TGT.SHAREPOINT_RELATIVE_PATH = SRC.SHAREPOINT_RELATIVE_PATH
AND TGT.SHAREPOINT_FILENAME = SRC.SHAREPOINT_FILENAME)

WHEN MATCHED 
THEN UPDATE
	SET TGT.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
    ,TGT.IS_ACTIVE = SRC.IS_ACTIVE
    ,TGT.ADF_TRIGGER_NAME = SRC.ADF_TRIGGER_NAME
    ,TGT.ADLS_CONTAINER_NAME = SRC.ADLS_CONTAINER_NAME
    ,TGT.ADLS_DIRECTORY_NAME = SRC.ADLS_DIRECTORY_NAME
    ,TGT.ADLS_FILENAME = SRC.ADLS_FILENAME
    ,TGT.IS_CONVERT_XLS_TO_CSV = SRC.IS_CONVERT_XLS_TO_CSV

WHEN NOT MATCHED 
THEN INSERT
	(ADF_SHAREPOINT_COPY_CONTROL_KEY, INSERT_DATETIME, LAST_UPDATED_DATETIME, IS_ACTIVE, ADF_TRIGGER_NAME, DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME, ADLS_CONTAINER_NAME, ADLS_DIRECTORY_NAME, ADLS_FILENAME, IS_CONVERT_XLS_TO_CSV)
VALUES
	((SELECT IFNULL(MAX(ADF_SHAREPOINT_COPY_CONTROL_KEY), 0) FROM UTIL.ADF_SHAREPOINT_COPY_CONTROL) + ROW_NUMBER() OVER (ORDER BY 1)
    ,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP(), src.IS_ACTIVE, src.ADF_TRIGGER_NAME, src.DATA_DOMAIN_NAME, src.SHAREPOINT_SITE_NAME, src.SHAREPOINT_RELATIVE_PATH, src.SHAREPOINT_FILENAME, src.ADLS_CONTAINER_NAME, src.ADLS_DIRECTORY_NAME, src.ADLS_FILENAME, src.IS_CONVERT_XLS_TO_CSV)
;
	
-- 4:ST_ENVELOPE — DEPRECATED()Flip the minus and delete from the target
DELETE FROM UTIL.ADF_SHAREPOINT_COPY_CONTROL TGT
USING
(SELECT DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME
	FROM UTIL.ADF_SHAREPOINT_COPY_CONTROL
	MINUS 
	SELECT DATA_DOMAIN_NAME, SHAREPOINT_SITE_NAME, SHAREPOINT_RELATIVE_PATH, SHAREPOINT_FILENAME
	FROM UTIL.tmp_ADF_SHAREPOINT_COPY_CONTROL
	) SRC
WHERE TGT.DATA_DOMAIN_NAME = SRC.DATA_DOMAIN_NAME
AND TGT.SHAREPOINT_SITE_NAME = SRC.SHAREPOINT_SITE_NAME
AND TGT.SHAREPOINT_RELATIVE_PATH = SRC.SHAREPOINT_RELATIVE_PATH
AND TGT.SHAREPOINT_FILENAME = SRC.SHAREPOINT_FILENAME
;

SELECT 'Finished updating static data table util.adf_sharepoint_copy_control';