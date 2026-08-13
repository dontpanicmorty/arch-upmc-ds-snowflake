CREATE OR REPLACE VIEW QUALITY.CCD_MENTAL_STATUS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	TEMPLATE_ROOT,
	TEMPLATE_EXTENSION,
	MENTAL_STATUS_CODE,
	MENTAL_STATUS_CODE_SYSTEM,
	MENTAL_STATUS_CODE_SYSTEM_NAME,
	MENTAL_STATUS_NAME,
	OBS_CLASS_CODE,
	OBS_MOOD_CODE,
	OBS_TEMPLATE_ROOT,
	OBS_TEMPLATE_EXTENSION,
	OBS_ID_ROOT,
	OBS_CODE_SYSTEM,
	OBS_CODE_SYSTEM_NAME,
	OBS_CODE,
	OBS_CODE_NAME,
	OBS_REFERENCE_VALUE,
	OBS_TRANSLATE_CODE,
	OBS_TRANSLATE_NAME,
	OBS_TRANSLATE_CODE_SYSTEM,
	OBS_TRANSLATE_CODE_SYSTEM_NAME,
	OBS_TEXT_REFERENCE,
	OBS_STATUS_CODE,
	OBS_EFFECTIVE_TIME_LOW,
	OBS_EFFECTIVE_TIME_VALUE,
	OBS_VALUE_TYPE,
	OBS_VALUE,
	OBS_VALUE_CODE,
	OBS_VALUE_CODE_SYSTEM,
	OBS_VALUE_CODE_SYSTEM_NAME,
	OBS_VALUE_DISPLAY_NAME,
	OBS_ORIGINAL_REFERENCE,
	OBS_RANGE_TEXT_VALUE,
	OBS_RANGE_XSI_VALUE,
	OBS_RANGE_XSI_VALUE_LOW,
	OBS_RANGE_XSI_VALUE_HIGH,
	OBS_RANGE_INTERPRET_CODE,
	OBS_RANGE_INTERPRET_CODE_SYSTEM,
	OBS_RANGE_INTERPRET_CODE_SYSTEM_NAME,
	ER_TYPE_CODE,
	ER_OBS_CLASS,
	ER_OBS_MOOD,
	ER_OBS_TEMPLATE_ROOT,
	ER_OBS_ID_ROOT,
	ER_OBS_CLASS_CODE,
	ER_OBS_CLASS_CODE_SYSTEM,
	ER_OBS_CLASS_CODE_SYSTEM_NAME,
	ER_OBS_TEXT,
	ER_OBS_STATUS,
	ER_OBS_EFFECTIVE_TIME,
	ER_OBS_VALUE_TYPE,
	ER_OBS_VALUE,
	ER_OBS_VALUE_TYPE_2,
	ER_OBS_CODE_2,
	ER_OBS_NAME_2,
	ER_OBS_CODE_SYSTEM_2,
	ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as
