CREATE OR REPLACE VIEW QUALITY.CCD_SOCIAL_HISTORY_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	SECTION_DATE,
	SECTION_CODE,
	SECTION_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	OBSERVATION_CLASS_CODE,
	OBSERVATION_MOOD_CODE,
	TEMPLATE_ID_EXT,
	OBS_ID_ROOT,
	OBS_ID_EXT,
	OBS_CODE,
	OBS_CODE_NAME,
	OBS_CODE_SYSTEM,
	OBS_CODE_SYSTEM_NAME,
	CODE_TEXT,
	TRANSLATE_CODE,
	TRANSLATE_NAME,
	TRANSLATE_CODE_SYSTEM,
	TRANSLATE_CODE_SYSTEM_NAME,
	STATUS_CODE,
	EFFECTIVE_TIME,
	EFFECTIVE_NULL_FLAVOR,
	OBS_VALUE,
	OBS_VALUE_CODE,
	OBS_DISPLAY_NAME,
	OBS_TIME,
	OBS_TIME_NULL_FLAVOR,
	ASSIGNED_AUTHOR_ID,
	ASSIGNED_AUTHOR_NULL_FLAVOR,
	ASSIGNED_AUTHOR_CODE,
	ASSIGNED_AUTHOR_CODE_NULL_FLAVOR,
	ASSIGNED_PERSON_NAME,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME
) as
SELECT X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS SECTION_DATE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM                  
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING as SECTION_CODE_SYSTEM_NAME
      ,GET( F.VALUE,'@typeCode')::STRING as ENTRY_TYPE_CODE      
      ,GET(XMLGET(F.VALUE,'observation'),'@classCode')::STRING AS OBSERVATION_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'observation'),'@moodCode')::STRING AS OBSERVATION_MOOD_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'templateId'),'@extension')::STRING AS TEMPLATE_ID_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'id'),'@root')::STRING AS OBS_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'id'),'@extension')::STRING AS OBS_ID_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'@code')::STRING AS OBS_CODE      
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'@displayName')::STRING AS OBS_CODE_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'@codeSystem')::STRING AS OBS_CODE_SYSTEM      
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'@codeSystemName')::STRING AS OBS_CODE_SYSTEM_NAME      
      ,XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'originalText'):"$"::STRING AS CODE_TEXT      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'translation'),'@code')::STRING AS TRANSLATE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'translation'),'@displayName')::STRING AS TRANSLATE_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'translation'),'@codeSystem')::STRING AS TRANSLATE_CODE_SYSTEM            
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'code'),'translation'),'@codeSystemName')::STRING AS TRANSLATE_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'statusCode'),'@code')::STRING AS STATUS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'effectiveTime'),'low'),'@value')::STRING AS EFFECTIVE_TIME
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'effectiveTime'),'low'),'@nullFlavor')::STRING AS EFFECTIVE_NULL_FLAVOR      
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'value'),'@xsi:type')::STRING AS OBS_VALUE      
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'value'),'@code')::STRING AS OBS_VALUE_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'observation'),'value'),'@displayName')::STRING AS OBS_DISPLAY_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'time'),'@value')::STRING AS OBS_TIME
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'time'),'@nullFlavor')::STRING AS OBS_TIME_NULL_FLAVOR      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@value')::STRING AS ASSIGNED_AUTHOR_ID      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@nullFlavor')::STRING AS ASSIGNED_AUTHOR_NULL_FLAVOR
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS ASSIGNED_AUTHOR_CODE      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@nullFlavor')::STRING AS ASSIGNED_AUTHOR_CODE_NULL_FLAVOR
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING AS ASSIGNED_PERSON_NAME      
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME      
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(X.XML, 'section'):"$") F
WHERE SECTION_TITLE = 'Social History'
AND F.VALUE LIKE '%entry%';