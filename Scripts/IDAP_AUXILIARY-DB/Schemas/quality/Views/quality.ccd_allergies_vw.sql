CREATE OR REPLACE VIEW QUALITY.CCD_ALLERGIES_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	TEMPLATE_ID_ROOT,
	TEMPLATE_ID_EXT,
	ENTRY_TYPE_CODE,
	ACT_CLASS_CODE,
	ACT_MOOD_CODE,
	ACT_ID_ROOT,
	ACT_ID_EXT,
	ACT_CODE,
	ACT_CODE_NAME,
	ACT_CODE_SYSTEM,
	ACT_CODE_SYSTEM_NAME,
	ACT_STATUS_CODE,
	EFFECTIVE_TIME_LOW,
	EFFECTIVE_TIME_HIGH,
	AUTHOR_TEMPLATE_ID_ROOT,
	AUTHOR_TIME,
	ASSIGNED_AUTHOR_ID_ROOT,
	ASSIGNED_AUTHOR_ID_EXT,
	ASSIGNED_AUTHOR_CODE,
	ASSIGNED_AUTHOR_CODE_NAME,
	ASSIGNED_AUTHOR_CODE_SYSTEM,
	ASSIGNED_AUTHOR_CODE_SYSTEM_NAME,
	ASSIGNED_PERSON,
	ENTRY_RELSHIP_TYPE_CODE,
	ENTRY_RELSHIP_OBS_CLASS_CODE,
	ENTRY_RELSHIP_OBS_MOOD_CODE,
	ENTRY_RELSHIP_TEMPLATE_ID_ROOT,
	ENTRY_RELSHIP_TEMPLATE_ID_EXT,
	ENTRY_RELSHIP_OBS_ID_ROOT,
	ENTRY_RELSHIP_OBS_ID_EXT,
	ENTRY_RELSHIP_OBS_CODE,
	ENTRY_RELSHIP_OBS_CODE_SYSTEM,
	ENTRY_RELSHIP_OBS_STATUS_CODE,
	ENTRY_RELSHIP_OBS_EFF_TIME_LOW,
	ENTRY_RELSHIP_OBS_EFF_TIME_HIGH,
	ENTRY_RELSHIP_OBS_VALUE,
	ENTRY_RELSHIP_OBS_CODE_L2,
	ENTRY_RELSHIP_OBS_NAME,
	ENTRY_RELSHIP_OBS_CODE_SYSTEM_NAME,
	ENTRY_RELSHIP_OBS_AUTHOR_TIME,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_ROOT,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_EXT,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_DISP_NAME,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE_SYSTEM,
	ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE_SYSTEM_NAME,
	ENTRY_RELSHIP_ASSIGNED_PERSON,
	PARTICIPANT_TYPE_CODE,
	PARTICIPANT_ROLE_CLASS_CODE,
	PLAYING_ENTITY_CLASS_CODE,
	PLAYING_ENTITY_CODE,
	PLAYING_ENTITY_CODE_NAME,
	PLAYING_ENTITY_CODE_SYSTEM,
	PLAYING_ENTITY_CODE_SYSTEM_NAME,
	ALLERGY_REFERENCE_VALUE,
	FLAT_ER_TYPE_CODE,
	FLAT_ER_INVERSION_IND,
	FLAT_ER_OBS_CLASS_CODE,
	FLAT_ER_OBS_MOOD_CODE,
	FLAT_ER_ID_ROOT,
	FLAT_ER_ID_EXT,
	FLAT_ER_OBS_CODE,
	FLAT_ER_OBS_NAME,
	FLAT_ER_OBS_CODE_SYSTEM,
	FLAT_ER_OBS_CODE_SYSTEM_NAME,
	FLAT_ER_OBS_CODE_STATUS_CODE,
	FLAT_ER_OBS_VALUE,
	FLAT_ER_OBS_VALUE_CODE,
	FLAT_ER_OBS_VALUE_CODE_NAME,
	FLAT_ER_OBS_VALUE_CODE_SYSTEM,
	FLAT_ER_OBS_CODE_SYSTEM_NAME_L2,
	XML_ROW_NUMBER,
	XML_TS_LAST_MODIFY,
	XML_TS_SCAN_TIME
) as
SELECT X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN      
      ,GET(XMLGET(XMLGET(x.xml,'section'),'templateId'),'@root')::STRING AS TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(x.xml,'section'),'templateId'),'@extension')::STRING AS TEMPLATE_ID_EXT

      ,GET( F.VALUE, '@typeCode')::STRING AS ENTRY_TYPE_CODE 
      ,GET(XMLGET( F.VALUE,'act'),'@classCode')::STRING AS ACT_CLASS_CODE 
      ,GET(XMLGET( F.VALUE,'act'),'@moodCode')::STRING AS ACT_MOOD_CODE 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'id'),'@root')::STRING AS ACT_ID_ROOT 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'id'),'@extension')::STRING AS ACT_ID_EXT 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@code')::STRING AS ACT_CODE 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@displayName')::STRING AS ACT_CODE_NAME 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@codeSystem')::STRING AS ACT_CODE_SYSTEM 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'code'),'@codeSystemName')::STRING AS ACT_CODE_SYSTEM_NAME 
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'statusCode'),'@code')::STRING AS ACT_STATUS_CODE 
      ,NVL( GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'effectiveTime'),'low'),'@value')::STRING,'N/A') AS EFFECTIVE_TIME_LOW
      ,NVL( GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'effectiveTime'),'high'),'@value')::STRING,'N/A') AS EFFECTIVE_TIME_HIGH      
      ,NVL( GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'templateId'),'@root')::STRING,'N/A')AS AUTHOR_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS ASSIGNED_AUTHOR_ID_ROOT 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS ASSIGNED_AUTHOR_ID_EXT 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS ASSIGNED_AUTHOR_CODE 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS ASSIGNED_AUTHOR_CODE_NAME 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS ASSIGNED_AUTHOR_CODE_SYSTEM 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),'code'),
                                        '@codeSystemName')::STRING AS ASSIGNED_AUTHOR_CODE_SYSTEM_NAME 
      ,CONCAT (
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),
                                        'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),
                                       'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),
                                        'assignedPerson'),'name'),'given',1):"$"::STRING, ' ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'author'),'assignedAuthor'),
                                        'assignedPerson'),'name'),'suffix'):"$"::STRING
            ) AS ASSIGNED_PERSON
      ,GET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'@typeCode')::STRING AS ENTRY_RELSHIP_TYPE_CODE -- 1776
      ,GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'@classCode')::STRING AS ENTRY_RELSHIP_OBS_CLASS_CODE -- 1777
      ,GET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'@moodCode')::STRING AS ENTRY_RELSHIP_OBS_MOOD_CODE -- 1777           
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),
                  '@root')::STRING AS ENTRY_RELSHIP_TEMPLATE_ID_ROOT -- 1778      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),
                  '@extension')::STRING AS ENTRY_RELSHIP_TEMPLATE_ID_EXT -- 1778
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'id'),'@root')::STRING AS ENTRY_RELSHIP_OBS_ID_ROOT -- 1780
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'id'),'@extension')::STRING AS ENTRY_RELSHIP_OBS_ID_EXT -- 1780
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@code')::STRING AS ENTRY_RELSHIP_OBS_CODE -- 1780
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@codeSystem')::STRING AS ENTRY_RELSHIP_OBS_CODE_SYSTEM -- 1780
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'statusCode'),'@code')::STRING AS ENTRY_RELSHIP_OBS_STATUS_CODE -- 1780   
      --
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'effectiveTime'),'low'),'@value')::STRING,'NA') AS ENTRY_RELSHIP_OBS_EFF_TIME_LOW
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'effectiveTime'),'high'),'@value')::STRING,'NA') AS ENTRY_RELSHIP_OBS_EFF_TIME_HIGH
       --      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@xsi:type')::STRING AS ENTRY_RELSHIP_OBS_VALUE -- 1780  
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@code')::STRING AS ENTRY_RELSHIP_OBS_CODE_L2
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@displayName')::STRING AS ENTRY_RELSHIP_OBS_NAME -- 1780
      --,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'value'),
      --             '@codeSystem')::STRING AS ENTRY_RELSHIP_OBS_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'value'),
                    '@codeSystemName')::STRING AS ENTRY_RELSHIP_OBS_CODE_SYSTEM_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'), 'time'),'@value')::STRING AS ENTRY_RELSHIP_OBS_AUTHOR_TIME
      --
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'), 'assignedAuthor'),'id'),'@root')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'), 'assignedAuthor'),'id'),'@extension')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_EXT      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'), 'assignedAuthor'),'code'),'@code')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                    'assignedAuthor'),'code'),'@displayName')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_DISP_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                    'assignedAuthor'),'code'),'@codeSystem')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                    'assignedAuthor'),'code'),'@codeSystemName')::STRING AS ENTRY_RELSHIP_OBS_ASSIGNED_AUTHOR_CODE_SYSTEM_NAME
      ,CONCAT (
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                 'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                 'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                 'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING, ' ',
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'author'),
                 'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING                
            ) AS ENTRY_RELSHIP_ASSIGNED_PERSON 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),
                          '@typeCode')::STRING AS PARTICIPANT_TYPE_CODE 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                          '@classCode')::STRING AS PARTICIPANT_ROLE_CLASS_CODE 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                         'playingEntity'),'@classCode')::STRING AS PLAYING_ENTITY_CLASS_CODE 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                         'playingEntity'),'code'),'@code')::STRING AS PLAYING_ENTITY_CODE                          
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                         'playingEntity'),'code'),'@displayName')::STRING,'N/A') AS PLAYING_ENTITY_CODE_NAME 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                         'playingEntity'),'code'),'@codeSystem')::STRING AS PLAYING_ENTITY_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),'participantRole'),
                         'playingEntity'),'code'),'@codeSystemName')::STRING AS PLAYING_ENTITY_CODE_SYSTEM_NAME 
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE,'act'),'entryRelationship'),'observation'),'participant'),
                          'participantRole'),'playingEntity'),'code'),'originalText'),'reference'),'@value')::STRING AS ALLERGY_REFERENCE_VALUE 
      ,GET( ER.VALUE,'@typeCode')::STRING AS FLAT_ER_TYPE_CODE 
      ,GET( ER.VALUE,'@inversionInd')::STRING AS FLAT_ER_INVERSTION_IND 
      ,GET(XMLGET(ER.VALUE,'observation'),'@classCode')::STRING AS FLAT_ER_OBS_CLASS_CODE 
      ,GET(XMLGET(ER.VALUE,'observation'),'@moodCode')::STRING AS FLAT_ER_OBS_MOOD_CODE 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'id'),'@root')::STRING AS FLAT_ER_ID_ROOT 
      ,NVL(GET(XMLGET(XMLGET(ER.VALUE,'observation'),'id'),'@extension')::STRING,'N/A') AS FLAT_ER_ID_EXT 
      ,NVL(GET(XMLGET(XMLGET(ER.VALUE,'observation'),'code'),'@code')::STRING,'N/A') AS FLAT_ER_OBS_CODE 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'code'),'@displayName')::STRING AS FLAT_ER_OBS_NAME 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'code'),'@codeSystem')::STRING AS FLAT_ER_OBS_CODE_SYSTEM 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'code'),'@codeSystemName')::STRING AS FLAT_ER_OBS_CODE_SYSTEM_NAME 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'statusCode'),'@code')::STRING AS FLAT_ER_OBS_CODE_STATUS_CODE 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'value'),'@xsi:type')::STRING AS FLAT_ER_OBS_VALUE 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'value'),'@code')::STRING AS FLAT_ER_OBS_VALUE_CODE 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'value'),'@displayName')::STRING AS FLAT_ER_OBS_VALUE_CODE_NAME 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'value'),'@codeSystem')::STRING AS FLAT_ER_OBS_VALUE_CODE_SYSTEM 
      ,GET(XMLGET(XMLGET(ER.VALUE,'observation'),'value'),'@codeSystemName')::STRING AS FLAT_ER_OBS_VALUE_CODE_SYSTEM_NAME_L2
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME 
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(X.XML, 'section'):"$") F    
    ,LATERAL FLATTEN(XMLGET(XMLGET(XMLGET(F.VALUE, 'act'),'entryRelationship'),'observation'):"$") ER        
WHERE SECTION_TITLE like 'Allergies%'
AND F.VALUE LIKE '%entry%'
AND ER.VALUE like '%entryRelationship%';
