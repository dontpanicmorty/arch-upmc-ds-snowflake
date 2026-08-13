CREATE OR REPLACE VIEW QUALITY.CCD_MEDS_IN_OFFICE_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	SECTION_DATE,
	SECTION_CODE,
	SECTION_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	SUB_ADMIN_CLASS_CODE,
	SUB_ADMIN_MOOD_CODE,
	TEMPLATE_EXT,
	SUB_ADMIN_ID_ROOT,
	SUB_ADMIN_ID_EXT,
	STATUS_CODE,
	EFFECTIVE_TIME_TYPE,
	EFFECTIVE_TIME_LOW,
	EFFECTIVE_TIME_HIGH,
	ROUTE_CODE,
	ROUTE_CODE_NULL_FLAVOR,
	MANUF_PROD_CLASS_CODE,
	MANUF_PROD_TEMPL_EXT,
	MANUF_MATERIAL_CODE,
	MANUF_MATERIAL_NULL_FLAVOR,
	MANUF_MATERIAL_NAME,
	AUTHOR_TIME,
	ASSIGNED_AUTHOR_ID_ROOT,
	ASSIGNED_AUTHOR_ID_EXT,
	ASSIGNED_AUTHOR_CODE,
	ASSIGNED_AUTHOR_CODE_NULL_FLAVOR,
	ASSIGNED_PERSON_NAME,
	ER_TYPE_CODE,
	ER_INVERSION_IND,
	ER_ACT_CLASS_CODE,
	ER_ACT_MOOD_CODE,
	ER_ACT_TEMPLATE_EXT,
	ER_ACT_CODE,
	ER_ACT_CODE_NAME,
	ER_ACT_CODE_SYSTEM,
	ER_ACT_CODE_SYSTEM_NAME,
	ER_ACT_REF_VALUE,
	ER_ACT_STATUS_CODE,
	ER_SUPPLY_CLASS_CODE,
	ER_SUPPLY_MOOD_CODE,
	ER_SUPPLY_TEMPLATE_EXT,
	ER_SUPPLY_ID_ROOT,
	ER_SUPPLY_ID_EXT,
	ER_SUPPLY_STATUS_CODE,
	ER_SUPPLY_EFFECTIVE_TIME_TYPE,
	ER_SUPPLY_EFFECTIVE_TIME,
	ER_SUPPLY_REPEAT_NUM,
	ER_SUPPLY_QUANTITY_NULL,
	ER_SUPPLY_MFG_PROD_CLASS_CODE,
	ER_SUPPLY_MFG_PROD_TEMPLATE_ID,
	ER_SUPPLY_MFG_PROD_TEMPLATE_EXT,
	ER_SUPPLY_MFG_MATERIAL_CODE,
	ER_SUPPLY_MFG_MATERIAL_CODE_NULL,
	ER_SUPPLY_MFG_MATERIAL_NAME,
	ER_SUPPLY_AUTHOR_TIME,
	ER_SUPPLY_AUTHOR_ASSIGNED_ID_ROOT,
	ER_SUPPLY_AUTHOR_ASSIGNED_ID_EXT,
	ER_SUPPLY_AUTHOR_STREET_ADDRESS,
	ER_SUPPLY_AUTHOR_CITY,
	ER_SUPPLY_AUTHOR_STATE,
	ER_SUPPLY_AUTHOR_ZIP_CODE,
	ER_SUPPLY_AUTHOR_COUNTRY,
	ER_SUPPLY_AUTHOR_TELEPHONE,
	ER_SUPPLY_ASSIGNED_NAME,
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
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM                  
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING as SECTION_CODE_SYSTEM_NAME
      ,GET( F.VALUE,'@typeCode')::STRING as ENTRY_TYPE_CODE      
      ,GET(XMLGET(F.VALUE,'substanceAdministration'),'@classCode')::STRING as SUB_ADMIN_CLASS_CODE
      ,GET(XMLGET(F.VALUE,'substanceAdministration'),'@moodCode')::STRING as SUB_ADMIN_MOOD_CODE      
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'templateId'),'@extension')::STRING as TEMPLATE_EXT      
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'id'),'@root')::STRING as SUB_ADMIN_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'id'),'@extension')::STRING as SUB_ADMIN_ID_ext
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'statusCode'),'@code')::STRING as STATUS_CODE      
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'effectiveTime'),'@xsi:type')::STRING as EFFECTIVE_TIME_TYPE      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'effectiveTime'),'low'),'@value')::STRING as EFFECTIVE_TIME_LOW      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'effectiveTime'),'high'),'@value')::STRING as EFFECTIVE_TIME_HIGH      
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'),'@value')::STRING as ROUTE_CODE      
      ,GET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'routeCode'),'@nullFlavor')::STRING as ROUTE_CODE_NULL_FLAVOR      
      -- <doseQuantity> - looks to be null      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'@classCode')::STRING as MANUF_PROD_CLASS_CODE            
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'templateId'),'@extension')::STRING as MANUF_PROD_TEMPL_EXT      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@code')::STRING as MANUF_MATERIAL_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@nullFlavor')::STRING as MANUF_MATERIAL_NULL_FLAVOR      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@displayName')::STRING as MANUF_MATERIAL_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'time'),'@value')::STRING as AUTHOR_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'id'),'@root')::STRING as ASSIGNED_AUTHOR_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'id'),'@extension')::STRING as ASSIGNED_AUTHOR_ID_EXT      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'code'),'@code')::STRING as ASSIGNED_AUTHOR_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'code'),'@nullFlavor')::STRING as ASSIGNED_AUTHOR_CODE_NULL_FLAVOR      
      ,CONCAT(
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING 
           ) AS ASSIGNED_PERSON_NAME
      ,GET(ER.VALUE,'@typeCode')::STRING as ER_TYPE_CODE
      ,GET(ER.VALUE,'@inversionInd')::STRING as ER_INVERSION_IND
      ,GET(XMLGET(ER.VALUE,'act'),'@classCode')::STRING as ER_ACT_CLASS_CODE
      ,GET(XMLGET(ER.VALUE,'act'),'@moodCode')::STRING as ER_ACT_MOOD_CODE      
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'templateId'),'@extension')::STRING as ER_ACT_TEMPLATE_EXT
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'code'),'@code')::STRING as ER_ACT_CODE
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'code'),'@displayName')::STRING as ER_ACT_CODE_NAME      
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'code'),'@codeSystem')::STRING as ER_ACT_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'code'),'@codeSystemName')::STRING as ER_ACT_CODE_SYSTEM_NAME      
      ,GET(XMLGET(XMLGET(XMLGET(ER.VALUE,'act'),'text'),'reference'),'@value')::STRING as ER_ACT_REF_VALUE
      ,GET(XMLGET(XMLGET(ER.VALUE,'act'),'statusCode'),'@code')::STRING as ER_ACT_STATUS_CODE      
      ,GET(XMLGET(ER.VALUE,'supply'),'@classCode')::STRING as ER_SUPPLY_CLASS_CODE
      ,GET(XMLGET(ER.VALUE,'supply'),'@moodCode')::STRING as ER_SUPPLY_MOOD_CODE      
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'templateId'),'@extension')::STRING as ER_SUPPLY_TEMPLATE_EXT      
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'id'),'@root')::STRING as ER_SUPPLY_ID_ROOT      
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'id'),'@extension')::STRING as ER_SUPPLY_ID_EXT      
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'statusCode'),'@code')::STRING as ER_SUPPLY_STATUS_CODE      
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'effectiveTime'),'@xsi:type')::STRING as ER_SUPPLY_EFFECTIVE_TIME_TYPE
      ,GET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'effectiveTime'),'high'),'@value')::STRING as ER_SUPPLY_EFFECTIVE_TIME
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'repeatNumber'),'@value')::STRING as ER_SUPPLY_REPEAT_NUM
      ,GET(XMLGET(XMLGET(ER.VALUE,'supply'),'quantity'),'@nullFlavor')::STRING as ER_SUPPLY_QUANTITY_NULL
      ,GET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'@classCode')::STRING as ER_SUPPLY_MFG_PROD_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'templateId'),'@root')::STRING as ER_SUPPLY_MFG_PROD_TEMPLATE_ID      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'templateId'),'@extension')::STRING as ER_SUPPLY_MFG_PROD_TEMPLATE_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@code')::STRING as ER_SUPPLY_MFG_MATERIAL_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@nullFlavor')::STRING as ER_SUPPLY_MFG_MATERIAL_CODE_NULL            
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@displayName')::STRING as ER_SUPPLY_MFG_MATERIAL_NAME
      ,GET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'time'),'@value')::STRING as ER_SUPPLY_AUTHOR_TIME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'id'),'@root')::STRING as ER_SUPPLY_AUTHOR_ASSIGNED_ID_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'id'),'@extension')::STRING as ER_SUPPLY_AUTHOR_ASSIGNED_ID_EXT      
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'addr'),'streetAddressLine'):"$"::STRING as ER_SUPPLY_AUTHOR_STREET_ADDRESS
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'addr'),'city'):"$"::STRING as ER_SUPPLY_AUTHOR_CITY      
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'addr'),'state'):"$"::STRING as ER_SUPPLY_AUTHOR_STATE      
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'addr'),'postalCode'):"$"::STRING as ER_SUPPLY_AUTHOR_ZIP_CODE      
      ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'addr'),'country'):"$"::STRING as ER_SUPPLY_AUTHOR_COUNTRY      
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'telecom'),'@value')::STRING as ER_SUPPLY_AUTHOR_TELEPHONE      
      ,CONCAT(
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ER.VALUE,'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING           
      ) AS ER_SUPPLY_ASSIGNED_NAME
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME       
FROM QUALITY.SECTION_XML X
    ,LATERAL FLATTEN(XMLGET(X.XML, 'section'):"$") F
    ,LATERAL FLATTEN(XMLGET(F.VALUE, 'substanceAdministration'):"$") ER        
WHERE SECTION_TITLE = 'Medications Administered in Office'
AND F.VALUE LIKE '%entry%'
AND ER.VALUE LIKE '%entryRelationship%';