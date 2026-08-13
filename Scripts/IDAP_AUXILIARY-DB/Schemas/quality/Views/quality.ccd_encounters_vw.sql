CREATE OR REPLACE VIEW QUALITY.CCD_ENCOUNTERS_VW(
	SECTION_TITLE,
	TEMPLATE_ID_EXT,
	TEMPLATE_ID_ROOT,
	TEMPLATE_ID_ROOT_2,
	ENCOUNTER_CODE,
	ENCOUNTER_CODE_SYSTEM,
	ENCOUNTER_CODE_SYSTEM_NAME,
	ENCOUNTER_CODE_DISPLAY_NAME,
	ENCOUNTER_REFERENCE_VALUE,
	ENCOUNTER_DATE,
	RENDERING_NPI,
	RENDERING_NAME,
	FILENAME,
	MRN,
	SECTION_DISPLAY_NAME,
	ENTRY_TYPE_CODE,
	ENCOUNTER_CLASS_CODE,
	ENCOUNTER_MOOD_CODE,
	ENCOUNTER_ID_ROOT,
	ENCOUNTER_ID_EXT,
	ENTRY_CODE,
	ENTRY_ENCOUNTER_NAME,
	ENTRY_ENCOUNTER_CODE_SYSTEM,
	ENTRY_CODE_SYSTEM_NAME,
	PERFORMER_TYPE_CODE,
	ENTITY_CLASS_CODE,
	ENTITY_ID_ROOT,
	ENTITY_ID_EXT,
	ENTITY_ADDR_NULL_FLAVOR,
	ENTITY_TELECOM_USE,
	ENTITY_TELEPHONE_NUM,
	DETERMINER_CODE,
	ASSIGN_PERSON_CLASS_CODE,
	REP_ORGANIZATION_ID_ROOT,
	REP_ORGANIZATION_ID_EXT,
	REP_ORGANIZATION_NAME,
	REP_ORGANIZATION_TELECOM_USE,
	REP_ORGANIZATION_TELEPHONE_NUM,
	REP_ORGANIZATION_ADDR_USE,
	REP_ORGANIZATION_STREET_ADDRESS,
	REP_ORGANIZATION_CITY,
	REP_ORGANIZATION_STATE,
	REP_ORGANIZATION_ZIP,
	REP_ORGANIZATION_COUNTRY,
	PARTICIPANT_TYPE_CODE,
	PARTICIPANT_ROLE_CODE_CLASS_CODE,
	PARTICIPANT_TEMPLATE_ID_ROOT,
	PARTICIPANT_ROLE_CODE,
	PARTICIPANT_ROLE_NAME,
	PARTICIPANT_ROLE_CODE_SYSTEM,
	PARTICIPANT_ROLE_CODE_SYSTEM_NAME,
	PARTICIPANT_ROLE_ADDR_USE,
	PARTICIPANT_ROLE_STREET_ADDRESS,
	PARTICIPANT_ROLE_STREET_ADDRESS_2,
	PARTICIPANT_ROLE_CITY,
	PARTICIPANT_ROLE_STATE,
	PARTICIPANT_ROLE_ZIPCODE,
	PARTICIPANT_ROLE_COUNTRY,
	PARTICIPANT_TELEPHONE_USE,
	PARTICIPANT_TELEPHONE_NUMBER,
	PARTICIPANT_FAX_USE,
	PARTICIPANT_FAX_NUMBER,
	PLAY_ENTITY_CLASS_CODE,
	PLAY_ENTITY_NAME,
	ER_TYPE_CODE,
	ER_CLASS_CODE,
	ER_MOOD_CODE,
	ACT_TEMPLATE_ID_ROOT,
	ACT_TEMPLATE_ID_EXTENSION,
	ACT_TEMPLATE_ID_ROOT_2,
	ER_CODE,
	ER_NAME,
	ER_CODE_SYSTEM,
	ER_CODE_SYSTEM_NAME,
	ER_LEVEL2_TYPE_CODE,
	ER_OBS_CLASS_CODE,
	ER_OBS_MOOD_CODE,
	ER_OBS_TEMPL_ID_EXTENSION,
	ER_OBS_TEMPL_ID_ROOT,
	ER_OBS_TEMPL_ID_ROOT_2, 
	ER_OBS_ID_ROOT,
	ENCOUNTER_L2_CODE,
	ENCOUNTER_L2_NAME,
	ENCOUNTER_L2_CODE_SYSTEM,
	ENCOUNTER_L2_CODE_SYSTEM_NAME,
	ENCOUNTER_TRANSLATE_CODE,
	ENCOUNTER_L2_XLATE_NAME,
	ENCOUNTER_L2_XLATE_CODE_SYSTEM,
	ENCOUNTER_L2_XLATE_CODE_SYSTEM_NAME,
	ENCOUNTER_L2_STATUS_CODE,
	ENCOUNTER_L2_EFF_TIME,
	ENCOUNTER_L2_VALUE,
	ENCOUNTER_L2_NULL_FLAVOR,
	ENCOUNTER_L2_XLATION_TYPE,
	ENCOUNTER_TRANSLATION_CODE_VALUE,
	ENCOUNTER_L2_TRANSLATION_NAME,
	ENCOUNTER_L2_TRANSLATION_CODE_SYSTEM,
	ENCOUNTER_L2_TRANSLATION_CODE_SYSTEM_NAME,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME
) as
SELECT SECTION_TITLE AS SECTION_TITLE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS TEMPLATE_ID_EXT
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING AS TEMPLATE_ID_ROOT_2      
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS ENCOUNTER_CODE       
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS ENCOUNTER_CODE_SYSTEM                  
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS ENCOUNTER_CODE_SYSTEM_NAME                
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'@displayName')::STRING AS ENCOUNTER_CODE_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'originalText'),'reference'),'@value')::STRING AS ENCOUNTER_REFERENCE_VALUE
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'effectiveTime'),'@value')::STRING AS ENCOUNTER_DATE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'id'),'@extension')::STRING AS RENDERING_NPI
      ,CONCAT (
              XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::string, ', ',      
              XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::string, ' ',
              XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'name'),'suffix'):"$"::string, ' '
              -- GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'name'), 'suffix'),'@qualifier')::STRING
              ) AS RENDERING_NAME      
      ,filename
      ,mrn	  
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_DISPLAY_NAME
      ,GET(F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
      ,GET(XMLGET(F.VALUE,'encounter'),'@classCode')::STRING AS ENCOUNTER_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'encounter'),'@moodCode')::STRING AS ENCOUNTER_MOOD_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'id'),'@root')::STRING AS ENCOUNTER_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'id'),'@extension')::STRING AS ENCOUNTER_ID_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'@code')::STRING AS ENTRY_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'@displayName')::STRING AS ENCOUNTER_CODE_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'@codeSystem')::STRING AS ENTRY_ENCOUNER_CODE_SYSTEM2
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'code'),'@codeSystemName')::STRING AS ENCOUNTER_CODE_SYSTEM_NAME2
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'@typeCode')::STRING AS PERFORMER_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'@classCode')::STRING AS ENTITY_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'id'),'@extension')::STRING AS ENTITY_ID_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'id'),'@root')::STRING AS ENTITY_ID_ROOT      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'addr'),'@nullFlavor')::STRING AS ENTITY_ADDR_NULL_FLAVOR
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'telecom'),'@use')::STRING AS ENTITY_TELECOM_USE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'telecom'),'@value')::STRING AS ENTITY_TELEPHONE_NUM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'@determinerCode')::STRING AS DETERMINER_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'assignedPerson'),'@classCode')::STRING AS ASSIGN_PERSON_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'id'),'@root')::STRING AS REP_ORGANIZATION_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'id'),'@extension')::STRING AS REP_ORGANIZATION_ID_EXT
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'name'):"$"::STRING AS REP_ORGANIZATION_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'telecom'),'@use')::STRING AS REP_ORGANIZATION_TELECOM_USE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'telecom'),'@value')::STRING AS REP_ORGANIZATION_TELEPHONE_NUM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'@use')::STRING AS REP_ORGANIZATION_ADDR_USE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS REP_ORGANIZATION_STREET_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'city'):"$"::STRING AS REP_ORGANIZATION_CITY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'state'):"$"::STRING AS REP_ORGANIZATION_STATE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS REP_ORGANIZATION_ZIP
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'performer'),'assignedEntity'),'representedOrganization'),'addr'),'country'):"$"::STRING AS REP_ORGANIZATION_COUNTRY
      ,GET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'@typeCode')::STRING AS PART_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'@classCode')::STRING AS PART_ROLE_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'templateId'),'@root')::STRING AS PARTICIPANT_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'code'),'@code')::STRING AS PART_ROLE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'code'),'@displayName')::STRING AS PART_ROLE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'code'),'@codeSystem')::STRING AS PART_ROLE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'code'),'@codeSystemName')::STRING AS PART_ROLE_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'@use')::STRING AS PART_ROLE_ADDR_USE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'streetAddressLine'):"$"::STRING AS PART_ROLE_STREET_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'streetAddressLine',1):"$"::STRING AS PART_ROLE_STREET_ADDRESS_2
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'city'):"$"::STRING AS PART_ROLE_CITY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'state'):"$"::STRING AS PART_ROLE_STATE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'postalCode'):"$"::STRING AS PART_ROLE_ZIPCODE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'addr'),'country'):"$"::STRING AS PART_ROLE_COUNTRY
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'telecom'),'@use')::STRING AS PART_PHONE_USE_1
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'telecom'),'@value')::STRING AS PART_TELEPHONE_NUM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'telecom',1),'@use')::STRING AS PART_PHONE_USE_2
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'telecom',1),'@value')::STRING AS PART_FAX_NUM      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'playingEntity'),'@classCode')::STRING AS PLAY_ENTITY_CLASS_CODE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'encounter'),'participant'),'participantRole'),'playingEntity'),'name'):"$"::STRING AS PLAY_ENTITY_NAME
      ,GET(SA.VALUE, '@typeCode')::STRING AS ER_TYPE_CODE
      ,GET(XMLGET(SA.VALUE, 'act'),'@classCode')::STRING AS ER_CLASS_CODE
      ,GET(XMLGET(SA.VALUE,'act'),'@moodCode')::STRING AS ER_MOOD_CODE
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'templateId'),'@extension')::STRING AS ACT_TEMPLATE_ID_EXTENSION
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'templateId'),'@root')::STRING AS ACT_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'templateId',1),'@root')::STRING AS ACT_TEMPLATE_ID_ROOT_2  
      
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'code'),'@code')::STRING AS ER_CODE
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'code'),'@displayName')::STRING AS ER_NAME
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'code'),'@codeSystem')::STRING AS ER_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'code'),'@codeSystemName')::STRING AS ER_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'@typeCode')::STRING AS ER_LEVEL2_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'@classCode')::STRING AS ER_OBS_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'@moodCode')::STRING AS ER_OBS_MOOD_CODE      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),'@extension')::STRING AS ER_OBS_TEMPL_ID_EXTENSION
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),'@root')::STRING AS ER_OBS_TEMPL_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'templateId',1),'@root')::STRING AS ER_OBS_TEMPL_ID_ROOT_2
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'id'),'@root')::STRING AS ER_OBS_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@code')::STRING AS ENCOUNTER_L2_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@displayName')::STRING AS ENCOUNTER_L2_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@codeSystem')::STRING AS ENCOUNTER_L2_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@codeSystemName')::STRING AS ENCOUNTER_L2_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@code')::STRING AS ENCOUNTER_TRANSLATE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@displayName')::STRING AS ENCOUNTERR_L2_XLATE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@codeSystem')::STRING AS ENCOUNTER_L2_XLATE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@codeSystemName')::STRING AS ENCOUNTER_L2_XLATE_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'statusCode'),'@code')::STRING AS ENCOUNTER_L2_STATUS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'effectiveTime'),'low'),'@value')::STRING AS ENCOUNTER_L2_EFF_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@xsi:type')::STRING AS ENCOUNTER_L2_VALUE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@nullFlavor')::STRING AS ENCOUNTER_L2_NULL_FLAVOR
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@xsi:type')::STRING AS ENCOUNTER_L2_XLATION_TYPE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@code')::STRING AS ENCOUNTER_TRANSLATION_CODE_VALUE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@displayName')::STRING AS ENCOUNTER_L2_XLATION_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@codeSystem')::STRING AS ENCOUNTER_L2_XLATION_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@codeSystemName')::STRING AS ENCOUNTER_L2_XLATION_CODE_SYSTEM_NAME
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME
FROM QUALITY.SECTION_XML X 
     ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
     ,LATERAL FLATTEN(XMLGET(F.VALUE, 'encounter'):"$") SA
WHERE SECTION_TITLE = 'Encounters'
AND F.VALUE LIKE  '%entry%'
AND SA.VALUE LIKE  '%entryRelationship%';
