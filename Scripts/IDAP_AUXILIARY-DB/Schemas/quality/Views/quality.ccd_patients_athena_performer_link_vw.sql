!set variable_substitution=true;

create or replace view QUALITY.CCD_PATIENTS_ATHENA_PERFORMER_LINK_VW(
	FILENAME,
	SECTION_TITLE,
	MRN,
	PATIENT_ATHENA_HKEY,
	PATIENT_PERFORMER_HKEY,
	PVID,
	DOCTOR_FACILITY,
	NPI,
	FEDERAL_TAX_ID,
	PERFORMER_NAME,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as
WITH 
PERF_IDS AS (
SELECT
      FILENAME
     ,SECTION_TITLE
     ,MRN
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by PVID' 
                    THEN ID_EXT ELSE NULL END) AS PVID
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by PVID' 
                    THEN ID_ROOT ELSE NULL END) AS PVID_OID
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID_EXT ELSE NULL END) AS DOCTOR_FACILITY
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID_ROOT ELSE NULL END) AS DOCTOR_FACILITY_OID                                        
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN ID_EXT ELSE NULL END) AS NPI
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'US National Provider Identifiers' 
                    THEN ID_ROOT ELSE NULL END) AS NPI_OID
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'Federal Tax Identifier'
                    THEN ID_EXT ELSE NULL END) AS FEDERAL_TAX_ID  
     ,MAX(CASE WHEN ID_AUTHORITY_NAME = 'Federal Tax Identifier'
                    THEN ID_ROOT ELSE NULL END) AS FEDERAL_TAX_ID_OID  
FROM (
      SELECT 
          BASE_FILENAME AS FILENAME
         ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
         ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
         ,GET( ID.VALUE, '@assigningAuthorityName')::STRING as ID_AUTHORITY_NAME
         ,GET( ID.VALUE, '@extension')::STRING as ID_EXT
         ,GET( ID.VALUE, '@root')::STRING as ID_ROOT
      FROM &{idap_lake}.QUALITY.RAW_XML X
          ,LATERAL FLATTEN( x.xml:"$") document_of
          ,LATERAL FLATTEN( document_of.value:"$") service_event
          ,LATERAL FLATTEN( SERVICE_EVENT.THIS:"$") PERFORMER
          ,LATERAL FLATTEN( PERFORMER.VALUE:"$") ASSIGNED_ENTITY
          ,LATERAL FLATTEN( ASSIGNED_ENTITY.VALUE:"$") ID
      WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
        AND GET( document_of.VALUE, '@') = 'documentationOf'
        AND service_event.VALUE = 'serviceEvent'
        AND GET( PERFORMER.VALUE, '@') = 'performer'
        AND GET( ASSIGNED_ENTITY.VALUE, '@') = 'assignedEntity'
        AND GET( ID.VALUE, '@') = 'id'
)
GROUP BY
      FILENAME,
      SECTION_TITLE,
      MRN
),
MAIN AS (
    SELECT 
      BASE_FILENAME AS FILENAME
     ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
     ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
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
     ,GET( PERFORMER.VALUE, '@typeCode')::STRING as PERFORMER_TYPE_CODE
     -- per conversation with Architecures, removing this column - can be readded if deemed necessary
     -- ,GET(XMLGET( PERFORMER.VALUE, 'time'),'@value')::STRING as PERFORMER_TIME
     -- <address>
     ,XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'addr'),'streetAddressLine'):"$"::STRING as ADDRESS_LINE_1
     ,XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'addr'),'streetAddressLine',1):"$"::STRING as ADDRESS_LINE_2
     ,XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'addr'),'city'):"$"::STRING as CITY
     ,XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'addr'),'state'):"$"::STRING as STATE
     ,XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'addr'),'postalCode'):"$"::STRING as ZIP_CODE
     ,GET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'telecom'),'@use')::STRING as TELECOM_USE_1
     ,GET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'telecom'),'@value')::STRING as TELEPHONE_NUM_1
     ,GET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'telecom',1),'@use')::STRING as TELECOM_USE_2
     ,GET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'telecom',1),'@value')::STRING as TELEPHONE_NUM_2
     ,CONCAT( 
          NVL( XMLGET(XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::STRING,''),  ', ',
          NVL(XMLGET(XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::STRING,''), ' ',
          NVL(XMLGET(XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ', 
          NVL(XMLGET(XMLGET(XMLGET(XMLGET( PERFORMER.VALUE, 'assignedEntity'),'assignedPerson'),'name'),'suffix'):"$"::STRING,'' )
     ) AS PERFORMER_NAME
     ,ROW_NUM AS XML_ROW_NUM
     ,TS_LAST_MODIFY
     ,SCAN_TIME
FROM &{idap_lake}.QUALITY.RAW_XML X     
    ,LATERAL FLATTEN( x.xml:"$") document_of
    ,LATERAL FLATTEN( document_of.value:"$") service_event
    ,LATERAL FLATTEN( SERVICE_EVENT.THIS:"$") PERFORMER
WHERE SECTION_TITLE LIKE 'CONTINUITY OF CARE DOCUMENT%'
  AND GET( document_of.VALUE, '@') = 'documentationOf'
  AND service_event.VALUE = 'serviceEvent'
  AND GET( PERFORMER.VALUE, '@') = 'performer'
  AND BASE_FILENAME IN (
      SELECT FILENAME FROM (
          SELECT PATIENT_MRN AS MRN, 
                 MAX( CS_TRANSACTION_ID ) || '.xml' AS FILENAME
           FROM &{idap_lake}.QUALITY.CCD_CONTROL
           GROUP BY PATIENT_MRN
           )          
      )
)
SELECT FILENAME
      ,SECTION_TITLE
      ,MRN
      ,PATIENT_ATHENA_HKEY
      ,PATIENT_PERFORMER_HKEY
      ,PVID
      ,DOCTOR_FACILITY
      ,NPI
      ,FEDERAL_TAX_ID
      ,PERFORMER_NAME
      ,XML_ROW_NUM
      ,TS_LAST_MODIFY
      ,SCAN_TIME
FROM (
    SELECT 
       M.FILENAME
      ,M.SECTION_TITLE
      ,M.MRN
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [ M.FILENAME, 
                                                 M.MRN, 
                                                 M.SECTION_TITLE,
                                                 M.ID_EXTENSION,
                                                 M.PATIENT_NAME_1,
                                                 M.PATIENT_NAME_2
                                                ] ) AS PATIENT_ATHENA_HKEY      
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [
                                                M.SECTION_TITLE, 
                                                I.PVID,
                                                I.DOCTOR_FACILITY,
                                                I.NPI,
                                                M.TELEPHONE_NUM_1,
                                                M.TELEPHONE_NUM_2,
                                                M.PERFORMER_NAME,
                                                M.ADDRESS_LINE_1,
                                                M.ADDRESS_LINE_2,
                                                M.CITY,
                                                M.STATE,
                                                M.ZIP_CODE
                                                -- M.PERFORMER_TIME
                                                ] ) AS PATIENT_PERFORMER_HKEY
      ,I.PVID
      ,I.DOCTOR_FACILITY
      ,I.NPI
      ,I.FEDERAL_TAX_ID
      ,M.PERFORMER_NAME
      ,M.XML_ROW_NUM
      ,M.TS_LAST_MODIFY
      ,M.SCAN_TIME
    FROM MAIN M
    LEFT OUTER JOIN PERF_IDS I
         ON M.FILENAME = I.FILENAME
        AND M.SECTION_TITLE = I.SECTION_TITLE
        AND M.MRN = I.MRN
);

!set variable_substitution=false;
