CREATE OR REPLACE VIEW QUALITY.CCD_ENCOUNTERS_ATHENA_PERFORMER_VW(
	FILENAME,
	SECTION_TITLE,
	MRN,
	PERFORMER_HKEY,
	ENCOUNTER_ID_EXTENSION,
	PERFORMER_TYPE_CODE,
	PVID,
	PVID_OID,
	DOCTOR_FACILITY,
	DOCTOR_FACILITY_OID,
	NPI,
	NPI_OID,
	FEDERAL_TAX_ID,
	FEDERAL_TAX_ID_OID,
	ADDRESS_NULL,
	STREET_ADDRESS_NULL,
	STREET_ADDRESS,
	STREET_ADDRESS_2,
	CITY_NULL,
	CITY,
	STATE_NULL,
	STATE,
	ZIPCODE_NULL,
	ZIPCODE,
	COUNTRY_NULL,
	TELEPHONE_USE_1,
	TELEPHONE_VALUE_1,
	TELEPHONE_USE_2,
	TELEPHONE_VALUE_2,
	ASSIGNED_PERSON,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) AS
SELECT FILENAME
      ,SECTION_TITLE
      ,MRN
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [FILENAME, 
                                                MRN, 
                                                SECTION_TITLE, 
                                                ENCOUNTER_ID_EXTENSION, 
                                                PVID,
                                                PVID_OID,
                                                DOCTOR_FACILITY,
                                                DOCTOR_FACILITY_OID,
                                                NPI,
                                                NPI_OID]
                                              ) AS PERFORMER_HKEY         
      ,ENCOUNTER_ID_EXTENSION
      ,PERFORMER_TYPE_CODE
      ,PVID
      ,PVID_OID
      ,DOCTOR_FACILITY
      ,DOCTOR_FACILITY_OID
      ,NPI
      ,NPI_OID
      ,FEDERAL_TAX_ID
      ,FEDERAL_TAX_ID_OID
      ,ADDRESS_NULL
      ,STREET_ADDRESS_NULL
      ,STREET_ADDRESS
      ,STREET_ADDRESS_2
      ,CITY_NULL
      ,CITY
      ,STATE_NULL
      ,STATE
      ,ZIPCODE_NULL
      ,ZIPCODE
      ,COUNTRY_NULL
      ,TELEPHONE_USE_1
      ,TELEPHONE_VALUE_1
      ,TELEPHONE_USE_2
      ,TELEPHONE_VALUE_2
      ,ASSIGNED_PERSON
      ,XML_ROW_NUM
	  ,TS_LAST_MODIFY
	  ,SCAN_TIME
FROM (
     SELECT
           X.FILENAME
          ,X.SECTION_TITLE
          ,X.MRN AS MRN
          ,GET(XMLGET(ENCOUNTER.VALUE,'id'),'@extension')::STRING AS ENCOUNTER_ID_EXTENSION
          ,GET(PERFORMER.VALUE,'@typeCode')::STRING AS PERFORMER_TYPE_CODE
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by PVID' 
                    THEN id.VALUE:"@extension"::VARCHAR ELSE NULL END) AS PVID
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by PVID' 
                    THEN id.VALUE:"@root"::VARCHAR ELSE NULL END) AS PVID_OID                    
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN id.VALUE:"@extension"::VARCHAR ELSE NULL END) AS DOCTOR_FACILITY
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN id.VALUE:"@root"::VARCHAR ELSE NULL END) AS DOCTOR_FACILITY_OID
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' 
                    THEN id.VALUE:"@extension"::VARCHAR ELSE NULL END) AS NPI
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' 
                    THEN id.VALUE:"@root"::VARCHAR ELSE NULL END) AS NPI_OID
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = 'Federal Tax Identifier' 
                    THEN id.VALUE:"@extension"::VARCHAR ELSE NULL END) AS FEDERAL_TAX_ID
          ,MAX(CASE WHEN id.VALUE:"@assigningAuthorityName"::VARCHAR = 'Federal Tax Identifier' 
                    THEN id.VALUE:"@root"::VARCHAR ELSE NULL END) AS FEDERAL_TAX_ID_OID
          ,GET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'@nullFlavor')::STRING AS ADDRESS_NULL          
          ,GET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'streetAddressLine'),'@nullFlavor')::STRING AS STREET_ADDRESS_NULL
          ,XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'streetAddressLine'):"$"::STRING AS STREET_ADDRESS
          ,XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'streetAddressLine',1):"$"::STRING AS STREET_ADDRESS_2
          ,GET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'city'),'@nullFlavor')::STRING AS CITY_NULL
          ,XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'city'):"$"::STRING AS CITY
          ,GET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'state'),'@nullFlavor')::STRING AS STATE_NULL
          ,XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'state'):"$"::STRING AS STATE
          ,GET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'postalCode'),'@nullFlavor')::STRING AS ZIPCODE_NULL
          ,XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'postalCode'):"$"::STRING AS ZIPCODE
          ,GET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'addr'),'country'),'@nullFlavor')::STRING AS COUNTRY_NULL
          ,GET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'telecom'),'@use')::STRING AS TELEPHONE_USE_1
          ,GET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'telecom'),'@value')::STRING AS TELEPHONE_VALUE_1
          ,GET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'telecom',1),'@use')::STRING AS TELEPHONE_USE_2
          ,GET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'telecom',1),'@value')::STRING AS TELEPHONE_VALUE_2
          ,CONCAT(
               NVL(XMLGET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::STRING,''), ' ' ,
               NVL(XMLGET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::STRING,''), ' ',  
               NVL(XMLGET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ', 
               NVL(XMLGET(XMLGET(XMLGET(XMLGET(PERFORMER.VALUE,'assignedEntity'),'assignedPerson'),'name'),'suffix'):"$"::STRING,'') 
          ) AS ASSIGNED_PERSON,
          ROW_NUM AS XML_ROW_NUM,
	      TS_LAST_MODIFY,
	      SCAN_TIME
     FROM QUALITY.SECTION_XML X
         ,LATERAL FLATTEN(X.xml) SECTION     
         ,LATERAL FLATTEN(SECTION.VALUE:"$"::ARRAY) ENTRY
         ,LATERAL FLATTEN(entry.VALUE:"$"::ARRAY) ENCOUNTER
         ,LATERAL FLATTEN(encounter.VALUE:"$"::ARRAY) PERFORMER
         ,LATERAL FLATTEN(performer.VALUE:"$"::ARRAY) assigned_entity
         ,LATERAL FLATTEN(assigned_entity.VALUE:"$"::ARRAY) id
     WHERE X.SECTION_TITLE = 'ENCOUNTERS'
           AND GET(SECTION.VALUE, '@') = 'section'
           AND GET(ENTRY.VALUE, '@') = 'entry'
           AND GET(encounter.VALUE, '@') = 'encounter'
           AND GET(PERFORMER.VALUE, '@') = 'performer'
           AND GET(assigned_entity.VALUE, '@') = 'assignedEntity'
           AND GET(id.VALUE, '@') = 'id'           
        -- AND FILENAME = '25126358.xml'
GROUP BY X.FILENAME
        ,X.SECTION_TITLE 
        ,X.MRN
        ,ENCOUNTER.VALUE
        ,PERFORMER.VALUE
        ,XML_ROW_NUM
        ,TS_LAST_MODIFY
        ,SCAN_TIME
);
