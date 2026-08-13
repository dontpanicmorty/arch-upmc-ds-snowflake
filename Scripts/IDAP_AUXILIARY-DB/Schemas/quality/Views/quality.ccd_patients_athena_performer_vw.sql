!set variable_substitution=true;

create or replace view QUALITY.CCD_PATIENTS_ATHENA_PERFORMER_VW(
	SECTION_TITLE,
	PATIENT_PERFORMER_HKEY,
	PERFORMER_TYPE_CODE,
	PVID,
	PVID_OID,
	DOCTOR_FACILITY,
	DOCTOR_FACILITY_OID,
	NPI,
	NPI_OID,
	FEDERAL_TAX_ID,
	FEDERAL_TAX_ID_OID,
	ADDRESS_LINE_1,
	ADDRESS_LINE_2,
	CITY,
	STATE,
	ZIP_CODE,
	TELECOM_USE_1,
	TELEPHONE_NUM_1,
	TELECOM_USE_2,
	TELEPHONE_NUM_2,
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
     -- ,GET(XMLGET( DOCUMENT_OF.VALUE, 'serviceEvent'),'@classCode')::STRING as SERVICE_EVENT_CLASS_CODE
     ,GET( PERFORMER.VALUE, '@typeCode')::STRING as PERFORMER_TYPE_CODE
     --
     -- per conversation with Architecture, removing this field - can be readded if deemed necessary
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
)
SELECT
       SECTION_TITLE
      ,PATIENT_PERFORMER_HKEY
      ,PERFORMER_TYPE_CODE
      --,PERFORMER_TIME
      ,PVID
      ,PVID_OID
      ,DOCTOR_FACILITY
      ,DOCTOR_FACILITY_OID
      ,NPI
      ,NPI_OID
      ,FEDERAL_TAX_ID
      ,FEDERAL_TAX_ID_OID
      ,ADDRESS_LINE_1
      ,ADDRESS_LINE_2
      ,CITY
      ,STATE
      ,ZIP_CODE
      ,TELECOM_USE_1
      ,TELEPHONE_NUM_1
      ,TELECOM_USE_2
      ,TELEPHONE_NUM_2
      ,PERFORMER_NAME
      ,XML_ROW_NUM
      ,TS_LAST_MODIFY
      ,SCAN_TIME
FROM (
    SELECT 
     --  M.FILENAME
       M.SECTION_TITLE
     -- ,M.MRN
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [--M.FILENAME, 
                                                --M.MRN, 
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
      ,M.PERFORMER_TYPE_CODE
      -- ,M.PERFORMER_TIME
      ,I.PVID
      ,I.PVID_OID
      ,I.DOCTOR_FACILITY
      ,I.DOCTOR_FACILITY_OID
      ,I.NPI
      ,I.NPI_OID
      ,I.FEDERAL_TAX_ID
      ,I.FEDERAL_TAX_ID_OID
      ,M.ADDRESS_LINE_1
      ,M.ADDRESS_LINE_2
      ,M.CITY
      ,M.STATE
      ,M.ZIP_CODE
      ,M.TELECOM_USE_1
      ,M.TELEPHONE_NUM_1
      ,M.TELECOM_USE_2
      ,M.TELEPHONE_NUM_2
      ,M.PERFORMER_NAME
      ,M.XML_ROW_NUM
      ,M.TS_LAST_MODIFY
      ,M.SCAN_TIME
      ,ROW_NUMBER() OVER ( PARTITION BY -- M.FILENAME,
                                        M.SECTION_TITLE,                                         
                                        -- M.MRN,
                                        M.PERFORMER_NAME,
                                        I.PVID,
                                        I.DOCTOR_FACILITY,
                                        I.NPI,
                                        M.TELEPHONE_NUM_1,
                                        M.TELEPHONE_NUM_2,
                                        M.ADDRESS_LINE_1,
                                        M.ADDRESS_LINE_2,
                                        M.CITY,
                                        M.STATE,
                                        M.ZIP_CODE
                                        -- M.PERFORMER_TIME
                               ORDER BY -- M.FILENAME, 
                                        -- M.MRN, 
                                        M.PERFORMER_NAME, I.PVID, I.DOCTOR_FACILITY, I.NPI ) AS ROW_NUMBER
    FROM MAIN M
    LEFT OUTER JOIN PERF_IDS I
         ON M.FILENAME = I.FILENAME
        AND M.SECTION_TITLE = I.SECTION_TITLE
        AND M.MRN = I.MRN
) 
WHERE ROW_NUMBER = 1;

!set variable_substitution=false;