SELECT SECTION_TITLE
       ,FILENAME
       ,MRN
       ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS TEMPLATE_ROOT
       ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS TEMPLATE_EXTENSION
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS MENTAL_STATUS_CODE
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS MENTAL_STATUS_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS MENTAL_STATUS_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS MENTAL_STATUS_NAME
       ,GET(XMLGET( F.VALUE, 'observation'),'@classCode')::STRING AS OBS_CLASS_CODE
       ,GET(XMLGET( F.VALUE, 'observation'),'@moodCode')::STRING AS OBS_MOOD_CODE       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'templateId'),'@root')::STRING AS OBS_TEMPLATE_ROOT 
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'templateId',1),'@extension')::STRING AS OBS_TEMPLATE_EXTENSION       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'id'),'@root')::STRING AS OBS_ID_ROOT
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'@codeSystem')::STRING AS OBS_CODE_SYSTEM
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'@codeSystem')::STRING AS OBS_CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'@code')::STRING AS OBS_CODE
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'@displayName')::STRING AS OBS_CODE_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'originalText'),'reference'),'@value')::STRING AS OBS_REFERENCE_VALUE
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'translation'),'@code')::STRING AS OBS_TRANSLATE_CODE
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'translation'),'@displayName')::STRING AS OBS_TRANSLATE_NAME
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'translation'),'@codeSystem')::STRING AS OBS_TRANSLATE_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'code'),'translation'),'@codeSystemName')::STRING AS OBS_TRANSLATE_CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'text'),'reference'),'@value')::STRING AS OBS_TEXT_REFERENCE
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'statusCode'),'@code')::STRING AS OBS_STATUS_CODE       
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'effectiveTime'),'low'),'@value')::STRING AS OBS_EFFECTIVE_TIME_LOW 
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'effectiveTime'),'@value')::STRING AS OBS_EFFECTIVE_TIME_VALUE       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@xsi:type')::STRING AS OBS_VALUE_TYPE
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@value')::STRING AS OBS_VALUE       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@code')::STRING AS OBS_VALUE_CODE       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@codeSystem')::STRING AS OBS_VALUE_CODE_SYSTEM       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@codeSystemName')::STRING AS OBS_VALUE_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'@displayName')::STRING AS OBS_VALUE_DISPLAY_NAME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'value'),'originalText'),'reference'),'@value')::STRING AS OBS_ORIGINAL_REFERENCE
       --
       -- <referenceRange> fields
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'text'),'reference'),'@value')::STRING AS OBS_RANGE_TEXT_VALUE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'value'),'@xsi:type')::STRING AS OBS_RANGE_XSI_VALUE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'value'),'low'),'@value')::STRING AS OBS_RANGE_XSI_VALUE_LOW
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'value'),'high'),'@value')::STRING AS OBS_RANGE_XSI_VALUE_HIGH       
       --
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'interpretationCode'),'@code')::STRING AS OBS_RANGE_INTERPRET_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'interpretationCode'),'@codeSystem')::STRING AS OBS_RANGE_INTERPRET_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'observation'),'referenceRange'),'observationRange'),'interpretationCode'),'@displayName')::STRING AS OBS_RANGE_INTERPRET_CODE_SYSTEM_NAME       
       --
       -- <entryRelationship> elements
       ,GET( ER.VALUE, '@typeCode')::STRING AS ER_TYPE_CODE      
       ,GET(XMLGET( ER.VALUE, 'observation'),'@classCode')::STRING AS ER_OBS_CLASS
       ,GET(XMLGET( ER.VALUE, 'observation'),'@moodCode')::STRING AS ER_OBS_MOOD       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'templateId'),'@root')::STRING AS ER_OBS_TEMPLATE_ROOT
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'id'),'@root')::STRING AS ER_OBS_ID_ROOT       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'code'),'@code')::STRING AS ER_OBS_CLASS_CODE       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'code'),'@codeSystem')::STRING AS ER_OBS_CLASS_CODE_SYSTEM
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'code'),'@codeSystemName')::STRING AS ER_OBS_CLASS_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET(XMLGET( ER.VALUE, 'observation'),'text'),'reference'),'@value')::STRING AS ER_OBS_TEXT       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'statusCode'),'@code')::STRING AS ER_OBS_STATUS       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'effectiveTime'),'@value')::STRING AS ER_OBS_EFFECTIVE_TIME       
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value'),'@xsi:type')::STRING AS ER_OBS_VALUE_TYPE
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value'),'@value')::STRING AS ER_OBS_VALUE
       --
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value',1),'@xsi:type')::STRING AS  ER_OBS_VALUE_TYPE_2
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value',1),'@code')::STRING AS  ER_OBS_CODE_2
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value',1),'@displayName')::STRING AS ER_OBS_NAME_2
       ,GET(XMLGET(XMLGET( ER.VALUE, 'observation'),'value',1),'@codeSystem')::STRING AS ER_OBS_CODE_SYSTEM_2
       ,ROW_NUM               
       ,TS_LAST_MODIFY
         ,SCAN_TIME
FROM QUALITY.SECTION_XML X
     ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
     ,LATERAL FLATTEN(XMLGET(F.VALUE, 'observation'):"$") ER
WHERE SECTION_TITLE in ('Mental Status', 'MENTAL STATUS' )
AND F.VALUE LIKE '%entry%'
AND ER.VALUE LIKE '%entryRelationship%';