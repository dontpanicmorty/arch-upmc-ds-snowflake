CREATE OR REPLACE VIEW QUALITY.CCD_ENCOUNTERS_ATHENA_PARTICIPANT_LINK_VW(
	FILENAME,
	SECTION_TITLE,
	MRN,
	ENCOUNTER_ID_EXTENSION,
	ENCOUNTER_HKEY,
	PARTICIPANT_HKEY,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) AS
SELECT FILENAME
      ,SECTION_TITLE
      ,MRN
      ,ENCOUNTER_ID_EXTENSION
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH ( [
           FILENAME
           ,MRN
           ,SECTION_TITLE
           ,ENCOUNTER_ID_EXTENSION 
       ]) AS ENCOUNTER_HKEY
      ,IDAP_AUXILIARY_DEV.UTIL.FXN_ARRAY_HASH( [
               FILENAME,
               SECTION_TITLE,
               MRN,
               PARTICIPANT_TYPE_CODE,
               PARTICIPANT_ROLE_CLASS_CODE,
               PARTICIPANT_TEMPLATE_ID_ROOT,
               PARTICIPANT_CODE_NULL,
               STREET_ADDRESS,
               STREET_ADDRESS_2,
               CITY,
               STATE,
               ZIPCODE,
               TELEPHONE_USE,
               TELEPHONE_NUMBER,
               PLAYING_ENTITY_CLASS_CODE,
               PLAYING_ENTITY_NAME
       ]) AS PARTICIPANT_HKEY
       ,XML_ROW_NUM
       ,TS_LAST_MODIFY
       ,SCAN_TIME
FROM ( SELECT
           X.FILENAME
          ,X.SECTION_TITLE
          ,X.MRN AS MRN
          ,GET(XMLGET(ENCOUNTER.VALUE,'id'),'@extension')::STRING AS ENCOUNTER_ID_EXTENSION
          ,GET(PARTICIPANT.VALUE,'@typeCode')::STRING AS PARTICIPANT_TYPE_CODE
          ,GET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'@classCode')::STRING AS PARTICIPANT_ROLE_CLASS_CODE
          ,GET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'templateId'),'@root')::STRING AS PARTICIPANT_TEMPLATE_ID_ROOT
          ,GET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'code'),'@nullFlavor')::STRING AS PARTICIPANT_CODE_NULL
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'addr'),'streetAddressLine'):"$"::STRING AS STREET_ADDRESS
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'addr'),'streetAddressLine',1):"$"::STRING AS STREET_ADDRESS_2
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'addr'),'city'):"$"::STRING AS CITY
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'addr'),'state'):"$"::STRING AS STATE
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'addr'),'postalCode'):"$"::STRING AS ZIPCODE
          ,GET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'telecom'),'@use')::STRING AS TELEPHONE_USE
          ,GET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'telecom'),'@value')::STRING AS TELEPHONE_NUMBER
          ,GET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'playingEntity'),'@classCode')::STRING AS PLAYING_ENTITY_CLASS_CODE
          ,XMLGET(XMLGET(XMLGET(PARTICIPANT.VALUE,'participantRole'),'playingEntity'),'name'):"$"::STRING AS PLAYING_ENTITY_NAME
          ,ROW_NUMBER() OVER ( PARTITION BY  FILENAME,
                                             SECTION_TITLE,
                                             MRN,
                                             PARTICIPANT_TYPE_CODE,
                                             PARTICIPANT_ROLE_CLASS_CODE,
                                             PARTICIPANT_TEMPLATE_ID_ROOT,
                                             PARTICIPANT_CODE_NULL,
                                             STREET_ADDRESS,
                                             STREET_ADDRESS_2,
                                             CITY,
                                             STATE,
                                             ZIPCODE,
                                             TELEPHONE_USE,
                                             TELEPHONE_NUMBER,
                                             PLAYING_ENTITY_CLASS_CODE,
                                             PLAYING_ENTITY_NAME
                               ORDER BY FILENAME, MRN, SECTION_TITLE ) AS ROW_NUMBER
          ,ROW_NUM AS XML_ROW_NUM
          ,TS_LAST_MODIFY
          ,SCAN_TIME
     FROM QUALITY.SECTION_XML X
         ,LATERAL FLATTEN(X.xml) SECTION     
         ,LATERAL FLATTEN(SECTION.VALUE:"$"::ARRAY) ENTRY
         ,LATERAL FLATTEN(entry.VALUE:"$"::ARRAY) ENCOUNTER
         ,LATERAL FLATTEN(encounter.VALUE:"$"::ARRAY) participant
     WHERE X.SECTION_TITLE = 'ENCOUNTERS'
           AND GET(SECTION.VALUE, '@') = 'section'
           AND GET(ENTRY.VALUE, '@') = 'entry'
           AND GET(encounter.VALUE, '@') = 'encounter'
           AND GET(participant.VALUE, '@') = 'participant'
);