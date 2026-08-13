CREATE OR REPLACE VIEW QUALITY.CCD_ENCOUNTERS_ATHENA_PARTICIPANT_VW(
	FILENAME,
	SECTION_TITLE,
	MRN,
	PARTICIPANT_HKEY,
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
	PLAYING_ENTITY_NAME,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) AS
SELECT FILENAME
      ,SECTION_TITLE
      ,MRN
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
      ,PARTICIPANT_TYPE_CODE
      ,PARTICIPANT_ROLE_CLASS_CODE
      ,PARTICIPANT_TEMPLATE_ID_ROOT
      ,PARTICIPANT_CODE_NULL
      ,STREET_ADDRESS
      ,STREET_ADDRESS_2
      ,CITY
      ,STATE
      ,ZIPCODE
      ,TELEPHONE_USE
      ,TELEPHONE_NUMBER
      ,PLAYING_ENTITY_CLASS_CODE
      ,PLAYING_ENTITY_NAME
      ,XML_ROW_NUM
      ,TS_LAST_MODIFY
      ,SCAN_TIME
FROM ( SELECT
           X.FILENAME
          ,X.SECTION_TITLE
          ,X.MRN AS MRN
          ,GET(participant.VALUE,'@typeCode')::STRING AS PARTICIPANT_TYPE_CODE
          ,GET(xmlget(participant.VALUE,'participantRole'),'@classCode')::STRING AS PARTICIPANT_ROLE_CLASS_CODE
          ,GET(xmlget(xmlget(participant.VALUE,'participantRole'),'templateId'),'@root')::STRING AS PARTICIPANT_TEMPLATE_ID_ROOT
          ,GET(xmlget(xmlget(participant.VALUE,'participantRole'),'code'),'@nullFlavor')::STRING AS PARTICIPANT_CODE_NULL
          ,xmlGET(xmlget(xmlget(participant.VALUE,'participantRole'),'addr'),'streetAddressLine'):"$"::STRING AS STREET_ADDRESS
          ,xmlGET(xmlget(xmlget(participant.VALUE,'participantRole'),'addr'),'streetAddressLine',1):"$"::STRING AS STREET_ADDRESS_2          
          ,xmlGET(xmlget(xmlget(participant.VALUE,'participantRole'),'addr'),'city'):"$"::STRING AS CITY
          ,xmlGET(xmlget(xmlget(participant.VALUE,'participantRole'),'addr'),'state'):"$"::STRING AS STATE
          ,xmlGET(xmlget(xmlget(participant.VALUE,'participantRole'),'addr'),'postalCode'):"$"::STRING AS ZIPCODE
          ,GET(xmlget(xmlget(participant.VALUE,'participantRole'),'telecom'),'@use')::STRING AS TELEPHONE_USE
          ,GET(xmlget(xmlget(participant.VALUE,'participantRole'),'telecom'),'@value')::STRING AS TELEPHONE_NUMBER
          ,GET(xmlget(xmlget(participant.VALUE,'participantRole'),'playingEntity'),'@classCode')::STRING AS PLAYING_ENTITY_CLASS_CODE
          ,XMLGET(xmlget(xmlget(participant.VALUE,'participantRole'),'playingEntity'),'name'):"$"::STRING AS PLAYING_ENTITY_NAME
          ,ROW_NUM AS XML_ROW_NUM
          ,TS_LAST_MODIFY
          ,SCAN_TIME
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
           --and filename = '25126358.xml'
       )
WHERE ROW_NUMBER = 1;
