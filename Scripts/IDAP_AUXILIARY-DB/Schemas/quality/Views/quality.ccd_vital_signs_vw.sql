CREATE OR REPLACE VIEW QUALITY.CCD_VITAL_SIGNS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	TEMPLATE_ID_EXTENSION_A,
	TEMPLATE_ID_ROOT_A,
	TEMPLATE_ID_ROOT_B,
	TEMPLATE_ID_EXTENSION_C,
	TEMPLATE_ID_ROOT_C,
	TEMPLATE_ID_ROOT_D,
	SECTION_DATE,
	SECTION_CODE,
	SECTION_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	ORGANIZER_CLASS_CODE,
	ORGANIZER_MOOD_CODE,
	ENTRY_TEMPLATE_ID_EXTENSION,
	ENTRY_TEMPLATE_ID_ROOT,
	ENTRY_TEMPLATE_ID_ROOT_B,
	ORGANIZER_ID_ROOT,
	ORGANIZER_ID_EXT,
	ENTRY_CODE,
	ENTRY_CODE_SYSTEM,
	ENTRY_NAME,
	ENTRY_CODE_SYSTEM_NAME,
	ENTRY_CODE_TRANSLATION,
	ENTRY_CODE_TRANSLATION_NAME,
	ENTRY_CODE_TRANSLATION_SYSTEM,
	ENTRY_CODE_TRANSLATION_SYSTEM_NAME,
	ENTRY_STATUS_CODE,
	EFFECTIVE_TIME_LOW,
	EFFECTIVE_TIME_HIGH,
	AUTHOR_ROOT,
	AUTHOR_TIME,
	ASSIGNED_AUTHOR_ID,
	ASSIGNED_AUTHOR_EXTENSION,
	AUTHOR_CODE,
	ASSIGNED_AUTHOR_CODE_NAME,
	AUTHOR_CODE_SYSTEM,
	AUTHOR_CODE_SYSTEM_NAME,
	ASSIGNED_PERSON_NAME,
	COMPONENT_CLASS_CODE,
	COMPONENT_MOOD_CODE,
	COMPONENT_TEMPLATE_EXTENSION,
	COMPONENT_TEMPLATE_ROOT_A,
	COMPONENT_TEMPLATE_ROOT_B,
	COMPONENT_ID_EXT,
	COMPONENT_ID_ROOT,
	COMPONENT_CODE,
	COMPONENT_CODE_NAME,
	COMPONENT_CODE_SYSTEM,
	COMPONENT_CODE_SYSTEM_NAME,
	COMPONENT_STATUS_CODE,
	COMPONENT_DATE,
	COMPONENT_VALUE_TYPE,
	COMPONENT_VALUE,
	COMPONENT_VALUE_UNIT,
	COMPONENT_AUTHOR_TEMPLATE_ID_ROOT,
	COMPONENT_AUTHOR_TIME,
	ASSIGNED_AUTHOR_ID_ROOT,
	ASSIGNED_AUTHOR_EXT,
	ASSIGNED_AUTHOR_CODE,
	ASSICNED_AUTHOR_CODE_NAME,
	ASSIGNED_AUTHOR_CODE_SYSTEM,
	ASSIGNED_AUTHOR_CODE_SYSTEM_NAME,
	ASSIGNED_AUTHOR_NAME,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME,
	F_INDEX,
	COMP_INDEX
) as
SELECT X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS TEMPLATE_ID_EXTENSION_A
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS TEMPLATE_ID_ROOT_A
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING AS TEMPLATE_ID_ROOT_B
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',2),'@extension')::STRING AS TEMPLATE_ID_EXTENSION_C
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',2),'@root')::STRING AS TEMPLATE_ID_ROOT_C
	  ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',3),'@root')::STRING AS TEMPLATE_ID_ROOT_D
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS SECTION_DATE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM                  
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING as SECTION_CODE_SYSTEM_NAME
      ,GET( F.VALUE,'@typeCode')::STRING as ENTRY_TYPE_CODE
      ,GET(XMLGET(F.VALUE,'organizer'),'@classCode')::STRING AS ORGANIZER_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'organizer'),'@moodCode')::STRING AS ORGANIZER_MOOD_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId'),'@extension')::STRING AS ENTRY_TEMPLATE_ID_EXTENSION
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId'),'@root')::STRING AS ENTRY_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId',1),'@root')::STRING AS ENTRY_TEMPLATE_ID_ROOT_B
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'id'),'@root')::STRING AS ORGANIZER_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'id'),'@extension')::STRING AS ORGANIZER_ID_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@code')::STRING AS ENTRY_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@codeSystem')::STRING AS ENTRY_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@displayName')::STRING AS ENTRY_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@codeSystemName')::STRING AS ENTRY_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'translation'),'@code')::STRING AS ENTRY_CODE_TRANSLATION
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'translation'),'@displayName')::STRING AS ENTRY_CODE_TRANSLATION_NAME
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'translation'),'@codeSystem')::STRING AS ENTRY_CODE_TRANSLATION_SYSTEM      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'translation'),'@codeSystemName')::STRING AS ENTRY_CODE_TRANSLATION_SYSTEM_NAME      
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'statusCode'),'@code')::STRING AS ENTRY_STATUS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'effectiveTime'),'low'),'@value')::STRING AS EFFECTIVE_TIME_LOW
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'effectiveTime'),'high'),'@value')::STRING AS EFFECTIVE_TIME_HIGH      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'templateId'),'@root')::STRING AS AUTHOR_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS ASSIGNED_AUTHOR_ID
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS ASSIGNED_AUTHOR_EXTENSION
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS ASSIGNED_AUTHOR_CODE_NAME         
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS AUTHOR_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@codeSystemName')::STRING AS AUTHOR_CODE_SYSTEM_NAME      
      ,CASE
       WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING IS NULL
       THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
       ELSE     
           CONCAT ( 
             NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ''), ', ',
	         NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ''), ' ',            
             NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING, ''), ' ' 
			)
       END AS ASSIGNED_PERSON_NAME    
      ,GET(XMLGET(COMP.VALUE,'observation'),'@classCode')::STRING AS COMPONENT_CLASS_CODE
      ,GET(XMLGET(COMP.VALUE,'observation'),'@moodCode')::STRING AS COMPONENT_MOOD_CODE      
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'templateId'),'@extension')::STRING AS COMPONENT_TEMPLATE_ID_EXTENSION
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'templateId'),'@root')::STRING AS COMPONENT_TEMPLATE_ID_ROOT_A
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'templateId',1),'@root')::STRING AS COMPONENT_TEMPLATE_ID_ROOT_B      
      -- ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'templateId'),'@extension')::STRING AS COMPONENT_TEMPLATE_ID_EXT
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'id'),'@root')::STRING AS COMPONENT_ID_ROOT
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'id'),'@extension')::STRING AS COMPONENT_ID_EXT
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'code'),'@code')::STRING AS COMPONENT_CODE
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'code'),'@displayName')::STRING AS COMPONENT_CODE_NAME
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'code'),'@codeSystem')::STRING AS COMPONENT_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'code'),'@codeSystemName')::STRING AS COMPONENT_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'statusCode'),'@code')::STRING AS COMPONENT_STATUS_CODE
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'effectiveTime'),'@value')::STRING AS COMPONENT_DATE
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'value'),'@xsi:type')::STRING AS COMPONENT_VALUE_TYPE
      -- ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'value'),'@value')::STRING AS COMPONENT_VALUE
      ,QUALITY.FXN_EXTRACT_VALUE( XMLGET(XMLGET(COMP.VALUE,'observation'),'value')::STRING, 'value=' ) AS COMPONENT_VALUE        
      ,GET(XMLGET(XMLGET(COMP.VALUE,'observation'),'value'),'@unit')::STRING AS COMPONENT_VALUE_UNIT
      ,GET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'templateId'),'@root')::STRING AS COMPONENT_AUTHOR_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'time'),'@value')::STRING AS COMPONENT_AUTHOR_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS ASSIGNED_AUTHOR_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS ASSIGNED_AUTHOR_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS ASSIGNED_AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS ASSIGNED_AUTHOR_CODE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS ASSIGNED_AUTHOR_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@codeSystemName')::STRING AS ASSIGNED_AUTHOR_CODE_SYSTEM_NAME
      ,CASE
       WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING IS NULL
       THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( COMP.VALUE, 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
       ELSE     
           CONCAT ( 
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING,''), ', ',	  
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING,''), ' ',
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ',            
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(COMP.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING,''), ' '            
            )
       END AS ASSIGNED_AUTHOR_NAME      
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME
      ,F.INDEX AS F_INDEX
      ,COMP.INDEX AS COMP_INDEX      
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(X.XML, 'section'):"$") F
    ,LATERAL FLATTEN(XMLGET(F.VALUE, 'organizer'):"$") COMP
WHERE SECTION_TITLE = 'Vital Signs'
AND F.VALUE LIKE '%entry%'
and COMP.VALUE like '%component%';
