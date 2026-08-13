
CREATE OR REPLACE VIEW QUALITY.CCD_PROCEDURES_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	ENTRY_TYPE_CODE,
	ENTRY_CLASS_CODE,
	ENTRY_MOOD_CODE,
	PROCEDURE_TEMPLATE_ROOT,
	PROCEDURE_TEMPLATE_EXT,
	PROCEDURE_TEMPLATE_ROOT_2,
	PROCEDURE_TEMPLATE_EXT_2,
	PROCEDURE_TEMPLATE_ROOT_3,
	PROCEDURE_TEMPL_ID_ROOT,
	PROCEDURE_TEMPL_ID_EXT,
	PROCEDURE_SECTION_CODE,
	PROCEDURE_SECTION_CODE_DISPLAY_NAME,
	PROCEDURE_SECTION_CODE_SYSTEM,
	PROCEDURE_SECTION_CODE_SYSTEM_NAME,
	PROCEDURE_CODE,
	PROCEDURE_OBS_CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	PROCEDURE_DISPLAY_NAME,
	PROCEDURE_REFERENCE_VALUE,
	PROCEDURE_STATUS,
	PROCEDURE_DATE,
	PERFORMER_TYPE_CODE,
	ENTITY_CLASS_CODE,
	ASSIGNED_PERSON_NPI,
	ENTITY_ROOT,
	ENTITY_NULL_FLAVOR,
	TELECOM_NULL_FLAVOR,
	TELEPHONE_NUMBER,
	TELEPHONE_USE,
	ASSIGN_PERSON_CLASS_CODE,
	DETERMINER_CODE,
	ASSIGNED_PERSON,
	REP_ORG_EXT,
	REP_ORG_ROOT,
	REP_ORG_NAME,
	REP_ORG_PHONE_USE,
	REP_ORG_PHONE_NUMBER,
	REP_ORG_ADDR_USE,
	REP_ORG_ADDRESS,
	REP_ORG_CITY,
	REP_ORG_STATE,
	REP_ORG_ZIP,
	REP_ORG_COUNTRY,
	AUTHOR_TEMPL_ID_ROOT,
	AUTHOR_TIME,
	AUTHOR_AA_ID_ROOT,
	AUTHOR_AA_ID_EXT,
	AUTHOR_AA_CODE,
	AUTHOR_AA_DISP_NAME,
	AUTHOR_AA_CODE_SYSTEM,
	AUTHOR_AA_CODE_SYSTEM_NAME,
	AUTHOR_AA_AP_NAME,
	XML_ROW_NUMBER,
	XML_TS_LAST_MODIFY,
	XML_TS_SCAN_TIME
) as 
SELECT SECTION_TITLE
       ,FILENAME
       ,MRN
       ,GET( F.VALUE, '@typeCode')::STRING AS ENTRY_TYPE_CODE
       ,GET(XMLGET( F.VALUE, 'procedure'), '@classCode')::STRING AS ENTRY_CLASS_CODE       
       ,GET(XMLGET( F.VALUE, 'procedure'), '@moodCode')::STRING AS ENTRY_MOOD_CODE
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'templateId'),'@root')::STRING AS PROCEDURE_TEMPLATE_ROOT       
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'templateId'),'@extension')::STRING AS PROCEDURE_TEMPLATE_EXT
        --
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'templateId',1),'@root')::STRING AS PROCEDURE_TEMPLATE_ROOT_2
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'templateId',1),'@extension')::STRING AS PROCEDURE_TEMPLATE_EXT_2
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'templateId',2),'@root')::STRING AS PROCEDURE_TEMPLATE_ROOT_3
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'id'),'@root')::STRING AS PROCEDURE_TEMPL_ID_ROOT
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'id'),'@extension')::STRING AS PROCEDURE_TEMPL_ID_EXT
       --
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@code')::STRING AS PROCEDURE_SECTION_CODE
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@displayName')::STRING AS PROCEDURE_SECTION_CODE_DISPLAY_NAME
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@codeSystem')::STRING AS PROCEDURE_SECTION_CODE_SYSTEM
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@codeSystemName')::STRING AS PROCEDURE_SECTION_CODE_SYSTEM_NAME
       --
       -- NOTE second "templateId" skipped AS it looks like repeat of first
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@code')::STRING AS PROCEDURE_CODE
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'@displayName')::STRING AS PROCEDURE_DISPLAY_NAME 
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'code'),'originalText'),'reference'),'@value')::STRING AS PROCEDURE_REFERENCE_VALUE     
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'statusCode'),'@code')::STRING AS PROCEDURE_STATUS
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'effectiveTime'),'low'),'@value')::STRING AS PROCEDURE_DATE
       ,GET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),'@typeCode')::STRING AS PERFORMER_TYPE_CODE
       ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),'assignedEntity'),'@classCode')::STRING AS ENTITY_CLASS_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),'assignedEntity'),'id'),'@extension')::STRING AS ASSIGNED_PERSON_NPI 
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),'assignedEntity'),'id'),'@root')::STRING AS ENTITY_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),'assignedEntity'),'addr'),'@nullFlavor')::STRING AS ENTITY_NULL_FLAVOR
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'telecom'),'@nullFlavor')::STRING AS TELECOM_NULL_FLAVOR
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'telecom'),'@value')::STRING AS TELEPHONE_NUMBER
        --
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'telecom'),'@use')::STRING AS TELEPHONE_USE

        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'assignedPerson'),'@classCode')::STRING AS assign_person_class_code-- assignedPerson classCode
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'assignedPerson'),'@determinerCode')::STRING AS determiner_code -- determinerCode-26
      ,CASE
       WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::STRING IS NULL
       THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'), 'assignedEntity'),'assignedPerson'),'name'):"$"::STRING
       ELSE
	       CONCAT ( 
               nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::STRING,''), ', ',           
               nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                       'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::STRING, ''), ' ',
               --
               nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                       'assignedEntity'),'assignedPerson'),'name'),'given',1):"$"::STRING, ''), ' ',

               nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'assignedPerson'),'name'),'suffix'):"$"::STRING,'')
           )
       END AS ASSIGNED_NAME
       
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'id'),'@extension')::STRING AS REP_ORG_EXT
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'id'),'@root')::STRING AS REP_ORG_ROOT
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'name'):"$"::STRING AS REP_ORG_NAME
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'telecom'),'@use')::STRING AS REP_ORG_PHONE_USE
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'telecom'),'@value')::STRING AS REP_ORG_PHONE_NUMBER
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'@use')::STRING AS REP_ORG_ADDR_USE
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS REP_ORG_ADDRESS
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'city'):"$"::STRING AS REP_ORG_CITY
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'state'):"$"::STRING AS REP_ORG_STATE
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS REP_ORG_ZIP
        ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'performer'),
                   'assignedEntity'),'representedOrganization'),'addr'),'country'):"$"::STRING AS REP_ORG_COUNTRY
        --
        ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'templateId'),'@root')::STRING AS AUTHOR_TEMPL_ID_ROOT
        ,GET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS AUTHOR_AA_ID_ROOT
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS AUTHOR_AA_ID_EXT
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS AUTHOR_AA_CODE
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'code'),'@displayName')::STRING AS AUTHOR_AA_DISP_NAME
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS AUTHOR_AA_CODE_SYSTEM
        ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'code'),'@codeSystemName')::STRING AS AUTHOR_AA_CODE_SYSTEM_NAME
        ,CONCAT ( 
               CASE                
               WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING  IS NULL  
               THEN 
                    ''
               ELSE
                    CONCAT (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ')
               END,
               --
               CASE                
               WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING  IS NULL  
               THEN 
                    ''
               ELSE
                    CONCAT (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ', ')
               END,
               --
               CASE                
               WHEN (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING) IS NULL  
               THEN 
                    ''
               ELSE
                     NVL(CONCAT((XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING), ' '),' ')
               END,
               nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'procedure'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING,'')
           ) as AUTHOR_AA_AP_NAME
        ,ROW_NUM AS XML_ROW_NUMBER
	    ,TS_LAST_MODIFY AS XML_TS_LAST_MODIFY
	    ,SCAN_TIME AS XML_TS_SCAN_TIME
FROM QUALITY.SECTION_XML
     ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
WHERE SECTION_TITLE  = 'Procedures'
AND F.VALUE LIKE '%entry%';
