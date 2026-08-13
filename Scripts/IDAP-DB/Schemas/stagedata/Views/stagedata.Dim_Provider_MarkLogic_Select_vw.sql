CREATE OR REPLACE VIEW STAGEDATA.DIM_PROVIDER_MARKLOGIC_SELECT_VW
AS
SELECT
'N/A-MARKLOGIC' AS MD5_Value_Text
,TO_BOOLEAN('FALSE') AS IS_LOGICAL_DELETE_FLAG
,TO_TIMESTAMP_TZ('1900-01-01') AS Row_Effective_Datetime
,TO_TIMESTAMP_TZ('9999-12-31') AS Row_Expiration_Datetime
,TO_BOOLEAN(1) AS Is_CurrentRow_Flag
,provider_detail_vw.data_source_name AS DATA_SOURCE_NAME
,provider_detail_vw.universal_provider_id AS Provider_Id
,provider_detail_vw.tpa_client_id
,provider_detail_vw.tpa_id
,provider_detail_vw.tpa_div_id AS TPA_Division_Id
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN 1
    WHEN 'Facility' THEN 2
    WHEN 'Medical Group' THEN 3
    WHEN 'Pharmacy' THEN 4
    ELSE 0
END AS Provider_Type_Code
,IFNULL(provider_detail_vw.provider_sub_type_desc,'Unknown') AS Provider_Type_Desc
,IFNULL(TRY_TO_NUMBER(role_type.target_value), 0) AS Provider_role_type_Code 
,IFNULL(role_type.target_desc,'Unknown') as Provider_role_type_Desc
,IFNULL(provider_detail_vw.full_name,'Unknown') AS Provider_Full_Name
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.last_name,'')
    ELSE 'n/a'
END AS Practitioner_Last_Name
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.first_name,'')
    ELSE 'n/a'
END AS Practitioner_First_Name
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.middle_name,'')
    ELSE 'n/a'
END AS Practitioner_Middle_Name
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.middle_initial_name,'')
    ELSE 'n/a'
END AS Practitioner_Middle_Initial
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.suffix_name,'')
    ELSE 'n/a'
END AS Practitioner_Name_Suffix
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(gender_code.target_value,'U')
    ELSE 'n/a'
END AS Practitioner_gender_code 
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(gender_code.target_desc,'Unknown')
    ELSE 'n/a'
END AS Practitioner_Gender_Name 
,provider_detail_vw.birth_date AS Practitioner_Birth_Date
,IFNULL(provider_detail_vw.tin_nbr,'') AS Medical_Group_TIN_Nbr
,IFNULL(provider_detail_vw.upin_nbr,'') AS Practitioner_UPIN_Nbr
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.social_security_nbr,'Unknown')
    ELSE 'n/a'
END AS Practitioner_SSN_Nbr
,CASE (provider_sub_type_desc)
    WHEN 'Practitioner' THEN IFNULL(provider_detail_vw.degree_text,'Unknown')
    ELSE 'n/a'
