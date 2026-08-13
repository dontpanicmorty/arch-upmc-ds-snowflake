!set variable_substitution=true;

create or replace view QUALITY.CCD_PATIENTS_ATHENA_AUTHOR_VW(
	PATIENT_AUTHOR_HKEY,
	TEMPLATE_OID_1,
	TEMPLATE_OID_2,
	PVID,
	PVID_OID,
	DOCTOR_FACILITY,
	DOCTOR_FACILITY_OID,
	NPI,
	NPI_OID,
	ASSIGN_AUTHOR_OID,
	AUTHOR_ADDR_NULL,
	AUTHOR_ADDR_STREET_ADDRESS_NULL,
	AUTHOR_ADDR_STREET_ADDRESS_1,
	AUTHOR_ADDR_STREET_ADDRESS_2,
	AUTHOR_ADDR_CITY_NULL,
	AUTHOR_ADDR_CITY,
	AUTHOR_ADDR_STATE_NULL,
	AUTHOR_ADDR_STATE,
	AUTHOR_ADDR_ZIP_CODE_NULL,
	AUTHOR_ADDR_ZIP_CODE,
	AUTHOR_ADDR_COUNTRY_NULL,
	AUTHOR_TELECOM_NULL,
	ASSIGNED_PERSON_NAME,
	AUTHORING_DEVICE_MODEL,
	AUTHORING_DEVICE_SOFTWARE,
	R_API_RESOURCE_ID,
	R_API_RESOURCE_ID_OID,
	R_NPI,
	R_NPI_OID,
	R_FEDERAL_TAX_ID,
	R_FEDERAL_TAX_ID_OID,
	REP_ORG_NAME,
	REP_ORG_TELECOM_USE,
	REP_ORG_TELEPHONE_NUMBER,
	REP_ORG_STREET_ADDRESS_1,
	REP_ORG_STREET_ADDRESS_2,
	REP_ORG_CITY,
	REP_ORG_STATE,
	REP_ORG_ZIP_CODE,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as
WITH
AA_REP_ORG_ID AS (
    SELECT FILENAME
          ,SECTION_TITLE   
          ,MRN
          ,FIRST_ID_ROOT
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
          ,GET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'id'),'@root')::STRING as FIRST_ID_ROOT
          ,GET( ID.VALUE,'@assigningAuthorityName')::STRING as ID_AUTHORITY_NAME
          ,GET( ID.VALUE,'@extension')::STRING as ID_EXT
          ,GET( ID.VALUE, '@root')::STRING as ID_ROOT
         FROM &{idap_lake}.QUALITY.RAW_XML X 
             ,LATERAL FLATTEN( x.xml:"$") author
             ,LATERAL FLATTEN( AUTHOR.VALUE:"$") A_AUTHOR
             ,LATERAL FLATTEN( A_AUTHOR.VALUE:"$") REP_ORG
             ,LATERAL FLATTEN( REP_ORG.VALUE:"$") ID 
       WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
         AND GET(author.VALUE, '@') = 'author'
         AND GET(a_author.VALUE, '@') = 'assignedAuthor'
         AND GET( REP_ORG.VALUE, '@') = 'representedOrganization'
         AND GET(ID.VALUE, '@') = 'id'
         --AND BASE_FILENAME = '14644496.xml'
    )   
    GROUP BY FILENAME,
             SECTION_TITLE,
             MRN,
             FIRST_ID_ROOT
),
ASSIGNED_AUTHOR_ID AS (
    SELECT FILENAME
          ,SECTION_TITLE   
          ,MRN
          ,FIRST_ID_ROOT
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = '1000-36286-8679 Providers by PVID' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS PVID
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = '1000-36286-8679 Providers by PVID' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS PVID_OID                    
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS DOCTOR_FACILITY
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS DOCTOR_FACILITY_OID                                        
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN AUTHOR_ID_EXT ELSE NULL END) AS NPI
          ,MAX(CASE WHEN AUTHOR_ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS NPI_OID      
          ,MAX(CASE WHEN AUTHOR_ID_ROOT = '1.2.840.1.113883.3.564.4631988936306347291.11'
                    THEN AUTHOR_ID_ROOT ELSE NULL END) AS ASSIGN_AUTHOR_OID  
    FROM (      
       SELECT 
           BASE_FILENAME AS FILENAME
          ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
          ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
          ,GET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'id'),'@root')::STRING as FIRST_ID_ROOT
          ,GET( ID.VALUE,'@assigningAuthorityName')::STRING as AUTHOR_ID_AUTHORITY_NAME
          ,GET( ID.VALUE,'@extension')::STRING as AUTHOR_ID_EXT
          ,GET( ID.VALUE, '@root')::STRING as AUTHOR_ID_ROOT
         FROM &{idap_lake}.QUALITY.RAW_XML X 
             ,LATERAL FLATTEN( x.xml:"$") author
             ,LATERAL FLATTEN( AUTHOR.VALUE:"$") A_AUTHOR
             ,LATERAL FLATTEN( A_AUTHOR.VALUE:"$") ID
       WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
         AND GET(author.VALUE, '@') = 'author'
         AND GET(a_author.VALUE, '@') = 'assignedAuthor'
         AND GET(ID.VALUE, '@') = 'id'
  --       AND BASE_FILENAME = '14644496.xml'
    )   
    GROUP BY FILENAME,
             SECTION_TITLE,
             MRN,
             FIRST_ID_ROOT
),
MAIN AS (
    SELECT 
      BASE_FILENAME AS FILENAME
     ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
     ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
     -- FOR THE PATIENT_ATHENA_HKEY HASH FIELD:
     ,GET( XMLGET(X.XML, 'id'),'@extension')::STRING as ID_EXTENSION
    ,CONCAT(
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'family'):"$"::STRING,''), ', ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'given'):"$"::STRING,''), ' ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name'),'given',1):"$"::STRING,'')
          ) AS PATIENT_NAME_1
    ,CONCAT(
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'family'):"$"::STRING,''), ', ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'given'):"$"::STRING,''), ' ',
         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'recordTarget'),'patientRole'),'patient'),'name',1),'given',1):"$"::STRING,'')
          ) AS PATIENT_NAME_2
     -- <author> -- use the following tag to be able to distinguish between first <author> and second <author>
     ,GET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'id'),'@root')::STRING as FIRST_ID_ROOT
     ,GET(XMLGET( AUTHOR.VALUE,'templateId'),'@root')::STRING as TEMPLATE_OID_1
     ,GET(XMLGET( AUTHOR.VALUE,'templateId',1),'@root')::STRING as TEMPLATE_OID_2
     -- Per converstaion with Architecure, removing AUTHOR_TIME as parsed field - can be re-added if deemed 
     -- necessary in the future.
     -- ,GET(XMLGET( AUTHOR.VALUE,'time'),'@value')::STRING as AUTHOR_TIME
     ,GET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'@nullFlavor')::STRING as AUTHOR_ADDR_NULL
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'streetAddressLine'),'@nullFlavor')::STRING as AUTHOR_ADDR_STREET_ADDRESS_NULL
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'streetAddressLine'):"$"::STRING as AUTHOR_ADDR_STREET_ADDRESS_1
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'streetAddressLine',1):"$"::STRING as AUTHOR_ADDR_STREET_ADDRESS_2
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'city'),'@nullFlavor')::STRING as AUTHOR_ADDR_CITY_NULL
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'city'):"$"::STRING as AUTHOR_ADDR_CITY
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'state'),'@nullFlavor')::STRING as AUTHOR_ADDR_STATE_NULL
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'state'):"$"::STRING as AUTHOR_ADDR_STATE
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'postalCode'),'@nullFlavor')::STRING as AUTHOR_ADDR_ZIP_CODE_NULL
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'postalCode'):"$"::STRING as AUTHOR_ADDR_ZIP_CODE
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'addr'),'country'),'@nullFlavor')::STRING as AUTHOR_ADDR_COUNTRY_NULL
	 ,GET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'telecom'),'@nullFlavor')::STRING as AUTHOR_TELECOM_NULL
     ,CONCAT(
	     NVL(XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING,''), ' ',
	     NVL(XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING,'')
         ) AS ASSIGNED_PERSON_NAME
	 ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'assignedAuthoringDevice'),'manufacturerModelName'):"$"::STRING  as AUTHORING_DEVICE_MODEL
	 ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'assignedAuthoringDevice'),'softwareName'):"$"::STRING  as AUTHORING_DEVICE_SOFTWARE
     ,XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'name'):"$"::STRING as REP_ORG_NAME     
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'telecom'),'@use')::STRING as REP_ORG_TELECOM_USE
     ,GET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'telecom'),'@value')::STRING as REP_ORG_TELEPHONE_NUMBER
     ,XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING as REP_ORG_STREET_ADDRESS_1
     ,XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'addr'),'streetAddressLine',1):"$"::STRING as REP_ORG_STREET_ADDRESS_2
     ,XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'addr'),'city'):"$"::STRING as REP_ORG_CITY
     ,XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'addr'),'state'):"$"::STRING as REP_ORG_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET( AUTHOR.VALUE, 'assignedAuthor'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING as REP_ORG_ZIP_CODE
     ,ROW_NUM AS XML_ROW_NUM
     ,TS_LAST_MODIFY
     ,SCAN_TIME
FROM &{idap_lake}.QUALITY.RAW_XML X 
    ,LATERAL FLATTEN( x.xml:"$") author
WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
  AND GET(author.VALUE, '@') = 'author'
  -- we are fetching distinct set of "AUTHOR" reocrds - should not need
  -- to apply filename filter logic.
  --  AND BASE_FILENAME IN (
  --      SELECT FILENAME FROM (
  --          SELECT PATIENT_MRN AS MRN, 
  --                 MAX( CS_TRANSACTION_ID ) || '.xml' AS FILENAME
  --           FROM &{idap_lake}.QUALITY.CCD_CONTROL
  --           GROUP BY PATIENT_MRN
  --           )          
  --      )
)
select
            -- FILENAME
      PATIENT_AUTHOR_HKEY
           -- ,M.FIRST_ID_ROOT
      ,TEMPLATE_OID_1
      ,TEMPLATE_OID_2
           -- ,AUTHOR_TIME
      ,PVID
      ,PVID_OID
      ,DOCTOR_FACILITY
      ,DOCTOR_FACILITY_OID
      ,NPI
      ,NPI_OID
      ,ASSIGN_AUTHOR_OID
      ,AUTHOR_ADDR_NULL
      ,AUTHOR_ADDR_STREET_ADDRESS_NULL
      ,AUTHOR_ADDR_STREET_ADDRESS_1
      ,AUTHOR_ADDR_STREET_ADDRESS_2
      ,AUTHOR_ADDR_CITY_NULL
      ,AUTHOR_ADDR_CITY
      ,AUTHOR_ADDR_STATE_NULL
      ,AUTHOR_ADDR_STATE
      ,AUTHOR_ADDR_ZIP_CODE_NULL
      ,AUTHOR_ADDR_ZIP_CODE
      ,AUTHOR_ADDR_COUNTRY_NULL
      ,AUTHOR_TELECOM_NULL
      ,ASSIGNED_PERSON_NAME
      ,AUTHORING_DEVICE_MODEL
      ,AUTHORING_DEVICE_SOFTWARE
      ,R_API_RESOURCE_ID
      ,R_API_RESOURCE_ID_OID
      ,R_NPI
      ,R_NPI_OID
      ,R_FEDERAL_TAX_ID
      ,R_FEDERAL_TAX_ID_OID
      ,REP_ORG_NAME
      ,REP_ORG_TELECOM_USE
      ,REP_ORG_TELEPHONE_NUMBER
      ,REP_ORG_STREET_ADDRESS_1
      ,REP_ORG_STREET_ADDRESS_2
      ,REP_ORG_CITY
      ,REP_ORG_STATE
      ,REP_ORG_ZIP_CODE
      ,XML_ROW_NUM
      ,TS_LAST_MODIFY
      ,SCAN_TIME
           --,RN
