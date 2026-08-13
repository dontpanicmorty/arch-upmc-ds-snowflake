CREATE OR REPLACE VIEW QUALITY.CCD_IMMUNIZATIONS_VW(
	SECTION_TITLE,
	IMMUNIZATION_DATE,
	IMMUNIZATION_CODE,
	CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	DISPLAY_NAME,
	MOOD_CODE,
	STATUS_CODE,
	FILENAME,
	MRN,
	SECTION_TEMPLATE_ID_EXTENSION_A,
	SECTION_TEMPLATE_ID_ROOT_A,
	SECTION_TEMPLATE_ID_ROOT_B,
	ROUTE_CODE,
	ROUTE_CODE_SYSTEM,
	ROUTE_CODE_SYSTEM_NAME,
	ROUTE_CODE_DISPLAY_NAME,
	APPROACH_SITE_CODE,
	APPROACH_SITE_CODE_SYSTEM,
	APPROACH_SITE_CODE_SYSTEM_NAME,
	APPROACH_SITE_CODE_DISPLAY_NAME,
	SECTION_TYPE_CODE,
	SECTION_DISPLAY_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	SA_CLASS_CODE,
	SA_NEGATION_IND,
	ENTRY_SA_TEMPLATE_ID_EXTENSION_A,
	ENTRY_SA_TEMPLATE_ID_ROOT_A,
	ENTRY_SA_TEMPLATE_ID_ROOT_B,
	SA_ID_ROOT,
	SA_ID_EXT,
	DOSE_NULL_FLAVOR,
	DOSE_VALUE,
	DOSE_UNIT,
	MP_CLASS_CODE,
	MP_ROOT,
	MP_TEMPLATE_ID_ROOT_B,
	MP_EXT,
	MP_MM_NAME,
	MM_TRANSLATION_CODE,
	MP_XLATION_CODE_SYS_NAME,
	LOT_NULL_FLAVOR,
	LOT_NUMBER,
	MANUFACTURER,
	PERFORMER_TYPE_CODE,
	AE_ID_EXT,
	AE_ID_ROOT,
	AE_ADDR_NULL,
	AE_TELECOM_NULL,
	PERSON_NAME,
	REP_ORGANIZATION_ID_EXT,
	REP_ORGANIZATION_ID_ROOT,
	REP_ORGANIZATION_NAME,
	REP_ORGANIZATION_TEL_USE,
	REP_ORGANIZATION_TELEPHONE,
	REP_ORGANIZATION_ADDR_USE,
	REP_ORGANIZATION_STREET_ADDRESS,
	REP_ORGANIZATION_CITY,
	REP_ORGANIZATION_STATE,
	REP_ORGANIZATION_ZIPCODE,
	REP_ORGANIZATION_COUNTRY,
	AUTHOR_TEMPLATE_ID_ROOT,
	AUTHOR_TIME,
	AUTHOR_EXT,
	AUTHOR_NULL_FLAVOR,
	ASSIGN_PERSON_NAME,
	ER_TYPE_CODE,
	ER_INVERSION_IND,
	ER_CLASS_CODE,
	ER_MOOD_CODE,
	ER_TEMPLATE_ID_ROOT,
	ER_ROOT_EXT,
	ER_ID_ROOT,
	ER_CODE,
	ER_DISPLAY_NAME,
	ER_CODE_SYSTEM_NAME,
	ER_CODE_SYSTEM,
	ER_STATUS_CODE,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME
) as
SELECT X.SECTION_TITLE AS SECTION_TITLE

      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'effectiveTime'), '@value')::STRING AS IMMUNIZATION_DATE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                        'manufacturedMaterial'),'code'),'@code')::STRING AS IMMUNIZATION_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                        'manufacturedMaterial'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                         'manufacturedMaterial'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME                        
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                         'manufacturedMaterial'),'code'),'translation'),'@displayName')::STRING AS DISPLAY_NAME                         
      ,GET(XMLGET(F.VALUE,'substanceAdministration'),'@moodCode')::STRING AS MOOD_CODE                               
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'statusCode'), '@code')::STRING AS STATUS_CODE
      ,X.FILENAME
      ,X.MRN
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS SECTION_TEMPLATE_ID_EXTENSION_A
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS SECTION_TEMPLATE_ID_ROOT_A
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING AS SECTION_TEMPLATE_ID_ROOT_B
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'), '@code')::STRING AS ROUTE_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'), '@codeSystem')::STRING AS ROUTE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'), '@codeSystemName')::STRING AS ROUTE_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'), '@displayName')::STRING AS ROUTE_CODE_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'approachSiteCode'), '@code')::STRING AS APPROACH_SITE_CODE
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'approachSiteCode'), '@codeSystem')::STRING AS APPROACH_SITE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'approachSiteCode'), '@codeSystemName')::STRING APPROACH_SITE_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'approachSiteCode'), '@displayName')::STRING APPROACH_SITE_CODE_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_TYPE_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS SECTION_CODE_SYSTEM_NAME
      ,GET(F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
      ,GET(XMLGET(F.VALUE,'substanceAdministration'),'@classCode')::STRING AS SA_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'substanceAdministration'),'@negationInd')::STRING AS SA_NEGATION_IND
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'templateId'),'@extension')::STRING AS ENTRY_SA_TEMPLATE_ID_EXTENSION_A
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'templateId'),'@root')::STRING AS ENTRY_SA_TEMPLATE_ID_ROOT_A
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'templateId',1),'@root')::STRING AS ENTRY_SA_TEMPLATE_ID_ROOT_B
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'id'), '@root')::STRING AS SA_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'id'), '@extension')::STRING AS SA_ID_EXT            
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'doseQuantity'), '@nullFlavor')::STRING AS DOSE_NULL_FLAVOR
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'doseQuantity'), '@value')::STRING AS DOSE_VALUE	  
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'doseQuantity'), '@unit')::STRING AS DOSE_UNIT
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),'@classCode')::STRING AS MP_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),'templateId'),
              '@root')::STRING AS MP_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),'templateId',1),
              '@root')::STRING AS MP_TEMPLATE_ID_ROOT_B
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),'templateId'),
              '@extension')::STRING AS MP_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),'manufacturedMaterial'),
                    'code'),'@displayName')::STRING AS MP_MM_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                    'manufacturedMaterial'),'code'),'translation'),'@code')::STRING AS MM_TRANSLATION_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                    'manufacturedMaterial'),'code'),'translation'),'@codeSystemName')::STRING AS MM_XLATION_CODE_SYS_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                    'manufacturedMaterial'),'lotNumberText'),'@nullFlavor')::STRING AS LOT_NULL_FLAVOR
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                                                                        'manufacturedMaterial'),'lotNumberText'):"$"::STRING AS LOT_NUMBER
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'), 'manufacturedProduct'),
                                                                        'manufacturerOrganization'),'name'):"$"::STRING AS MANUFACTURER
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), '@typeCode')::STRING AS PERFORMER_TYPE_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'id'),'@extension')::STRING AS AE_ID_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'id'),'@root')::STRING AS AE_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),
                    'addr'),'@nullFlavor')::STRING AS AE_ADDR_NULL
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),
                    'telecom'),'@nullFlavor')::STRING AS AE_TELECOM_NULL
      ,CASE
        WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::STRING IS NULL
        THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'):"$"::STRING
        ELSE
	        CONCAT(
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
                NVL( XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ', 
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),
                         'suffix'):"$"::STRING, ' '
                --GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'assignedPerson'),'name'),
                --         'suffix'),'@qualifier')::STRING
               )           
        END AS PERSON_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'id'),'@extension')::STRING AS REP_ORGANIZATION_ID_EXT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'id'),'@root')::STRING AS REP_ORGANIZATION_ID_ROOT
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'name'):"$"::STRING AS REP_ORGANIZATION_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'telecom'),'@use')::STRING AS REP_ORGANIZATION_TEL_USE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'telecom'),'@value')::STRING AS REP_ORGANIZATION_TELEPHONE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'@use')::STRING AS REP_ORGANIZATION_ADDR_USE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS REP_ORGANIZATION_STREET_ADDRESS
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'city'):"$"::STRING AS REP_ORGANIZATION_CITY
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'state'):"$"::STRING AS REP_ORGANIZATION_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS REP_ORGANIZATION_ZIPCODE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'performer'), 'assignedEntity'),'representedOrganization'),'addr'),'country'):"$"::STRING AS REP_ORGANIZATION_COUNTRY
    
     ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'templateId'),'@root')::STRING AS AUTHOR_TEMPLATE_ID_ROOT
     
     ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'time'),'@value')::STRING AS AUTHOR_TIME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'id'),'@extension')::STRING AS AUTHOR_EXT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'code'),'@nullFlavor')::STRING AS AUTHOR_NULL_FLAVOR
     ,CASE
        WHEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING IS NULL
        THEN XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
        ELSE
	    CONCAT (
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',                
                NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING, ''), ' ',
                XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING, ' '
                --GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'), 'assignedAuthor'),'assignedPerson'),'name'),'suffix'),'@qualifier')::STRING
		)
        END AS ASSIGN_PERSON_NAME
     ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), '@typeCode')::STRING AS ER_TYPE_CODE
     ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), '@inversionInd')::STRING AS ER_INVERSION_IND
     ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'@classCode')::STRING AS ER_CLASS_CODE
     ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'@moodCode')::STRING AS ER_MOOD_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'templateId'),
              '@root')::STRING AS ER_TEMPLATE_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'id'),'@extension')::STRING AS ER_ROOT_EXT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'id'),'@root')::STRING AS ER_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'code'),'@code')::STRING AS ER_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'code'),'@displayName')::STRING AS ER_DISPLAY_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'code'),'@codeSystemName')::STRING AS ER_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'code'),'@codeSystem')::STRING AS ER_CODE_SYSTEM
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'entryRelationship'), 'act'),'statusCode'),'@code')::STRING AS ER_STATUS_CODE
     ,ROW_NUM
     ,TS_LAST_MODIFY
     ,SCAN_TIME
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
WHERE SECTION_TITLE = 'Immunizations'
AND F.VALUE like '%entry%';
