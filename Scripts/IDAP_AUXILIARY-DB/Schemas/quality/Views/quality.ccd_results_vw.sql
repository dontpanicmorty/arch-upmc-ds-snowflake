CREATE OR REPLACE VIEW QUALITY.CCD_RESULTS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	TEMPLATE_ID_ROOT_A,
	TEMPLATE_ID_EXTENSION_A,
	TEMPLATE_ID_ROOT_B,
	TEMPLATE_ID_ROOT_C,
	TEMPLATE_ID_EXTENSION_C,
	TEMPLATE_ID_ROOT_D,
	SECTION_TYPE_CODE,
	SECTION_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	ORGANIZER_CLASS_CODE,
	ORGANIZER_MOOD_CODE,
	ENTRY_TEMPLATE_EXT,
	ENTRY_TEMPLATE_ROOT_A,
	ENTRY_TEMPLATE_ROOT_B,
	ORGANIZER_ID_ROOT,
	ORGANIZER_ID_EXT,
	ENTRY_CODE,
	ENTRY_NAME,
	ENTRY_CODE_SYSTEM,
	ENTRY_CODE_SYSTEM_NAME,
	ENTRY_STATUS_CODE,
	AUTHOR_TEMPLATE_ID_ROOT,
	AUTHOR_TIME,
	AUTHOR_ID_ROOT,
	AUTHOR_ID_EXT,
	AUTHOR_CODE_NULL,
	AUTHOR_CODE,
	AUTHOR_CODE_NAME,
	AUTHOR_CODE_SYSTEM,
	AUTHOR_CODE_SYSTEM_NAME,
	ASSIGNED_PERSON_NAME,
	ORGANIZATION_CLASS_CODE,
	ORGANIZATION_ROOT,
	ORGANIZATION_ID_EXT,
	ORGANIZATION_NAME,
	ORGANIZATION_TELECOM_NULL,
	ORGANIZATION_TELECOM_USE,
	ORGANIZATION_TELEPHONE_NUM,
	ORGANIZATION_ADDR_USE,
	ORGANIZATION_STREET_ADDRESS,
	ORGANIZATION_CITY,
	ORGANIZATION_STATE,
	ORGANIZATION_ZIP_CODE,
	ORGANIZATION_COUNTRY,
	OBSERVATION_CLASS_CODE,
	OBSERVATION_MOOD_CODE,
	OBSERVATION_TEMPLATE_ROOT,
	OBSERVATION_TEMPLATE_EXT,
	OBSERVATION_ID_ROOT,
	OBSERVATION_ID_EXT,
	OBSERVATION_CODE,
	OBSERVATION_NAME,
	OBSERVATION_CODE_SYSTEM,
	OBSERVATION_SYSTEM_NAME,
	OBS_XLATE_CODE,
	OBS_XLATE_DISP_NAME,
	OBS_XLATE_CODE_SYSTEM,
	OBS_XLATE_CODE_SYSTEM_NAME,
	OBSERVATION_STATUS_CODE,
	OBSERVATION_TIME,
	OBSERVATION_VALUE_TYPE,
	OBSERVATION_VALUE,
	OBSERVATION_UNIT,
	OBSERVATION_INTERPRET_CODE,
	OBSERVATION_INTERPRET_CODE_SYSTEM,
	OBSERVATION_TEMPLATE_ID_ROOT,
	OBSERVATION_AUTHOR_TIME,
	OBSERVATION_AUTHOR_ID_ROOT,
	OBSERVATION_AUTHOR_ID_EXT,
	OBSERVATION_AUTHOR_CODE,
	OBSERVATION_AUTHOR_CODE_NAME,
	OBSERVATION_AUTHOR_CODE_SYSTEM_NAME,
	OBSERVATION_ASSIGNED_PERSON,
	ENTRY_ER_TYPE_CODE,
	ENTRY_ER_INVERSION_IND,
	ACT_CLASS_CODE,
	ACT_MOOD_CODE,
	ACT_TEMPLATE_ID,
	ACT_CODE,
	ACT_CODE_NAME,
	ACT_CODE_SYSTEM,
	ACT_CODE_SYSTEM_NAME,
	ACT_REFERENCE_VALUE,
	REFERENCE_VALUE,
	REFERENCE_VALUE_LOW,
	REFERENCE_VALUE_HIGH,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME,
	F_INDEX,
	ORG_INDEX
) as
SELECT X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING as ID_ROOT_A
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING as ID_EXTENSION_A
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING as ID_ROOT_B
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',2),'@root')::STRING as ID_ROOT_C
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',2),'@extension')::STRING as ID_EXTENSION_C
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',3),'@root')::STRING as ID_ROOT_D
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_TYPE_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS SECTION_CODE_SYSTEM_NAME
      ,GET( F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
      ,GET(XMLGET(F.VALUE,'organizer'),'@classCode')::STRING AS ORGANIZER_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'organizer'),'@moodCode')::STRING AS ORGANIZER_MOOD_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId'),'@extension')::STRING AS ENTRY_TEMPLATE_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId'),'@root')::STRING AS ENTRY_TEMPLATE_ROOT_A
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'templateId',1),'@root')::STRING AS ENTRY_TEMPLATE_ROOT_B
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'id'),'@root')::STRING AS ORGANIZER_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'id'),'@extension')::STRING AS ORGANIZER_ID_EXT
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@code')::STRING AS ENTRY_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@displayName')::STRING AS ENTRY_NAME
      --
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@codeSystem')::STRING AS ENTRY_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'code'),'@codeSystemName')::STRING AS ENTRY_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'organizer'),'statusCode'),'@code')::STRING AS ENTRY_STATUS_CODE
      --
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'templateId'),'@root')::STRING AS AUTHOR_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS AUTHOR_ID_ROOT	  
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS AUTHOR_ID_EXT
      -- new field:
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@nullFlavor')::STRING AS AUTHOR_CODE_NULL
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS AUTHOR_CODE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS AUTHOR_CODE_SYSTEM	  
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'code'),'@codeSystemName')::STRING AS AUTHOR_CODE_SYSTEM_NAME
      --
      ,CASE
           WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING IS NULL
           THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
           ELSE           
              CONCAT(
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',	  
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
                NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ',                
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING, ' '
                --GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'), '@qualifier')::STRING
          ) 
       END AS ASSIGNED_PERSON_NAME
       --
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'@classCode')::STRING AS ORGANIZATION_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'id'),'@root')::STRING AS ORGANIZATION_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'id'),'@extension')::STRING AS ORGANIZATION_ID_EXT
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'name'):"$"::STRING AS ORGANIZATION_NAME
      --
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'telecom'),'@nullFlavor')::STRING AS ORGANIZATION_TELECOM_NULL
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'telecom'),'@use')::STRING AS ORGANIZATION_TELECOM_USE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'telecom'),'@value')::STRING AS ORGANIZATION_TELEPHONE_NUM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'@use')::STRING AS ORGANIZATION_ADDR_USE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),
                     'addr'),'streetAddressLine'):"$"::STRING AS ORGANIZATION_STREET_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'city'):"$"::STRING AS ORGANIZATION_CITY
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'state'):"$"::STRING AS ORGANIZATION_STATE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS ORGANIZATION_ZIP_CODE
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'organizer'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'country'):"$"::STRING AS ORGANIZATION_COUNTRY
      ,GET(XMLGET(ORG.VALUE,'observation'),'@classCode')::STRING AS OBSERVATION_CLASS_CODE
      ,GET(XMLGET(ORG.VALUE,'observation'),'@moodCode')::STRING AS OBSERVATION_MOOD_CODE
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'templateId'),'@root')::STRING AS OBSSERVATION_TEMPLATE_ROOT
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'templateId'),'@extension')::STRING AS OBSERVATION_TEMPLATE_EXT
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'id'),'@root')::STRING AS OBSERVATION_ID_ROOT
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'id'),'@extension')::STRING AS OBSERVATION_ID_EXT
      ,NVL( GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'@code')::STRING,'NA') AS OBSERVATION_CODE
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'@displayName')::STRING AS OBSERVATION_NAME
      --
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'@codeSystem')::STRING AS OBSERVATION_CODE_SYTEM
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'@codeSystemName')::STRING AS OBSERVATION_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'translation'),'@code')::STRING AS OBS_XLATE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'translation'),'@displayName')::STRING AS OBS_XLATE_DISP_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'translation'),'@codeSystem')::STRING AS OBS_XLATE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'code'),'translation'),'@codeSystemName')::STRING AS OBS_XLATE_CODE_SYSTEM_NAME      
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'statusCode'),'@code')::STRING AS OBSERVATION_STATUS_CODE
      ,NVL(GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'effectiveTime'),'@value')::STRING,'NA') AS OBSERVATION_TIME
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'value'),'@xsi:type')::STRING AS OBSERVATION_VALUE_TYPE      
      ,QUALITY.FXN_EXTRACT_VALUE( XMLGET(XMLGET(ORG.VALUE,'observation'),'value')::STRING, 'value=' ) as OBSERVATION_VALUE
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'value'),'@unit')::STRING AS OBSERVATION_UNIT
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'interpretationCode'),'@code')::STRING AS OBSERVATION_INTERPRET_CODE
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'interpretationCode'),'@codeSystem')::STRING AS OBSERVATION_INTERPRET_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'templateId'),'@root')::STRING AS OBSERVATION_TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'time'),'@value')::STRING AS OBSERVATION_AUTHOR_TIME
      --
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS OBSERVATION_AUTHOR_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS OBSERVATION_AUTHOR_ID_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS OBSERVATION_AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS OBSERVATION_AUTHOR_CODE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'code'),'@codeSystemName')::STRING AS OBSERVATION_AUTHOR_CODE_SYSTEM_NAME
      ,CONCAT(
              XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',	  
	          XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',              
	          NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ',
              XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING
             ) AS OBSERVATION_ASSIGNED_PERSON              
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'@typeCode')::STRING AS ENTRY_ER_TYPE_CODE
      ,GET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'@inversionInd')::STRING AS ENTRY_ER_INVERSION_IND
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), '@classCode')::STRING AS ACT_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), '@moodCode')::STRING as ACT_MOOD_CODE      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'),'templateId'), '@root')::STRING as ACT_TEMPLATE_ID
      ,NVL( GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), 'code'),'@code')::STRING,'NA') AS ACT_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), 'code'),'@displayName')::STRING AS ACT_CODE_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), 'code'),'@codeSystem')::STRING AS ACT_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), 'code'),'@codeSystemName')::STRING AS ACT_CODE_SYSTEM_NAME
      ,NVL(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'entryRelationship'),'act'), 'text'),'reference'),'@value')::STRING,'NA') as ACT_REFERENCE_VALUE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'referenceRange'),'observationRange'),'value'),'@xsi:type')::STRING AS REFERENCE_VALUE
      ,QUALITY.FXN_EXTRACT_VALUE( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'referenceRange'),'observationRange'),'value'),'low')::STRING, 'value=' ) AS REFERENCE_VALUE_LOW
      ,QUALITY.FXN_EXTRACT_VALUE( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ORG.VALUE,'observation'),'referenceRange'),'observationRange'),'value'),'high')::STRING, 'value=' ) AS REFERENCE_VALUE_HIGH      
      ,ROW_NUM AS XML_DATA_ROW_NUM
      ,TS_LAST_MODIFY AS XML_DATA_TS_LAST_MODIFY
	  ,SCAN_TIME AS XML_DATA_SCAN_TIME
      ,F.INDEX AS F_INDEX
      ,ORG.INDEX AS ORG_INDEX
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
    ,LATERAL FLATTEN(XMLGET(F.VALUE, 'organizer'):"$") ORG
WHERE SECTION_TITLE = 'Results'
AND F.VALUE LIKE  '%entry%'
AND ORG.VALUE LIKE  '%component%';