from 
     ( SELECT 
       IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [
               -- M.FILENAME,
               -- M.SECTION_TITLE,
               -- M.MRN,
               M.AUTHOR_ADDR_STREET_ADDRESS_1,
               M.AUTHOR_ADDR_CITY,
               M.AUTHOR_ADDR_STATE,
               M.AUTHOR_ADDR_ZIP_CODE,
               -- M.AUTHOR_TIME,
               I.PVID,
               I.DOCTOR_FACILITY,
               I.NPI,
               I.ASSIGN_AUTHOR_OID,
               --
               M.REP_ORG_NAME,
               M.REP_ORG_TELEPHONE_NUMBER,
               M.REP_ORG_STREET_ADDRESS_1,
               M.REP_ORG_CITY,
               M.REP_ORG_ZIP_CODE,
			   R.API_RESOURCE_ID,
               R.API_RESOURCE_ID_OID,
               R.NPI,
               R.NPI_OID
               ] ) AS PATIENT_AUTHOR_HKEY
          -- ,M.FIRST_ID_ROOT
      ,M.TEMPLATE_OID_1
      ,M.TEMPLATE_OID_2
          -- ,M.AUTHOR_TIME
      ,I.PVID
      ,I.PVID_OID
      ,I.DOCTOR_FACILITY
      ,I.DOCTOR_FACILITY_OID
      ,I.NPI
      ,I.NPI_OID
      ,I.ASSIGN_AUTHOR_OID
      ,M.AUTHOR_ADDR_NULL
      ,M.AUTHOR_ADDR_STREET_ADDRESS_NULL
      ,M.AUTHOR_ADDR_STREET_ADDRESS_1
      ,M.AUTHOR_ADDR_STREET_ADDRESS_2
      ,M.AUTHOR_ADDR_CITY_NULL
      ,M.AUTHOR_ADDR_CITY
      ,M.AUTHOR_ADDR_STATE_NULL
      ,M.AUTHOR_ADDR_STATE
      ,M.AUTHOR_ADDR_ZIP_CODE_NULL
      ,M.AUTHOR_ADDR_ZIP_CODE
      ,M.AUTHOR_ADDR_COUNTRY_NULL
      ,M.AUTHOR_TELECOM_NULL
      ,M.ASSIGNED_PERSON_NAME
      ,M.AUTHORING_DEVICE_MODEL
      ,M.AUTHORING_DEVICE_SOFTWARE
      ,R.API_RESOURCE_ID AS R_API_RESOURCE_ID
      ,R.API_RESOURCE_ID_OID AS R_API_RESOURCE_ID_OID
      ,R.NPI AS R_NPI
      ,R.NPI_OID AS R_NPI_OID
      ,R.FEDERAL_TAX_ID AS R_FEDERAL_TAX_ID
      ,R.FEDERAL_TAX_ID_OID AS R_FEDERAL_TAX_ID_OID
      ,M.REP_ORG_NAME
      ,M.REP_ORG_TELECOM_USE
      ,M.REP_ORG_TELEPHONE_NUMBER
      ,M.REP_ORG_STREET_ADDRESS_1
      ,M.REP_ORG_STREET_ADDRESS_2
      ,M.REP_ORG_CITY
      ,M.REP_ORG_STATE
      ,M.REP_ORG_ZIP_CODE
      ,M.XML_ROW_NUM
      ,M.TS_LAST_MODIFY
      ,M.SCAN_TIME
      ,ROW_NUMBER() OVER ( PARTITION BY
               M.AUTHOR_ADDR_STREET_ADDRESS_1,
               M.AUTHOR_ADDR_CITY,
               M.AUTHOR_ADDR_STATE,
               M.AUTHOR_ADDR_ZIP_CODE,
               -- M.AUTHOR_TIME,
               I.PVID,
               I.DOCTOR_FACILITY,
               I.NPI,
               I.ASSIGN_AUTHOR_OID,
               M.REP_ORG_NAME,
               M.REP_ORG_TELEPHONE_NUMBER,
               M.REP_ORG_STREET_ADDRESS_1,
               M.REP_ORG_CITY,
               M.REP_ORG_ZIP_CODE
            ORDER BY
               M.AUTHOR_ADDR_STREET_ADDRESS_1,
               M.AUTHOR_ADDR_CITY,
               M.AUTHOR_ADDR_STATE,
               M.AUTHOR_ADDR_ZIP_CODE,
               -- M.AUTHOR_TIME,
               I.PVID,
               I.DOCTOR_FACILITY,
               I.NPI,
               I.ASSIGN_AUTHOR_OID,
               M.REP_ORG_NAME,
               M.REP_ORG_TELEPHONE_NUMBER,
               M.REP_ORG_STREET_ADDRESS_1,
               M.REP_ORG_CITY,
               M.REP_ORG_ZIP_CODE) AS RN
    FROM MAIN M
    LEFT OUTER JOIN ASSIGNED_AUTHOR_ID I
      ON M.FILENAME = I.FILENAME 
     AND M.MRN = I.MRN 
     AND M.SECTION_TITLE = I.SECTION_TITLE
     AND M.FIRST_ID_ROOT = I.FIRST_ID_ROOT
    LEFT OUTER JOIN AA_REP_ORG_ID R
      ON M.FILENAME = R.FILENAME 
     AND M.MRN = R.MRN 
     AND M.SECTION_TITLE = R.SECTION_TITLE
     AND M.FIRST_ID_ROOT = R.FIRST_ID_ROOT
)
WHERE RN = 1;

!set variable_substitution=false;
