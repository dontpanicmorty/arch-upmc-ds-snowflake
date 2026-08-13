CREATE OR REPLACE VIEW STAGEDATA.PROVIDER_DETAIL_VW
AS
SELECT
PROVIDER_DETAIL_KEY
,URI
,JSON_DATA:envelope:instance:providerDetail:universalProviderId::string AS universal_provider_id
,JSON_DATA:envelope:instance:providerDetail:tpaClientId::string AS tpa_client_id
,JSON_DATA:envelope:instance:providerDetail:tpaDivId::string AS tpa_div_id
,JSON_DATA:envelope:instance:providerDetail:tpaId::string AS tpa_id
,JSON_DATA:envelope:instance:providerDetail:tpaKey::string AS tpa_key
,JSON_DATA:envelope:instance:providerDetail:dataSourceName::string AS data_source_name
,JSON_DATA:envelope:instance:providerDetail:sourceProviderNbr::string AS source_provider_nbr
,JSON_DATA:envelope:instance:providerDetail:subTypeDesc::string AS provider_sub_type_desc
,JSON_DATA:envelope:instance:providerDetail:roleTypeDesc::string AS provider_role_type_desc_key
,JSON_DATA:envelope:instance:providerDetail:activeInd::string AS active_ind
,JSON_DATA:envelope:instance:providerDetail:providerStartDate::date AS provider_start_date
,JSON_DATA:envelope:instance:providerDetail:fullName::string AS full_name
,JSON_DATA:envelope:instance:providerDetail:firstName::string AS first_name
,JSON_DATA:envelope:instance:providerDetail:lastName::string AS last_name
,JSON_DATA:envelope:instance:providerDetail:middleName::string AS middle_name
,JSON_DATA:envelope:instance:providerDetail:middleInitialName::string AS middle_initial_name
,JSON_DATA:envelope:instance:providerDetail:suffixName::string AS suffix_name
,JSON_DATA:envelope:instance:providerDetail:degreeText::string AS degree_text
,JSON_DATA:envelope:instance:providerDetail:genderDescKey::string AS gender_desc_key
,JSON_DATA:envelope:instance:providerDetail:birthDate::date AS birth_date
,JSON_DATA:envelope:instance:providerDetail:socialSecurityNbr::string as social_security_nbr
,JSON_DATA:envelope:instance:providerDetail:emailAddressText::string AS email_address_text
,JSON_DATA:envelope:instance:providerDetail:wFbsiteUrlText::string as wfb_site_url_text
,JSON_DATA:envelope:instance:providerDetail:upinNbr::string AS upin_nbr
,JSON_DATA:envelope:instance:providerDetail:primaryPhoDescKey::string as primary_pho_desc_key
,JSON_DATA:envelope:instance:providerDetail:primaryPhoTerminationDate::date as primary_pho_termination_date
,JSON_DATA:envelope:instance:providerDetail:secondaryPhoDesc::string as secondary_pho_desc
,JSON_DATA:envelope:instance:providerDetail:secondaryPhoTerminationDate::date as Secondary_PHO_Termination_Date
,JSON_DATA:envelope:instance:providerDetail:tertiaryPhoDesc::string as tertiary_pho_desc
,JSON_DATA:envelope:instance:providerDetail:tertiaryPhoTerminationDate::date as tertiary_pho_termination_date
,JSON_DATA:envelope:instance:providerDetail:tinNbr::string AS tin_nbr
,JSON_DATA:envelope:instance:providerDetail:facilityInceptionDate::date AS facility_inception_date
,JSON_DATA:envelope:instance:providerDetail:locumTenensInd::string as locum_tenens_ind
,JSON_DATA:envelope:instance:providerDetail:needNppesApiInfoInd::string AS NEED_NPPES_API_INFO_IND
,JSON_DATA:envelope:instance:providerDetail:invisibleProviderInd::string as invisible_provider_ind
,JSON_DATA:envelope:instance:providerDetail:temporaryProviderInd::string as temporary_provider_ind
,JSON_DATA:envelope:instance:providerDetail:paMedicaidInd::string as pa_medicaid_ind
,JSON_DATA:envelope:instance:providerDetail:ppacaEnhancedPayInd::string as pp_aca_enchanced_pay_ind
,JSON_DATA:envelope:instance:providerDetail:providerMalpracticeCoverageInd as provider_malpractice_coverage_ind
,JSON_DATA:envelope:instance:providerDetail:providerIdentifiers AS provider_identifiers
,JSON_DATA:envelope:instance:providerDetail:primarySpecialtyDesc::string as primary_specialty_desc
,JSON_DATA:envelope:instance:providerDetail:primarySpecialtyDescKey::string AS primary_specialty_desc_key
,JSON_DATA:envelope:instance:providerDetail:ownershipStatusDesc::string as ownership_status_desc
,JSON_DATA:envelope:instance:providerDetail:providerNpi::string AS provider_npi
,JSON_DATA:envelope:instance:providerDetail:providerPhoneNbr::string AS provider_phone_number
,JSON_DATA:envelope:instance:providerDetail:providerStateLicense::string AS provider_state_license
,JSON_DATA:envelope:instance:providerDetail:providerStateMedicaidID::string AS provider_state_medicaid_id
,TO_TIMESTAMP_TZ(JSON_DATA:envelope:instance:providerDetail:providerLastUpdated::datetime) AS provider_last_updated
FROM STAGEDATA.PROVIDER_DETAIL
;