!set variable_substitution=true;

create or replace view QUALITY.CCD_PATIENTS_ATHENA_VW(
	FILENAME,
	MRN,
	SECTION_TITLE,
	HEADER_XMLNS,
	HEADER_XMLNS_SDTC,
	HEADER_XMLNS_VOC,
	HEADER_XMLNS_XSI,
	HEADER_REALM_CODE,
	HEADER_TYPE_ID_EXTENSION,
	HEADER_TYPE_ID_ROOT,
	TEMPLATE_ID_EXTENSION_1,
	TEMPLATE_ID_ROOT_1,
	TEMPLATE_ID_ROOT_2,
	TEMPLATE_ID_EXTENSION_3,
	TEMPLATE_ID_ROOT_3,
	TEMPLATE_ID_ROOT_4,
	ID_EXTENSION,
	ID_ROOT,
	HEADER_CODE,
	HEADER_CODE_SYSTEM,
	HEADER_CODE_SYSTEM_NAME,
	HEADER_DISPLAY_NAME,
	EFFECTIVE_TIME,
	CONFIDENTIALITY_CODE,
	CONFIDENTIALITY_CODE_SYSTEM,
	CONFIDENTIALITY_CODE_SYSTEM_NAME,
	CONFIDENTIALITY_CODE_DISPLAY_NAME,
	LANGUAGE_CODE,
	HL7_GMA_ID_EXT,
	HL7_GMA_ID_OID,
	PAT_ROLE_PATIENT_ID,
	PAT_ROLE_PATIENT_ID_OID,
	PAT_ROLE_PATIENT_MRN,
	PAT_ROLE_PATIENT_MRN_OID,
	ADDRESS_USE,
	STREET_ADDRESS_LINE_1,
	STREET_ADDRESS_LINE_2,
	CITY,
	STATE,
	ZIP_CODE,
	TELECOM_USE_1,
	TELEPHONE_NUMBER,
	TELECOM_USE_2,
	TELECOM_VALUE_2,
	TELECOM_USE_3,
	TELECOM_VALUE_3,
	PATIENT_USE_1,
	PATIENT_QUALIFIER_1,
	PATIENT_NAME_1,
	PATIENT_USE_2,
	PATIENT_QUALIFIER_2,
	PATIENT_NAME_2,
	ADMIN_GENDER_CODE,
	ADMIN_GENDER_CODE_SYSTEM,
	ADMIN_GENDER_CODE_SYSTEM_NAME,
	ADMIN_GENDER_DISPLAY_NAME,
	PATIENT_BIRTH_DATE,
	DECEASED_INDICATOR,
	MARITAL_STATUS_CODE,
	MARITAL_STATUS_CODE_SYSTEM,
	MARITAL_STATUS_CODE_SYSTEM_NAME,
	MARITAL_STATUS_DISPLAY_NAME,
	RACE_CODE_NULL,
	RACE_CODE,
	RACE_CODE_SYSTEM,
	RACE_CODE_SYSTEM_NAME,
	RACE_CODE_DISPLAY_NAME,
	ETHNIC_GROUP_NULL,
	ETHNIC_GROUP_CODE,
	ETHNIC_GROUP_CODE_SYSTEM,
	ETHNIC_GROUP_CODE_SYSTEM_NAME,
	ETHNIC_GROUP_DISPLAY_NAME,
	ETHNIC_LANGUAGE_CODE,
	LANGUAGE_PREFERRED_IND,
	CUSTODIAN_TYPE_CODE,
	ASSIGNED_CLASS_CODE,
	REP_ORG_CLASS_CODE,
	CUST_API_RESOURCE_ID,
	CUST_API_RESOURCE_ID_OID,
	CUST_NPI,
	CUST_NPI_OID,
	CUST_FEDERAL_TAX_ID,
	CUST_FEDERAL_TAX_ID_OID,
	REP_CUST_ORG_NAME,
	REP_CUST_ORG_TELECOM_USE,
	REP_CUST_ORG_TELEPHONE_NUMBER,
	REP_CUST_ORG_STREET_ADDRESS_1,
	REP_CUST_ORG_STREET_ADDRESS_2,
	REP_CUST_ORG_CTIY,
	REP_CUST_ORG_STATE,
	REP_CUST_ORG_POSTAL_CODE,
	INFO_RECIP_DOCTOR_FACILITY,
	INFO_RECIP_DOCTOR_FACILITY_OID,
	INFO_RECIP_NPI,
	INFO_RECIP_NPI_OID,
	INFO_RECIPIENT_NAME,
	PARTICIPANT_TYPE_CODE,
	PARTICIPANT_CLASS_CODE,
	PARTICIPANT_NULLVAL,
	PARTICIPANT_ADDR_NULLVAL,
	PARTICIPANT_TELECOM_NULLVAL,
	PARTICIPANT_PERSON_NULLVAL,
	PARTICIPANT_NAME_NULLVAL,
	SERVICE_EVENT_CLASS_CODE,
	SERVICE_EVENT_TIME_TYPE,
	SERVICE_EVENT_TIME_LOW,
	SERVICE_EVENT_TIME_HIGH,
	PATIENT_ATHENA_HKEY,
	ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as 
WITH
RT_PATIENT_ROLE_ID AS (
    SELECT FILENAME
          ,SECTION_TITLE   
          ,MRN
          ,MAX(CASE WHEN AUTHOR_ID_ROOT = '2.16.840.1.113883.3.8592' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS HL7_GMA_ID_EXT
          ,MAX(CASE WHEN AUTHOR_ID_ROOT = '2.16.840.1.113883.3.8592' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS HL7_GMA_ID_OID                              
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'athenahealth athenaPractice-athenaFlow PatientId' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS PATIENT_ID
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'athenahealth athenaPractice-athenaFlow PatientId' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS PATIENT_ID_OID
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'athenahealth athenaPractice-athenaFlow PatientMRN' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS PATIENT_MRN
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'athenahealth athenaPractice-athenaFlow PatientMRN' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS PATIENT_MRN_OID
    FROM ( 
       SELECT 
           BASE_FILENAME AS FILENAME
          ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
          ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
          ,GET( ID.VALUE,'@assigningAuthorityName')::STRING as AUTHOR_ID_AUTHORITY_NAME
          ,GET( ID.VALUE,'@extension')::STRING as AUTHOR_ID_EXT
          ,GET( ID.VALUE, '@root')::STRING as AUTHOR_ID_ROOT
          ,GET( ID.VALUE, '@' ) id_value_at
         FROM &{idap_lake}.QUALITY.RAW_XML X         
             ,LATERAL FLATTEN( x.xml:"$") REC_TARGET
             ,LATERAL FLATTEN( REC_TARGET.VALUE:"$") PATIENT_ROLE
            -- REVIEWERS - QUESTION
            -- WHY DO WE NEED TO DO THE PATIENT_ROLE.THIS -- AND NOT PATIENT_ROLE.VALUE
            -- IN THE FOLLOWING STATEMENT?
             ,LATERAL FLATTEN( patient_role.this:"$") ID
         WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
         AND GET( REC_TARGET.VALUE, '@') = 'recordTarget'
         AND GET(ID.VALUE, '@') = 'id'
     )
    GROUP BY FILENAME,
             SECTION_TITLE,
             MRN
),
INFO_RECIPIENT_ID  AS (
    SELECT FILENAME
          ,SECTION_TITLE   
          ,MRN
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID_EXT ELSE NULL END) AS DOCTOR_FACILITY
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID_ROOT ELSE NULL END) AS DOCTOR_FACILITY_OID
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN ID_EXT ELSE NULL END) AS NPI
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN ID_ROOT ELSE NULL END) AS NPI_OID
    FROM (
       SELECT 
           BASE_FILENAME AS FILENAME
          ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
          ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
          ,GET( ID.VALUE,'@assigningAuthorityName')::STRING as ID_AUTHORITY_NAME
          ,GET( ID.VALUE,'@extension')::STRING as ID_EXT
          ,GET( ID.VALUE, '@root')::STRING as ID_ROOT         
         FROM &{idap_lake}.QUALITY.RAW_XML X
             ,LATERAL FLATTEN( X.XML:"$") INFO_RECIPIENT
             ,LATERAL FLATTEN( INFO_RECIPIENT.value:"$") INTEND_RECIPIENT
         --
         -- REVIEWERS: QUESTION
         -- ONCE AGAIN, WHY DOES "INTENDENDED_RECIPIENT.THIS" WORK? AND *.VALUE NOT WORK??
             ,LATERAL FLATTEN( INTEND_RECIPIENT.this:"$") ID
         WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
         AND GET( INFO_RECIPIENT.VALUE, '@') = 'informationRecipient'
         AND intend_recipient.value = 'intendedRecipient'
         AND GET(ID.VALUE, '@') = 'id'
         --AND FILENAME = '14644496.xml' -- '25126358.xml'
     )
    GROUP BY FILENAME,
             SECTION_TITLE,
             MRN
),
CUSTODIAN_ID AS (
    SELECT FILENAME
          ,SECTION_TITLE   
          ,MRN
          --,FIRST_ID_ROOT
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 API Resource Identifier' 
                    THEN ID_EXT ELSE NULL END) AS API_RESOURCE_ID
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 API Resource Identifier'  
                    THEN ID_ROOT ELSE NULL END) AS API_RESOURCE_ID_OID
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN ID_EXT ELSE NULL END) AS NPI
          ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers'
                    THEN ID_ROOT ELSE NULL END) AS NPI_OID                                        
          ,MAX(CASE WHEN ID_ROOT = '2.16.840.1.113883.4.2'
                    THEN ID_EXT ELSE NULL END) AS FEDERAL_TAX_ID
          ,MAX(CASE WHEN ID_ROOT = '2.16.840.1.113883.4.2' 
                    THEN ID_ROOT ELSE NULL END) AS FEDERAL_TAX_ID_OID      
    FROM (    
       SELECT 
           BASE_FILENAME AS FILENAME
          ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
          ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
          ,GET( ID.VALUE,'@assigningAuthorityName')::STRING as ID_AUTHORITY_NAME
          ,GET( ID.VALUE,'@extension')::STRING as ID_EXT
          ,GET( ID.VALUE, '@root')::STRING as ID_ROOT
         FROM &{idap_lake}.QUALITY.RAW_XML X 
             ,LATERAL FLATTEN( x.xml:"$") custodian
             ,LATERAL FLATTEN( custodian.VALUE:"$") ASSIGN_CUSTODIAN
             ,LATERAL FLATTEN( assign_custodian.this:"$") REP_CUST_ORG
             ,LATERAL FLATTEN( REP_CUST_ORG.this:"$") ID
       WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
         AND GET( CUSTODIAN.VALUE, '@') = 'custodian'
         AND ASSIGN_CUSTODIAN.VALUE = 'assignedCustodian'
         AND REP_CUST_ORG.VALUE = 'representedCustodianOrganization'
    )   
    GROUP BY FILENAME,
             SECTION_TITLE,
             MRN
),
MAIN AS
(
SELECT 
      BASE_FILENAME AS FILENAME
     ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
     ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
     ,GET( X.XML, '@xmlns')::STRING as HEADER_XMLNS
     ,GET( X.XML, '@xmlns:sdtc')::STRING as HEADER_XMLNS_SDTC
     ,GET( X.XML, '@xmlns:voc')::STRING as HEADER_XMLNS_VOC
     ,GET( X.XML, '@xmlns:xsi')::STRING as HEADER_XMLNS_XSI
     ,GET( XMLGET(X.XML, 'realmCode'),'@code')::STRING as HEADER_REALM_CODE
     ,GET( XMLGET(X.XML, 'typeId'),'@extension')::STRING as HEADER_TYPE_ID_EXTENSION
     ,GET( XMLGET(X.XML, 'typeId'),'@root')::STRING as HEADER_TYPE_ID_ROOT
     ,GET( XMLGET(X.XML, 'templateId'),'@extension')::STRING as TEMPLATE_ID_EXTENSION_1
     ,GET( XMLGET(X.XML, 'templateId'),'@root')::STRING as TEMPLATE_ID_ROOT_1
     ,GET( XMLGET(X.XML, 'templateId',1),'@root')::STRING as TEMPLATE_ID_ROOT_2
     ,GET( XMLGET(X.XML, 'templateId',2),'@extension')::STRING as TEMPLATE_ID_EXTENSION_3
     ,GET( XMLGET(X.XML, 'templateId',2),'@root')::STRING as TEMPLATE_ID_ROOT_3
     ,GET( XMLGET(X.XML, 'templateId',3),'@root')::STRING as TEMPLATE_ID_ROOT_4
     ,GET( XMLGET(X.XML, 'id'),'@extension')::STRING as ID_EXTENSION
     ,GET( XMLGET(X.XML, 'id'),'@root')::STRING as ID_ROOT
     ,GET( XMLGET(X.XML, 'code'),'@code')::STRING as HEADER_CODE
     ,GET( XMLGET(X.XML, 'code'),'@codeSystem')::STRING as HEADER_CODE_SYSTEM
     ,GET( XMLGET(X.XML, 'code'),'@codeSystemName')::STRING as HEADER_CODE_SYSTEM_NAME
     ,GET( XMLGET(X.XML, 'code'),'@displayName')::STRING as HEADER_DISPLAY_NAME
     ,GET( XMLGET(X.XML, 'effectiveTime'),'@value')::STRING as EFFECTIVE_TIME
     ,GET( XMLGET(X.XML, 'confidentialityCode'),'@code')::STRING as CONFIDENTIALITY_CODE
     ,GET( XMLGET(X.XML, 'confidentialityCode'),'@codeSystem')::STRING as CONFIDENTIALITY_CODE_SYSTEM
     ,GET( XMLGET(X.XML, 'confidentialityCode'),'@codeSystemName')::STRING as CONFIDENTIALITY_CODE_SYSTEM_NAME
     ,GET( XMLGET(X.XML, 'confidentialityCode'),'@displayName')::STRING as CONFIDENTIALITY_CODE_DISPLAY_NAME
     ,GET( XMLGET(X.XML, 'languageCode'),'@code')::STRING as LANGUAGE_CODE
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'@use')::STRING as ADDRESS_USE
     ,XMLGET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'streetAddressLine'):"$"::STRING as STREET_ADDRESS_LINE_1
     ,XMLGET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'streetAddressLine',1):"$"::STRING as STREET_ADDRESS_LINE_2
     ,XMLGET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'city'):"$"::STRING as CITY
     ,XMLGET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'state'):"$"::STRING as STATE
     ,XMLGET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'addr'),'postalCode'):"$"::STRING as ZIP_CODE
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom'),'@use')::STRING as TELECOM_USE_1
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom'),'@value')::STRING as TELEPHONE_NUMBER
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom',1),'@use')::STRING as TELECOM_USE_2
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom',1),'@value')::STRING as TELECOM_VALUE_2
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom',2),'@use')::STRING as TELECOM_USE_3
     ,GET( XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'telecom',2),'@value')::STRING as TELECOM_VALUE_3
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'@use')::STRING as PATIENT_USE_1
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'given'),'@qualifier')::STRING as PATIENT_QUALIFIER_1
     ,CONCAT(
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'family'):"$"::STRING,''), ', ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'given'):"$"::STRING,''), ' ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'given',1):"$"::STRING,'')
          ) AS PATIENT_NAME_1
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'@use')::STRING as PATIENT_USE_2
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'given'),'@qualifier')::STRING as PATIENT_QUALIFIER_2
     ,CONCAT(
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'family'):"$"::STRING,''), ', ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'given'):"$"::STRING,''), ' ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'given',1):"$"::STRING,'')
          ) AS PATIENT_NAME_2	  
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'administrativeGenderCode'),'@code')::STRING as ADMIN_GENDER_CODE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'administrativeGenderCode'),'@codeSystem')::STRING as ADMIN_GENDER_CODE_SYSTEM
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'administrativeGenderCode'),'@codeSystemName')::STRING as ADMIN_GENDER_CODE_SYSTEM_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'administrativeGenderCode'),'@displayName')::STRING as ADMIN_GENDER_DISPLAY_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'birthTime'),'@value')::STRING as PATIENT_BIRTH_DATE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'sdtc:deceasedInd'),'@value')::STRING as DECEASED_INDICATOR
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'maritalStatusCode'),'@code')::STRING as MARITAL_STATUS_CODE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'maritalStatusCode'),'@codeSystem')::STRING as MARITAL_STATUS_CODE_SYSTEM
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'maritalStatusCode'),'@codeSystemName')::STRING as MARITAL_STATUS_CODE_SYSTEM_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'maritalStatusCode'),'@displayName')::STRING as MARITAL_STATUS_DISPLAY_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'raceCode'),'@nullFlavor')::STRING as RACE_CODE_NULL
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'raceCode'),'@code')::STRING as RACE_CODE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'raceCode'),'@codeSystem')::STRING as RACE_CODE_SYSTEM
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'raceCode'),'@codeSystemName')::STRING as RACE_CODE_SYSTEM_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'raceCode'),'@displayName')::STRING as RACE_CODE_DISPLAY_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'ethnicGroupCode'),'@nullFlavor')::STRING as ETHNIC_GROUP_NULL
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'ethnicGroupCode'),'@code')::STRING as ETHNIC_GROUP_CODE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'ethnicGroupCode'),'@codeSystem')::STRING as ETHNIC_GROUP_CODE_SYSTEM
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'ethnicGroupCode'),'@codeSystemName')::STRING as ETHNIC_GROUP_CODE_SYSTEM_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'ethnicGroupCode'),'@displayName')::STRING as ETHNIC_GROUP_DISPLAY_NAME
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'languageCommunication'),'languageCode'),'@code')::STRING as ETHNIC_LANGUAGE_CODE
     ,GET( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'languageCommunication'),'preferenceInd'),'@value')::STRING as LANGUAGE_PREFERRED_IND
     -- <custodian>
     ,GET(XMLGET(X.XML, 'custodian'),'@typeCode')::STRING as CUSTODIAN_TYPE_CODE
     ,GET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'@classCode')::STRING as ASSIGNED_CLASS_CODE
     ,GET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'@classCode')::STRING as REP_ORG_CLASS_CODE
     ,XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'name'):"$"::STRING as REP_CUST_ORG_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'telecom'),'@use')::STRING as REP_CUST_ORG_TELECOM_USE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'telecom'),'@value')::STRING as REP_CUST_ORG_TELEPHONE_NUMBER
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'streetAddressLine'):"$"::STRING as REP_CUST_ORG_STREET_ADDRESS_1
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'streetAddressLine',1):"$"::STRING as REP_CUST_ORG_STREET_ADDRESS_2
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'city'):"$"::STRING as REP_CUST_ORG_CTIY
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'state'):"$"::STRING as REP_CUST_ORG_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'postalCode'):"$"::STRING as REP_CUST_ORG_POSTAL_CODE
     ,CONCAT(
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'informationRecipient'),'intendedRecipient'),'informationRecipient'),'name'),'family'):"$"::STRING,''), ', ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'informationRecipient'),'intendedRecipient'),'informationRecipient'),'name'),'given'):"$"::STRING,''), ' ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'informationRecipient'),'intendedRecipient'),'informationRecipient'),'name'),'given',1):"$"::STRING,'')
        ) AS INFO_RECIPIENT_NAME		
     -- <participant> 
     ,GET(XMLGET(X.XML, 'participant'),'@typeCode')::STRING as PARTICIPANT_TYPE_CODE 
     ,GET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'@classCode')::STRING as PARTICIPANT_CLASS_CODE
     ,GET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'@nullFlavor')::STRING as PARTICIPANT_NULLVAL
     ,GET(XMLGET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'addr'),'@nullFlavor')::STRING as PARTICIPANT_ADDR_NULLVAL
     ,GET(XMLGET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'telecom'),'@nullFlavor')::STRING as PARTICIPANT_TELECOM_NULLVAL 
     ,GET(XMLGET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'associatedPerson'),'@nullFlavor')::STRING as PARTICIPANT_PERSON_NULLVAL
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'participant'),'associatedEntity'),'associatedPerson'),'name'),'@nullFlavor')::STRING as PARTICIPANT_NAME_NULLVAL
     -- <documentationOf>
     ,GET(XMLGET(XMLGET(X.XML, 'documentationOf'),'serviceEvent'),'@classCode')::STRING as SERVICE_EVENT_CLASS_CODE
     ,GET(XMLGET(XMLGET(XMLGET(X.XML, 'documentationOf'),'serviceEvent'),'effectiveTime'),'@xsi:type')::STRING as SERVICE_EVENT_TIME_TYPE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'documentationOf'),'serviceEvent'),'effectiveTime'),'low'),'@value')::STRING as SERVICE_EVENT_TIME_LOW 
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'documentationOf'),'serviceEvent'),'effectiveTime'),'high'),'@value')::STRING as SERVICE_EVENT_TIME_HIGH
     ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [ FILENAME, 
                                                 MRN, 
                                                 SECTION_TITLE,
                                                 ID_EXTENSION,
                                                 PATIENT_NAME_1,
                                                 PATIENT_NAME_2
                                                ] ) AS PATIENT_ATHENA_HKEY
     ,ROW_NUM
	 ,TS_LAST_MODIFY
	 ,SCAN_TIME
