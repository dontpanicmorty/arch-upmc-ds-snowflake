CREATE OR REPLACE VIEW QUALITY.CCD_PROBLEMS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	SECTION_CODE,
	DISPLAY_NAME,
	CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	ACT_CLASS_CODE,
	ACT_MOOD_CODE,
	TEMPLATE_ROOT,
	TEMPLATE_EXTENSION,
	ID_ROOT,
	ID_EXTENSION,
	ACT_CODE,
	ACT_CODE_SYSTEM,
	STATUS_CODE,
	EFFECTIVE_TIME_LOW,
	EFFECTIVE_TIME_HIGH,
	AUTHOR_TEMPLATE_ROOT,
	AUTHOR_TIME,
	ASSIGNED_AUTHOR_ID,
	ASSIGNED_AUTHOR_EXTENSION,
	ASSIGNED_AUTHOR_CODE,
	ASSIGNED_PERSON_UNKNOWN,
	ASSIGNED_PERSON_NAME,
	ER_TYPE_CODE,
	ER_INVERSION_IND,
	ER_SEQUENCE,
	ER_OBS_CLASS_CODE,
	ER_OBS_MOOD_CODE,
	ER_OBS_TEMPLATE_ROOT,
	ER_OBS_TEMPLATE_EXTENSION,
	ER_OBS_ID_ROOT,
	ER_OBS_ID_EXTENSION,
	ER_OBS_CODE,
	ER_OBS_CODE_NAME,
	ER_OBS_CODE_SYSTEM,
	ER_OBS_CODE_SYSTEM_NAME,
	ER_OBS_TRANSLATE_CODE,
	ER_OBS_TRANSLATE_CODE_NAME,
	ER_OBS_TRANSLATE_CODE_SYSTEM,
	ER_OBS_TRANSLATE_CODE_SYSTEM_NAME,
	ER_OBS_STATUS_CODE,
	ER_OBS_EFFECTIVE_TIME_NOW,
	ER_OBS_EFFECTIVE_TIME_HIGH,
	ER_OBS_VALUE_TYPE,
	ER_OBS_VALUE_CODE,
	ER_OBS_VALUE_NAME,
	ER_OBS_VALUE_CODE_SYSTEM,
	ER_OBS_VALUE_CODE_SYSTEM_NAME,
	ORIG_TEXT_REF,
	VALUE_TRANS_CODE,
	VALUE_TRANS_DISPLAY_NAME,
	VALUE_TRANS_CODE_SYSTEM,
	VALUE_TRANS_CODE_SYSTEM_NAME,
	ER_AUTHOR_ROOT,
	ER_AUTHOR_TIME,
	ER_AUTHOR_ID_ROOT,
	ER_AUTHOR_ID_EXTENSION,
	ER_AUTHOR_CODE,
	ASSIGNED_PERSION_UNKNOWN,
	ER_ASSIGNED_PERSON_NAME,
	ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as
