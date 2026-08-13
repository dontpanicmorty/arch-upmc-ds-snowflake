CREATE OR REPLACE VIEW STAGEDATA.CLAIM_HEADER_RAW_VW
AS
SELECT
CLAIM_HEADER_KEY
,URI
,JSON_DATA:envelope:instance:claimHeader:admissionTypeCodeDescKey::string AS ADMISSION_TYPE_CODE_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:admissionSourceCode::string AS ADMISSION_SOURCE_CODE
,JSON_DATA:envelope:instance:claimHeader:admissionTypeCode::string AS ADMISSION_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:admitDate::date AS ADMIT_DATE
,JSON_DATA:envelope:instance:claimHeader:admitHour::number(4,2) as ADMIT_HOUR
,TRY_TO_BOOLEAN(JSON_DATA:envelope:instance:claimHeader:admitFlag::string) AS ADMIT_FLAG
,CASE WHEN json_data:envelope:instance:claimHeader:billingProviderDetailKey::string IS NULL
    THEN CONCAT (json_data:envelope:instance:claimHeader:tpaKey::string
                ,json_data:envelope:instance:claimHeader:dataSourceName::string
                ,json_data:envelope:instance:claimHeader:billingProviderId::string)
ELSE json_data:envelope:instance:claimHeader:billingProviderDetailKey::string
END AS BILLING_PROVIDER_DETAIL_KEY
,JSON_DATA:envelope:instance:claimHeader:billingProviderId::string AS BILLING_PROVIDER_ID
,JSON_DATA:envelope:instance:claimHeader:billingProviderParticipatingStatusCode::string AS BILLING_PROVIDER_PARTICIPATING_STATUS_CODE
,JSON_DATA:envelope:instance:claimHeader:billingProviderTaxIdNbr::string AS BILLING_PROVIDER_TAX_ID_NBR
,JSON_DATA:envelope:instance:claimHeader:billingProviderVendorNbr::string AS BILLING_PROVIDER_VENDOR_NBR
,JSON_DATA:envelope:instance:claimHeader:ub92BillTypeCode::string AS BILL_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:ub92BillTypeDescKey::string AS BILL_TYPE_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:calculatedBillTotalAmt::number AS CALCULATED_BILL_TOTAL_AMT
,JSON_DATA:envelope:instance:claimHeader:careTypeName::string AS CARE_TYPE_NAME
,JSON_DATA:envelope:instance:claimHeader:claimEntryDate::date AS CLAIM_ENTRY_DATE
,JSON_DATA:envelope:instance:claimHeader:claimNbr::string AS CLAIM_NBR
,JSON_DATA:envelope:instance:claimHeader:dataSourceName::string AS DATA_SOURCE_NAME
,JSON_DATA:envelope:instance:claimHeader:diagnosisRelatedGroupCode::string AS DIAGNOSIS_RELATED_GROUP_CODE
,JSON_DATA:envelope:instance:claimHeader:diagnosisRelatedGroupKey::string AS DATA_HUB_UNIVERSAL_DRG_ID
,JSON_DATA:envelope:instance:claimHeader:severityOfIllness::string AS SEVERITY_OF_ILLNESS
,JSON_DATA:envelope:instance:claimHeader:dischargeDate::date AS DISCHARGE_DATE
,JSON_DATA:envelope:instance:claimHeader:dischargeHour::number(4,2) AS DISCHARGE_HOUR
,JSON_DATA:envelope:instance:claimHeader:dischargeStatusCode::string AS DISCHARGE_STATUS_CODE
,JSON_DATA:envelope:instance:claimHeader:divisionNbr::string AS DIVISION_NBR
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityNpiNbr::string AS EDI_837_FACILITY_NPI_NBR
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityName::string AS EDI_837_FACILITY_NAME
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityTelephoneNbr::string AS EDI_837_FACILITY_TELEPHONE_NBR
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityAddressLine1Text::string AS EDI_837_FACILITY_ADDRESS_LINE_1_TEXT
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityAddressLine2Text::string AS EDI_837_FACILITY_ADDRESS_LINE_2_TEXT
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityStateAbbrevName::string AS EDI_837_FACILITY_STATE_ABBREV_NAME
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityZipCodeNbr::string AS EDI_837_FACILITY_ZIP_CODE_NBR
,JSON_DATA:envelope:instance:claimHeader:edi837FacilityOtherId::string AS EDI_837_FACILITY_OTHER_ID
,JSON_DATA:envelope:instance:claimHeader:electronicClaimTypeCode::string AS ELECTRONIC_CLAIM_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:encounterReasonCode::string AS ENCOUNTER_REASON_CODE
,JSON_DATA:envelope:instance:claimHeader:formNbr::string AS FORM_NBR
,JSON_DATA:envelope:instance:claimHeader:groupNbr::string AS GROUP_NBR
,JSON_DATA:envelope:instance:claimHeader:icdDiagnosisCodes AS ICD_DIAGNOSIS_CODES
,JSON_DATA:envelope:instance:claimHeader:icdVersionCode::string AS ICD_VERSION_CODE
,JSON_DATA:envelope:instance:claimHeader:ipaCode::string AS IPA_CODE
,JSON_DATA:envelope:instance:claimHeader:isProcessingComplete::boolean AS IS_PROCESSING_COMPLETE
,JSON_DATA:envelope:instance:claimHeader:lineOfBusinessCode::string AS LINE_OF_BUSINESS_CODE
,JSON_DATA:envelope:instance:claimHeader:memberCountyCode::string AS MEMBER_COUNTRY_CODE
,JSON_DATA:envelope:instance:claimHeader:memberGenderCode::string AS MEMBER_GENDER_CODE
,JSON_DATA:envelope:instance:claimHeader:memberNbr::string AS MEMBER_NBR
,JSON_DATA:envelope:instance:claimHeader:memberNbrType::string AS MEMBER_NBR_TYPE
,JSON_DATA:envelope:instance:claimHeader:memberAgeNbr::number(11,2) AS MEMBER_AGE_NBR
,JSON_DATA:envelope:instance:claimHeader:paidPresZipCode::string AS PAID_PRES_ZIPCODE
,JSON_DATA:envelope:instance:claimHeader:placeOfServiceCode::string AS PLACE_OF_SERVICE_CODE
,JSON_DATA:envelope:instance:claimHeader:planCode::string AS PLAN_CODE
,JSON_DATA:envelope:instance:claimHeader:planTypeCode::string AS PLAN_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:pricingZipSource::string AS PRICING_ZIP_SOURCE
,JSON_DATA:envelope:instance:claimHeader:providerAcctNbr::string AS PROVIDER_ACCT_NBR
,JSON_DATA:envelope:instance:claimHeader:referringProviderId::string AS REFERRING_PROVIDER_ID
,JSON_DATA:envelope:instance:claimHeader:riderCodes AS RIDER_CODES
,JSON_DATA:envelope:instance:claimHeader:shockClaimInd::string AS SHOCK_CLAIM_IND
,JSON_DATA:envelope:instance:claimHeader:snapshotMappingFinished::boolean AS SNAPSHOT_MAPPING_FINISHED
,JSON_DATA:envelope:instance:claimHeader:sourceLastUpdatedDate::date AS SOURCE_LAST_UPDATED_DATE
,JSON_DATA:envelope:instance:claimHeader:subGroupNbr::string AS SUB_GROUP_NBR
,JSON_DATA:envelope:instance:claimHeader:tpaClientId::string AS TPA_CLIENT_ID
,JSON_DATA:envelope:instance:claimHeader:tpaDivId::string AS TPA_DIV_ID
,JSON_DATA:envelope:instance:claimHeader:tpaId::string AS TPA_ID
,JSON_DATA:envelope:instance:claimHeader:tpaKey::string AS TPA_KEY
,JSON_DATA:envelope:instance:claimHeader:ub92AdmissionSourceCode::string AS UB92_ADMISSION_SOURCE_CODE
,JSON_DATA:envelope:instance:claimHeader:ub92AdmissionSourceDescKey::string AS UB92_ADMISSION_SOURCE_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:ub92AdmissionTypeCode::string AS UB92_ADMISSION_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:ub92AdmissionTypeDescKey::string AS UB92_ADMISSION_TYPE_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:ub92DischargeStatusCode::string AS UB92_DISCHARGE_STATUS_CODE
,JSON_DATA:envelope:instance:claimHeader:ub92DischargeStatusDescKey::string AS UB92_DISCHARGE_STATUS_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:ub92ServiceTypeCode::string AS UB92_SERVICE_TYPE_CODE
,JSON_DATA:envelope:instance:claimHeader:ub92ServiceTypeDescKey::string AS UB92_SERVICE_TYPE_DESC_KEY
,JSON_DATA:envelope:instance:claimHeader:universalClaimId AS UNIVERSAL_CLAIM_ID
,JSON_DATA:envelope:instance:claimHeader:referringProviderDetailKey::string AS REFERRING_PROVIDER_DETAIL_KEY
,JSON_DATA:envelope:instance:claimHeader:attendingPhysicianDetailKey::string AS ATTENDING_PHYSICIAN_DETAIL_KEY
,JSON_DATA:envelope:instance:claimHeader:attendingPhysicianId::string AS ATTENDING_PHYSICIAN_ID
,JSON_DATA:envelope:instance:claimHeader:assignedProviderKey::string AS ASSIGNED_PROVIDER_KEY
,JSON_DATA:envelope:instance:claimHeader:assignedProviderId::string AS ASSIGNED_PROVIDER_ID
,JSON_DATA:envelope:instance:claimHeader:microFilmNbr::string AS MICROFILM_NBR
,JSON_DATA:envelope:instance:claimHeader:claimTypeCode::string as CLAIM_TYPE_CODE
FROM STAGEDATA.CLAIM_HEADER
;