FROM &{idap_lake}.QUALITY.RAW_XML X  
    ,LATERAL FLATTEN( X.XML:"$") RECORDTARGET
    ,LATERAL FLATTEN( recordTarGET.value:"$") PATIENTROLE
WHERE GET( recordTarget.value,'@') ='recordTarget'
AND SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
AND PATIENTROLE.VALUE like '%patientRole%'
AND BASE_FILENAME IN (
    SELECT FILENAME FROM (
          SELECT PATIENT_MRN AS MRN, 
                 MAX( CS_TRANSACTION_ID ) || '.xml' AS FILENAME
          FROM &{idap_lake}.QUALITY.CCD_CONTROL
          GROUP BY PATIENT_MRN
          )          
    )
)
SELECT
     M.FILENAME
    ,M.MRN
    ,M.SECTION_TITLE
    ,M.HEADER_XMLNS
    ,M.HEADER_XMLNS_SDTC
    ,M.HEADER_XMLNS_VOC
    ,M.HEADER_XMLNS_XSI
    ,M.HEADER_REALM_CODE
    ,M.HEADER_TYPE_ID_EXTENSION
    ,M.HEADER_TYPE_ID_ROOT
    ,M.TEMPLATE_ID_EXTENSION_1
    ,M.TEMPLATE_ID_ROOT_1
    ,M.TEMPLATE_ID_ROOT_2
    ,M.TEMPLATE_ID_EXTENSION_3
    ,M.TEMPLATE_ID_ROOT_3
    ,M.TEMPLATE_ID_ROOT_4    
    ,M.ID_EXTENSION
    ,M.ID_ROOT
    ,M.HEADER_CODE
    ,M.HEADER_CODE_SYSTEM
    ,M.HEADER_CODE_SYSTEM_NAME
    ,M.HEADER_DISPLAY_NAME
    ,M.EFFECTIVE_TIME
    ,M.CONFIDENTIALITY_CODE
    ,M.CONFIDENTIALITY_CODE_SYSTEM
    ,M.CONFIDENTIALITY_CODE_SYSTEM_NAME
    ,M.CONFIDENTIALITY_CODE_DISPLAY_NAME
    ,M.LANGUAGE_CODE
    ,PR_ID.HL7_GMA_ID_EXT AS HL7_GMA_ID_EXT
    ,PR_ID.HL7_GMA_ID_OID AS HL7_GMA_ID_OID
    ,PR_ID.PATIENT_ID AS PAT_ROLE_PATIENT_ID
    ,PR_ID.PATIENT_ID_OID AS PAT_ROLE_PATIENT_ID_OID
    ,PR_ID.PATIENT_MRN AS PAT_ROLE_PATIENT_MRN
    ,PR_ID.PATIENT_MRN_OID AS PAT_ROLE_PATIENT_MRN_OID
    ,M.ADDRESS_USE
    ,M.STREET_ADDRESS_LINE_1
    ,M.STREET_ADDRESS_LINE_2
    ,M.CITY
    ,M.STATE
    ,M.ZIP_CODE
    ,M.TELECOM_USE_1
    ,M.TELEPHONE_NUMBER
    ,M.TELECOM_USE_2
    ,M.TELECOM_VALUE_2
    ,M.TELECOM_USE_3
    ,M.TELECOM_VALUE_3
    ,M.PATIENT_USE_1
    ,M.PATIENT_QUALIFIER_1
    ,M.PATIENT_NAME_1
    ,M.PATIENT_USE_2
    ,M.PATIENT_QUALIFIER_2
    ,M.PATIENT_NAME_2
    ,M.ADMIN_GENDER_CODE
    ,M.ADMIN_GENDER_CODE_SYSTEM
    ,M.ADMIN_GENDER_CODE_SYSTEM_NAME
    ,M.ADMIN_GENDER_DISPLAY_NAME
    ,M.PATIENT_BIRTH_DATE
    ,M.DECEASED_INDICATOR
    ,M.MARITAL_STATUS_CODE
    ,M.MARITAL_STATUS_CODE_SYSTEM
    ,M.MARITAL_STATUS_CODE_SYSTEM_NAME
    ,M.MARITAL_STATUS_DISPLAY_NAME
    ,M.RACE_CODE_NULL
    ,M.RACE_CODE
    ,M.RACE_CODE_SYSTEM
    ,M.RACE_CODE_SYSTEM_NAME
    ,M.RACE_CODE_DISPLAY_NAME
    ,M.ETHNIC_GROUP_NULL
    ,M.ETHNIC_GROUP_CODE
    ,M.ETHNIC_GROUP_CODE_SYSTEM
    ,M.ETHNIC_GROUP_CODE_SYSTEM_NAME
    ,M.ETHNIC_GROUP_DISPLAY_NAME
    ,M.ETHNIC_LANGUAGE_CODE
    ,M.LANGUAGE_PREFERRED_IND
    ,M.CUSTODIAN_TYPE_CODE
    ,M.ASSIGNED_CLASS_CODE
    ,M.REP_ORG_CLASS_CODE
    ,CID.API_RESOURCE_ID AS CUST_API_RESOURCE_ID
    ,CID.API_RESOURCE_ID_OID AS CUST_API_RESOURCE_ID_OID
    ,CID.NPI AS CUST_NPI
    ,CID.NPI_OID AS CUST_NPI_OID
    ,CID.FEDERAL_TAX_ID AS CUST_FEDERAL_TAX_ID
    ,CID.FEDERAL_TAX_ID_OID AS CUST_FEDERAL_TAX_ID_OID
    ,M.REP_CUST_ORG_NAME
    ,M.REP_CUST_ORG_TELECOM_USE
    ,M.REP_CUST_ORG_TELEPHONE_NUMBER
    ,M.REP_CUST_ORG_STREET_ADDRESS_1
    ,M.REP_CUST_ORG_STREET_ADDRESS_2
    ,M.REP_CUST_ORG_CTIY
    ,M.REP_CUST_ORG_STATE
    ,M.REP_CUST_ORG_POSTAL_CODE
    ,IR_ID.DOCTOR_FACILITY AS INFO_RECIP_DOCTOR_FACILITY
    ,IR_ID.DOCTOR_FACILITY_OID AS INFO_RECIP_DOCTOR_FACILITY_OID
    ,IR_ID.NPI AS INFO_RECIP_NPI
    ,IR_ID.NPI_OID AS INFO_RECIP_NPI_OID
    ,M.INFO_RECIPIENT_NAME
    ,M.PARTICIPANT_TYPE_CODE
    ,M.PARTICIPANT_CLASS_CODE
    ,M.PARTICIPANT_NULLVAL
    ,M.PARTICIPANT_ADDR_NULLVAL
    ,M.PARTICIPANT_TELECOM_NULLVAL
    ,M.PARTICIPANT_PERSON_NULLVAL
    ,M.PARTICIPANT_NAME_NULLVAL
    ,M.SERVICE_EVENT_CLASS_CODE
    ,M.SERVICE_EVENT_TIME_TYPE
    ,M.SERVICE_EVENT_TIME_LOW
    ,M.SERVICE_EVENT_TIME_HIGH
    ,M.PATIENT_ATHENA_HKEY
    ,M.ROW_NUM
    ,M.TS_LAST_MODIFY
    ,M.SCAN_TIME
FROM MAIN M
LEFT OUTER JOIN RT_PATIENT_ROLE_ID PR_ID
  ON PR_ID.FILENAME = M.FILENAME
  AND PR_ID.MRN = M.MRN
  AND PR_ID.SECTION_TITLE = M.SECTION_TITLE
LEFT OUTER JOIN INFO_RECIPIENT_ID IR_ID
   ON IR_ID.FILENAME = M.FILENAME
  AND IR_ID.MRN = M.MRN
  AND IR_ID.SECTION_TITLE = M.SECTION_TITLE
LEFT OUTER JOIN CUSTODIAN_ID CID
   ON CID.FILENAME = M.FILENAME
  AND CID.MRN = M.MRN
  AND CID.SECTION_TITLE = M.SECTION_TITLE;

!set variable_substitution=false;