SELECT SECTION_TITLE
       ,FILENAME
       ,MRN
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_CODE       
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS DISPLAY_NAME
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
       ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME      
       ,GET(F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
       ,GET(XMLGET(F.VALUE,'act'),'@classCode')::STRING AS ACT_CLASS_CODE       
       ,GET(XMLGET(F.VALUE,'act'),'@moodCode')::STRING AS ACT_MOOD_CODE              
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'templateId'),'@root')::STRING AS TEMPLATE_ROOT
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'templateId'),'@extension')::STRING AS TEMPLATE_EXTENSION       
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'id'),'@root')::STRING AS ID_ROOT
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'id'),'@extension')::STRING AS ID_EXTENSION       
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'code'),'@code')::STRING AS ACT_CODE
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'code'),'@codeSystem')::STRING AS ACT_CODE_SYSTEM             
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'statusCode'),'@code')::STRING AS STATUS_CODE
       ,NVL(GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'effectiveTime'),'low'),'@value')::STRING,'NA') AS EFFECTIVE_TIME_LOW       
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'effectiveTime'),'high'),'@value')::STRING AS EFFECTIVE_TIME_HIGH
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'templateId'),'@root')::STRING AS AUTHOR_TEMPLATE_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS ASSIGNED_AUTHOR_ID
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS ASSIGNED_AUTHOR_EXTENSION       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS ASSIGNED_AUTHOR_CODE
       ,CASE
         WHEN LENGTH(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'act'),'author'), 
                   'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING) > 7
        THEN NULL
        ELSE
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
        END AS ASSIGNED_PERSON_UNKNOWN
       ,NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING,'') || ' ' ||
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,'') || ' ' ||
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING,'') || ' ' || 
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING,'')  AS ASSIGNED_PERSON_NAME
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'@typeCode')::STRING AS ER_TYPE_CODE
       ,GET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'@inversionInd')::STRING AS ER_INVERSION_IND       
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'sequenceNumber'),'@value')::STRING AS ER_SEQUENCE
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'@classCode')::STRING AS ER_OBS_CLASS_CODE       
       ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'@moodCode')::STRING AS ER_OBS_MOOD_CODE       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),'@root')::STRING AS ER_OBS_TEMPLATE_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'templateId'),'@extension')::STRING AS ER_OBS_TEMPLATE_EXTENSION       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'id'),'@root')::STRING AS ER_OBS_ID_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'id'),'@extension')::STRING AS ER_OBS_ID_EXTENSION       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@code')::STRING AS ER_OBS_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@displayName')::STRING AS ER_OBS_CODE_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@codeSystem')::STRING AS ER_OBS_CODE_SYSTEM       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'@codeSystemName')::STRING AS ER_OBS_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@code')::STRING AS ER_OBS_TRANSLATE_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@displayName')::STRING AS ER_OBS_TRANSLATE_CODE_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@codeSystem')::STRING AS ER_OBS_TRANSLATE_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'code'),'translation'),'@codeSystemName')::STRING AS ER_OBS_TRANSLATE_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'statusCode'),'@code')::STRING AS ER_OBS_STATUS_CODE       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'effectiveTime'),'low'),'@value')::STRING AS ER_OBS_EFFECTIVE_TIME_LOW
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'effectiveTime'),'high'),'@value')::STRING AS ER_OBS_EFFECTIVE_TIME_HIGH       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@xsi:type')::STRING AS ER_OBS_VALUE_TYPE       
       ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@code')::STRING,'NA') AS ER_OBS_VALUE_CODE       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@displayName')::STRING AS ER_OBS_VALUE_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@codeSystem')::STRING AS ER_OBS_VALUE_CODE_SYSTEM       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'@codeSystemName')::STRING AS ER_OBS_VALUE_CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'originalText'),'reference'),'@value')::STRING AS ORIG_TEXT_REF
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@code')::STRING AS VALUE_TRANS_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@displayName')::STRING AS VALUE_TRANS_DISPLAY_NAME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@codeSystem')::STRING AS VALUE_TRANS_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'value'),'translation'),'@codeSystemName')::STRING AS VALUE_TRANS_CODE_SYSTEM_NAME       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'templateId'),'@root')::STRING AS ER_AUTHOR_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'time'),'@value')::STRING AS ER_AUTHOR_TIME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS ER_AUTHOR_ID_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS ER_AUTHOR_ID_EXTENSION       
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS ER_AUTHOR_CODE

       ,CASE
         WHEN LENGTH(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'act'),'entryRelationship'), 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING) > 7
        THEN NULL
        ELSE
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'),'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
        END AS ER_ASSIGNED_PERSON_UNKNOWN
       ,NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'), 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING,'') || ' ' ||
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'), 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,'') || ' ' ||
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'), 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING,'') || ' ' || 
            NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'act'),'entryRelationship'), 'observation'),'author'), 'assignedAuthor'),'assignedPerson'),
                        'name'),'suffix'):"$"::STRING,'')  AS ER_ASSIGNED_PERSON_NAME
       ,ROW_NUM                     
       ,TS_LAST_MODIFY
	   ,SCAN_TIME
FROM QUALITY.SECTION_XML X
     ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
WHERE SECTION_TITLE  = 'Problems'
AND F.VALUE LIKE '%entry%'
AND ENTRY_TYPE_CODE IS NOT NULL;
