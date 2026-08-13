CREATE OR REPLACE VIEW QUALITY.CCD_PAYERS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	SECTION_DATE,
	SECTION_CODE,
	SECTION_NAME,
	CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	ENTRY_CLASS_CODE,
	ENTRY_MOOD_CODE,
	TEMPLATE_DATE,
	ID_ROOT,
	ID_EXTENSION,
	CODE,
	CODE_DISPLAY_NAME,
	STATUS_CODE,
	ER_TYPE_CODE,
	ACT_CLASS_CODE,
	ACT_MOOD_CODE,
	ACT_TEMPLATE_ID_EXT,
	ACT_ID_ROOT,
	ACT_ID_EXT,
	ACT_CODE,
	ACT_DISPLAY_NAME,
	ACT_CODE_SYSTEM,
	ACT_CODE_SYSTEM_NAME,
	ACT_TRANSLACTION_NULL,
	ACT_STATUS_CODE,
	PERFORMER_TYPE_CODE,
	PERFORMER_ASSIGNED_ENTITY_CLASS,
	PERFORMER_ASSIGNED_ENTITY_ID_ROOT,
	PERFORMER_ASSIGNED_ENTITY_ID_EXT,
	PERFORMER_ASSIGNED_ENTITY_CODE,
	PERFORMER_ASSIGNED_ENTITY_NAME,
	PERFORMER_ASSIGNED_ENTITY_CODE_SYSTEM,
	PERFORMER_ASSIGNED_ENTITY_CODE_SYSTEM_NAME,
	REPRESENT_ORG_NAME,
	REPRESENT_ORG_PHONE_USE,
	REPRESENT_ORG_PHONE_NUM,
	REPRESENT_ORG_ADDRESS,
	REPRESENT_ORG_CITY,
	REPRESENT_ORG_STATE,
	REPRESENT_ORG_ZIPCODE,
	REPRESENT_ORG_COUNTRY,
	PARTICIPANT_TYPE_CODE,
	PARTICIPANT_TEMPLATE_ROOT,
	PARTICIPANT_TIME,
	PARTICIPANT_ROLE_CLASS,
	PARTICIPANT_ROLE_ID_ROOT,
	PARTICIPANT_ROLE_ID_EXT,
	PARTICIPANT_ROLE_CODE,
	PARTICIPANT_ROLE_NAME,
	PARTICIPANT_ROLE_CODE_SYSTEM,
	PARTICIPANT_ROLE_CODE_SYSTEM_NAME,
	PARTICIPANT_ROLE_STREET_ADDRESS,
	PARTICIPANT_ROLE_CITY,
	PARTICIPANT_ROLE_STATE,
	PARTICIPANT_ROLE_ZIPCODE,
	PARTICIPANT_NAME,
	PARTICIPANT_BIRTHDATE,
	ENTRY_RELATIONSHIP_TYPE_CODE,
	ENTRY_RELATIONSHIP_CLASS_CODE,
	ENTRY_RELATIONSHIP_MOOD_CODE,
	ENTRY_RELATIONSHIP_ID_ROOT,
	ENTRY_RELATIONSHIP_ID_EXT,
	XML_ROW_NUMBER,
	XML_TS_LAST_MODIFY,
	XML_TS_SCAN_TIME
) as 
SELECT X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS SECTION_DATE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME

      ,GET(F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
      ,GET(XMLGET( F.VALUE,'act'),'@classCode')::STRING AS ENTRY_CLASS_CODE
      ,GET(XMLGET( F.VALUE,'act'),'@moodCode')::STRING AS ENTRY_MOOD_CODE

      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'templateId'),'@extension')::STRING AS TEMPLATE_DATE
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'id'),'@root')::STRING AS ID_ROOT      
      ,NVL(GET(XMLGET(XMLGET( F.VALUE,'act'),'id'),'@extension')::STRING,'N/A') AS ID_EXTENSION

      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@code')::STRING AS CODE
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@displayName')::STRING AS CODE_DISPLAY_NAME

      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'statusCode'),'@code')::STRING AS STATUS_CODE
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'@typeCode')::STRING AS ER_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'@classCode')::STRING AS ACT_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'@moodCode')::STRING AS ACT_MOOD_CODE      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'templateId'),'@extension')::STRING AS ACT_TEMPLATE_ID_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'id'),'@root')::STRING AS ACT_ID_ROOT      
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'id'),'@extension')::STRING,'N/A') AS ACT_ID_EXT
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'code'),'@code')::STRING,'N/A') AS ACT_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'code'),'@displayName')::STRING AS ACT_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'code'),'@codeSystem')::STRING AS ACT_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'code'),'@codeSystemName')::STRING AS ACT_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'code'),'translation'),'@nullFlavor')::STRING AS ACT_TRANSLATION_NULL
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'statusCode'),'@code')::STRING AS ACT_STATUS_CODE      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'performer'),'@typeCode')::STRING AS PERFORMER_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'performer'),'assignedEntity'),'@classCode')::STRING AS PERFORMER_ASSIGNED_ENTITY_CLASS
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'id'),'@root')::STRING AS PERFORMER_ASSIGNED_ENTITY_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'id'),'@extension')::STRING AS PERFORMER_ASSIGNED_ENTITY_ID_EXT      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'code'),'@code')::STRING AS PERFORMER_ASSIGNED_ENTITY_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'code'),'@displayName')::STRING AS PERFORMER_ASSIGNED_ENTITY_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'code'),'@codeSystem')::STRING AS PERFORMER_ASSIGNED_ENTITY_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'code'),'@codeSystemName')::STRING AS PERFORMER_ASSIGNED_ENTITY_CODE_SYSTEM_NAME
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'name'):"$"::STRING AS REPRESENT_ORG_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'telecom'),'@use')::STRING AS REPRESENT_ORG_PHONE_USE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'telecom'),'@value')::STRING AS REPRESENT_ORG_PHONE_NUM
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS REPRESENT_ORG_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'addr'),'city'):"$"::STRING AS REPRESENT_ORG_CITY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'addr'),'state'):"$"::STRING AS REPRESENT_ORG_STATE                 
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS REPRESENT_ORG_ZIPCODE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'performer'),'assignedEntity'),'representedOrganization'),'addr'),'country'):"$"::STRING AS REPRESENT_ORG_COUNTRY
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'@typeCode')::STRING AS PARTICIPANT_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'templateId'),'@root')::STRING AS PARTICIPANT_TEMPLATE_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'time'),'low'),'@value')::STRING AS PARTICIPANT_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'@classCode')::STRING AS PARTICIPANT_ROLE_CLASS
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'id'),'@root')::STRING AS PARTICIPANT_ROLE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'id'),'@extension')::STRING AS PARTICIPANT_ROLE_ID_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'code'),'@code')::STRING AS PARTICIPANT_ROLE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'code'),'@displayName')::STRING AS PARTICIPANT_ROLE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'code'),'@codeSystem')::STRING AS PARTICIPANT_ROLE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'code'),'@codeSystemName')::STRING AS PARTICIPANT_ROLE_CODE_SYSTEM_NAME
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'addr'),'streetAddressLine'):"$"::STRING AS PARTICIPANT_ROLE_STREET_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'addr'),'city'):"$"::STRING AS PARTICIPANT_ROLE_CITY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'addr'),'state'):"$"::STRING AS PARTICIPANT_ROLE_STATE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'addr'),'postalCode'):"$"::STRING AS PARTICIPANT_ROLE_ZIPCODE
      -- ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
      --           'participant'),'participantRole'),'addr'),'country'):"$"::STRING AS PARTICIPANT_ROLE_COUNTRY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'playingEntity'),'name'):"$"::STRING AS PARTICIPANT_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                 'participant'),'participantRole'),'playingEntity'),'sdtc:birthTime'),'@value')::STRING AS PARTICIPANT_BIRTHDATE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),'entryRelationship'),'@typeCode')::STRING AS ENTRY_RELATIONSHIP_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                  'entryRelationship'),'act'),'@classCode')::STRING AS ENTRY_RELATIONSHIP_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                  'entryRelationship'),'act'),'@moodCode')::STRING AS ENTRY_RELATIONSHIP_MOOD_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                  'entryRelationship'),'act'),'id'),'@root')::STRING AS ENTRY_RELATIONSHIP_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'act'),
                  'entryRelationship'),'act'),'id'),'@extension')::STRING AS ENTRY_RELATIONSHIP_ID_EXT
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME 
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(X.XML, 'section'):"$") F    
WHERE SECTION_TITLE = 'Payers'
AND F.VALUE LIKE '%entry%';