END AS Practitioner_Degree
,IFNULL(provider_detail_vw.email_address_text,'Unknown') AS Provider_Email_Address
,IFNULL(provider_detail_vw.wfb_site_url_text,'Unknown') AS Provider_Website_URL
,IFNULL(primary_specialty.target_desc,'Unknown') AS Primary_Specialty_Name
,IFNULL(TRY_TO_NUMBER(primary_pho.target_value), 0) as Primary_PHO_Code
,IFNULL(primary_pho.target_desc,'Unknown') as Primary_PHO_Name
,provider_detail_vw.primary_pho_termination_date AS Primary_PHO_Termination_Date
,0 AS Secondary_PHO_Code
,IFNULL(provider_detail_vw.secondary_pho_desc,'Unknown') as Secondary_PHO_Name
,provider_detail_vw.Secondary_PHO_Termination_Date AS Secondary_PHO_Termination_Date
,0 AS Tertiary_PHO_Code
,IFNULL(provider_detail_vw.tertiary_pho_desc,'Unknown') AS Tertiary_PHO_Name
,provider_detail_vw.tertiary_pho_termination_date AS Tertiary_PHO_Termination_Date
,IFNULL(provider_detail_vw.provider_start_date,'1900-01-01') AS Provider_Start_Date
,provider_detail_vw.facility_inception_date AS Facility_Inception_Date
,IFNULL(provider_detail_vw.active_ind,'Y') AS Provider_Active_Ind
,IFNULL(provider_detail_vw.locum_tenens_ind,'U') as Practitioner_Locum_Tenens_Ind
,IFNULL(provider_detail_vw.invisible_provider_Ind,'U') AS Invisible_Provider_Ind
,IFNULL(provider_detail_vw.temporary_provider_ind,'U') AS Temporary_Provider_Ind
,IFNULL(provider_detail_vw.pa_medicaid_ind,'U') AS PA_Medicaid_Ind
,IFNULL(provider_detail_vw.pp_aca_enchanced_pay_ind,'U') AS PP_ACA_Enhanced_Pay_Ind
,IFNULL(provider_detail_vw.provider_malpractice_coverage_ind,'U') AS Has_Malpractice_Insurance_Ind
,0 AS Ownership_Status_Code
,IFNULL(provider_detail_vw.ownership_status_desc,'Unknown') AS Ownership_Status_Desc
,provider_detail_vw.uri
,provider_detail_vw.source_provider_nbr
,TO_VARCHAR(PROVIDER_DETAIL_KEY) AS SOURCE_ID
,'MARKLOGIC' AS SOURCE_SYSTEM
,TO_BOOLEAN(IFF(DIM_PROVIDER.DIM_PROVIDER_KEY IS NULL, FALSE, TRUE)) AS HAS_MATCH_FROM_SQL_SERVER
,DIM_PROVIDER.DIM_PROVIDER_KEY AS SQL_SERVER_DIM_PROVIDER_KEY

FROM stagedata.provider_detail_vw
    left outer join stagedata.reference_data_singular_vw role_type
        ON (role_type.reference_key = provider_detail_vw.provider_role_type_desc_key)

    left outer join stagedata.reference_data_singular_vw gender_code
        ON (gender_code.reference_key = provider_detail_vw.gender_desc_key)
    
    left outer join stagedata.reference_data_singular_vw primary_specialty 
        ON (primary_specialty.reference_key = provider_detail_vw.PRIMARY_SPECIALTY_DESC_KEY 
        AND primary_specialty.data_source_name = provider_detail_vw.data_source_name
        AND primary_specialty.target_reference_set ='specialty')

    left outer join stagedata.reference_data_singular_vw primary_pho
        on (primary_pho.reference_key = provider_detail_vw.primary_pho_desc_key)
    
    left outer join stagedata.provider_ods_data_source
        on (provider_ods_data_source.data_source_name = provider_detail_vw.data_source_name)
    
    left outer join dimdata.dim_provider
        on (dim_provider.source_system = 'SQLSERVER'
        and dim_provider.is_currentrow_flag = 'TRUE'
        and dim_provider.tpa_client_id = provider_detail_vw.tpa_client_id
        and dim_provider.tpa_id = provider_detail_vw.tpa_id
        and dim_provider.tpa_division_id = provider_detail_vw.tpa_div_id
        and dim_provider.provider_Id = concat(provider_ods_data_source.data_source_key,'-',provider_detail_vw.source_provider_nbr)
        )
where provider_detail_vw.tpa_client_id is not null -- put in for a quick fix on 2021-12-06, will need REMOVED!
and provider_detail_vw.data_source_name not in (select distinct data_source_name from rawdata.datahub_provider_detail_base) --exclude data sources in UPMCHP_DATAHUB
and provider_detail_vw.data_source_name NOT IN ('ESI', 'ESIF14') --exclude pharmacy records
;