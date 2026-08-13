CREATE OR REPLACE VIEW QUALITY.CCD_ENCOUNTERS_ATHENA_PERFORMER_LINK_VW(
	FILENAME,
	SECTION_TITLE,
	MRN,
	ENCOUNTER_ID_EXTENSION,
	ENCOUNTER_HKEY,
	PERFORMER_HKEY,
	PVID,
	DOCTOR_FACILITY,
	NPI,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) AS
SELECT FILENAME
      ,SECTION_TITLE
      ,MRN
      ,ENCOUNTER_ID_EXTENSION
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [FILENAME, MRN, SECTION_TITLE, ENCOUNTER_ID_EXTENSION]) AS ENCOUNTER_HKEY
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
      ,PVID
      ,DOCTOR_FACILITY
      ,NPI
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
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by PVID' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS PVID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by PVID' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS PVID_OID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS DOCTOR_FACILITY
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = '1000-36286-8679 Providers by DoctorFacility' 
                    THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS DOCTOR_FACILITY_OID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS NPI
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS NPI_OID          
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'Federal Tax Identifier' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS FEDERAL_TAX_ID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'Federal Tax Identifier' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS FEDERAL_TAX_ID_OID         
          ,ROW_NUM AS XML_ROW_NUM
          ,TS_LAST_MODIFY
          ,SCAN_TIME
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
group by X.FILENAME
        ,X.SECTION_TITLE 
        ,X.MRN
        ,ENCOUNTER.VALUE
        ,PERFORMER.VALUE
        ,X.ROW_NUM
        ,X.TS_LAST_MODIFY
        ,X.SCAN_TIME
);
