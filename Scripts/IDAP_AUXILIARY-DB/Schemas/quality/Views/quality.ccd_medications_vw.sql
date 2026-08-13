CREATE OR REPLACE VIEW QUALITY.CCD_MEDICATIONS_VW(
	MRN,
	SECTION_TITLE,
	FILENAME,
	SECTION_TYPE_CODE,
	SECTION_DISPLAY_NAME,
	SECTION_CODE_SYSTEM,
	SECTION_CODE_SYSTEM_NAME,
	ENTRY_TYPE_CODE,
	SA_CLASS_CODE,
	SA_MOOD_CODE,
	TEMPLATE_ID_ROOT,
	TEMPLATE_ID_EXT,
	SA_FIELD_INDEX,
	SA_STATUS_CODE,
	SA_DATE_TYPE,
	SA_DATE,
	SA_ROUTE_CODE,
	SA_ROUTE_DISPLAY,
	SA_ROUTE_CODE_SYSTEM,
	SA_ROUTE_CODE_SYSTEM_NAME,
	MP_CLASS_CODE,
	MFG_PROD_TEMPL_ROOT,
	MFG_PROD_TEMPL_EXT,
	MFG_MAT_CODE,
	MFG_MAT_DISPLAY,
	MFG_MAT_CODE_SYSTEM,
	MFG_MAT_CODE_SYSTEM_NAME,
	NDC_CODE,
	NDC_NAME,
	NDC_CODE_SYSTEM,
	NDC_CODE_SYSTEM_NAME,
	MED_DDI_CODE,
	MED_DDI_NAME,
	MED_DDI_CODE_SYSTEM,
	MED_DDI_CODE_SYSTEM_NAME,
	GPI_CODE,
	GPI_NAME,
	GPI_CODE_SYSTEM,
	GPI_CODE_SYSTEM_NAME,
	AA_EXT,
	AA_ROOT,
	AA_CODE,
	AA_CODE_SYS,
	AA_SYS_NAME,
	AA_SYS_DISPLAY,
	ASSIGNED_PERSON_NAME,
	ER_TYPE_CODE,
	ER_INVERSION_IND,
	ER_OBS_CLASS_CODE,
	ER_OBS_MOOD_CODE,
	ER_OBS_TEMPL_ID_ROOT,
	ER_OBS_TEMPL_ID_EXT,
	OBS_NULL_FLAVOR,
	OBS_CODE,
	OBS_NAME,
	OBS_CODE_SYSTEM,
	OBS_CODE_SYSTEM_NAME,
	OBS_STATUS_CODE,
	OBS_EFF_TIME_NULL_FLAVOR,
	OBS_VALUE_XSI_TYPE,
	OBS_VALUE_NULL_FLAVOR,
	OBS_VALUE_CODE_SYSTEM,
	OBSERVATION_TRANSLATION_CODE,
	OBS_VALUE_XLATE_DISPLAY,
	OBS_VLAUE_XLATE_CODE_SYSTEM,
	OBS_VALUE_XLATE_CODE_SYSTEM_NAME,
	ER_ACT_CLASS_CODE,
	ER_ACT_MOOD_CODE,
	ACT_TEMPL_ID_ROOT,
	ACT_TEMPL_ID_EXT,
	ACT_CODE,
	ACT_DISP_NAME,
	ACT_CODE_SYSTEM,
	ACT_C0DE_SYSTEM_NAME,
	ACT_TEXT_REF_VALUE,
	ACT_STATUS_CODE,
	ER_SUPPLY_CLASS_CODE,
	ER_SUPPLY_MOOD_CODE,
	SUPPLY_TEMPL_ID_ROOT,
	SUPPLY_TEMPL_ID_EXT,
	SUPPLY_ID_ROOT,
	SUPPLY_ID_EXT,
	SUPPLY_STATUS_CODE,
	SUPPLY_DATE,
	SUPPLY_REPEAT,
	SUPPLY_QTY,
	SUPPLY_QTY_UNIT,
	SUPPLY_CLASS_CODE,
	SUPPLY_ROOT,
	SUPPLY_EXT,
	SUP_MATERIAL_CODE,
	SUP_MATERIAL_NAME,
	SUP_MATERIAL_CODE_SYSTEM,
	SUP_MATERIAL_CODE_SYSEM_NAME,
	PROD_CODE_GPI,
	PROD_NAME_GPI,
	PROD_SYS_GPI,
	PROD_SYS_NAME_GPI,
	PROD_CODE_NDC,
	PROD_NAME_NDC,
	PROD_SYS_NDC,
	PROD_SYS_NAME_NDC,
	SUPPLY_TIME_VALUE,
	SUPPLY_AUTHOR_ID_ROOT,
	SUPPLY_AUTHOR_ID_EXT,
	SUPPLY_AUTHOR_ADDR_STREET,
	SUPPLY_AUTHOR_ADDR_CITY,
	SUPPLY_AUTHOR_ADDR_STATE,
	SUPPLY_AUTHOR_ADDR_ZIP,
	SUPPLY_AUTHOR_ADDR_COUNTRY,
	SUPPLY_AUTHOR_PHONE_NUM,
	PERSON_NAME,
	XML_ROW_NUMBER,
	XML_TS_LAST_MODIFY,
	XML_TS_SCAN_TIME
) as
SELECT 
       MRN
      ,SECTION_TITLE
      ,FILENAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_TYPE_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS SECTION_DISPLAY_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS SECTION_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS SECTION_CODE_SYSTEM_NAME
      ,GET(F.VALUE,'@typeCode')::STRING AS ENTRY_TYPE_CODE
      ,GET(XMLGET( F.VALUE, 'substanceAdministration'), '@classCode')::STRING AS SA_CLASS_CODE
      ,GET(XMLGET( F.VALUE, 'substanceAdministration'), '@moodCode')::STRING AS SA_MOOD_CODE
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'id'),'@root')::STRING AS TEMPLATE_ID_ROOT
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'id'),'@extension')::STRING AS TEMPLATE_ID_EXT
      ,sa.index as SA_FIELD_INDEX      
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'statusCode'),'@code')::STRING AS SA_STATUS_CODE
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'effectiveTime'),'@xsi:type')::STRING AS SA_DATE_TYPE
      ,NVL(GET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'effectiveTime'),'low'),'@value')::STRING,'0') AS SA_DATE
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'routeCode'),'@code')::STRING AS SA_ROUTE_CODE
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'routeCode'),'@displayName')::STRING AS SA_ROUTE_DISPLAY
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'routeCode'),'@codeSystem')::STRING AS SA_ROUTE_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'routeCode'),'@codeSystemName')::STRING AS SA_ROUTE_CODE_SYSTEM_NAME
      -- <doseQuantity /> looks to be blank 
      ,GET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),'@classCode')::STRING AS MP_CLASS_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'templateId'),'@root')::STRING AS MFG_PROD_TEMPL_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'templateId'),'@extension')::STRING AS MFG_PROD_TEMPL_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'@code')::STRING AS MFG_MAT_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'@displayName')::STRING AS MFG_MAT_DISPLAY
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'@codeSystem')::STRING AS MFG_MAT_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'@codeSystemName')::STRING AS MFG_MAT_CODE_SYSTEM_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation'),'@code')::STRING AS NDC_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation'),'@displayName')::STRING AS NDC_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation'),'@codeSystem')::STRING AS NDC_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation'),'@codeSystemName')::STRING AS NDC_CODE_SYSTEM_NAME
       -- ARRAY-INDEX 1
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',1),'@code')::STRING AS MED_DDI_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',1),'@displayName')::STRING AS MED_DDI_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'), 
                 'manufacturedMaterial'),'code'),'translation',1),'@codeSystem')::STRING AS MED_DDI_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',1),'@codeSystemName')::STRING AS MED_DDI_CODE_SYSTEM_NAME
       -- ARRAY-INDEX 2
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',2),'@code')::STRING AS GPI_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',2),'@displayName')::STRING AS GPI_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'), 
                 'manufacturedMaterial'),'code'),'translation',2),'@codeSystem')::STRING AS GPI_CODE_SYSTEM
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(F.VALUE, 'substanceAdministration'),'consumable'),'manufacturedProduct'),
                 'manufacturedMaterial'),'code'),'translation',2),'@codeSystemName')::STRING AS GPI_CODE_SYSTEM_NAME
       -- Author
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS AA_EXT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS AA_ROOT
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'code'),'@code')::STRING AS AA_CODE
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'code'),'@codeSystem')::STRING AS AA_CODE_SYS
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),
                 'code'),'@codeSystemName')::STRING AS AA_SYS_NAME
      ,GET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),
                 'code'),'@displayName')::STRING AS AA_SYS_DISPLAY
      ,CASE
       WHEN (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'), 'name'),'family'):"$"::STRING) IS NULL
       THEN (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING )
       ELSE 
          CONCAT(
            nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'), 'name'),'family'):"$"::STRING,''), ', ',		  
	        nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given', 0):"$"::STRING,''), ' ',
            nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given', 1):"$"::STRING,''), ' ',
            nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING,''), ''
            -- nvl(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( F.VALUE, 'substanceAdministration'),'author'),'assignedAuthor'),
            --     'assignedPerson'),'name'),'suffix'),'@qualifier')::STRING,'' )
           ) 
        END AS ASSIGNED_PERSON_NAME
       ,GET( SA.VALUE, '@typeCode')::STRING AS ER_TYPE_CODE
       ,GET( SA.VALUE, '@inversionInd')::STRING AS ER_INVERSION_IND
       -- observation
       ,GET(XMLGET(SA.VALUE,'observation'),'@classCode')::STRING AS ER_OBS_CLASS_CODE
       ,GET(XMLGET(SA.VALUE,'observation'),'@moodCode')::STRING AS ER_OBS_MOOD_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'templateId'), '@root')::STRING AS ER_OBS_TEMPL_ID_ROOT
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'templateId'), '@extension')::STRING AS ER_OBS_TEMPL_ID_EXT
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'id'), '@nullFlavor')::STRING AS OBS_NULL_FLAVOR
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'code'), '@code')::STRING AS OBS_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'code'), '@displayName')::STRING AS OBS_NAME
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'code'), '@codeSystem')::STRING AS OBS_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'code'), '@codeSystemName')::STRING AS OBS_CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'statusCode'), '@code')::STRING AS OBS_STATUS_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'effectiveTime'), '@nullFlavor')::STRING AS OBS_EFF_TIME_NULL_FLAVOR
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'), '@xsi:type')::STRING AS OBS_VALUE_XSI_TYPE
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'), '@nullFlavor')::STRING AS OBS_VALUE_NULL_FLAVOR
       ,GET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'), '@codeSystem')::STRING AS OBS_VALUE_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'),'translation'), '@code')::STRING as OBSERVATION_TRANSLATION_CODE           
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'),'translation'), '@displayName')::STRING AS OBS_VALUE_XLATE_DISPLAY
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'),'translation'), '@codeSystem')::STRING AS OBS_VALUE_XLATE_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE,'observation'),'value'),'translation'), '@codeSystemName')::STRING AS OBS_VALUE_XLATE_CODE_SYSTEM_NAME
       -- act
       ,GET(XMLGET(SA.VALUE, 'act'),'@classCode')::STRING AS ER_ACT_CLASS_CODE
       ,GET(XMLGET(SA.VALUE, 'act'),'@moodCode')::STRING AS ER_ACT_MOOD_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'templateId'),'@root')::STRING AS ACT_TEMPL_ID_ROOT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'templateId'),'@extension')::STRING AS ACT_TEMPL_ID_EXT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'code'),'@code')::STRING AS ACT_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'code'),'@displayName')::STRING AS ACT_DISP_NAME
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'code'),'@codeSystem')::STRING AS ACT_CODE_SYSTEM
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'code'),'@codeSystemName')::STRING AS ACT_CODE_SYSTEM_NAME
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'act'),'text'),'reference'),'@value')::STRING AS ACT_TEXT_REF_VALUE
       ,GET(XMLGET(XMLGET(SA.VALUE, 'act'),'statusCode'),'@code')::STRING AS ACT_STATUS_CODE
       -- supply
       ,GET(XMLGET(SA.VALUE, 'supply'),'@classCode')::STRING AS ER_SUPPLY_CLASS_CODE
       ,GET(XMLGET(SA.VALUE, 'supply'),'@moodCode')::STRING AS ER_SUPPLY_MOOD_CODE
       ,GET(XMLGET(XMLGET(SA.VALUE, 'supply'),'templateId'),'@root')::STRING AS SUPPLY_TEMPL_ID_ROOT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'supply'),'templateId'),'@extension')::STRING AS SUPPLY_TEMPL_ID_EXT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'supply'),'id'),'@root')::STRING AS SUPPLY_ID_ROOT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'supply'),'id'),'@extension')::STRING AS SUPPLY_ID_EXT
       ,GET(XMLGET(XMLGET(SA.VALUE, 'supply'),'statusCode'),'@code')::STRING AS SUPPLY_STATUS_CODE
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'effectiveTime'),'high'),'@value')::STRING AS SUPPLY_DATE
       ,GET(XMLGET(XMLGET(SA.VALUE,'supply'),'repeatNumber'),'@value')::STRING AS SUPPLY_REPEAT
       ,GET(XMLGET(XMLGET(SA.VALUE,'supply'),'quantity'),'@value')::STRING AS SUPPLY_QTY
       ,GET(XMLGET(XMLGET(SA.VALUE,'supply'),'quantity'),'@unit')::STRING AS SUPPLY_QTY_UNIT
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'@classCode')::STRING AS SUPPLY_CLASS_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'templateId'),'@root')::STRING AS SUPPLY_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'templateId'),'@extension')::STRING AS SUPPLY_EXT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@code')::STRING AS SUP_MATERIAL_CODE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@displayName')::STRING AS SUP_MATERIAL_NAME
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@codeSystem')::STRING AS SUP_MATERIAL_CODE_SYSTEM 
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'@codeSystemName')::STRING AS SUP_MATERIAL_CODE_SYSTEM_NAME
       -- INDEX ZERO
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',0),'@code')::STRING AS PROD_CODE_GPI
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',0),'@displayName')::STRING AS PROD_NAME_GPI
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',0),'@codeSystem')::STRING AS PROD_SYS_GPI
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',0),'@codeSystemName')::STRING AS PROD_SYS_NAME_GPI
       -- INDEX ONE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',1),'@code')::STRING AS PROD_CODE_NDC
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',1),'@displayName')::STRING AS PROD_NAME_NDC
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',1),'@codeSystem')::STRING AS PROD_SYS_NDC
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'product'),'manufacturedProduct'),'manufacturedMaterial'),
                         'code'),'translation',1),'@codeSystemName')::STRING AS PROD_SYS_NAME_NDC
       ,GET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'time'),'@value')::STRING AS SUPPLY_TIME_VALUE
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'id'),'@root')::STRING AS SUPPLY_AUTHOR_ID_ROOT
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'id'),'@extension')::STRING AS SUPPLY_AUTHOR_ID_EXT
       ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'addr'),'streetAddressLine'):"$"::STRING AS SUPPLY_AUTHOR_ADDR_STREET
       ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'addr'),'city'):"$"::STRING AS SUPPLY_AUTHOR_ADDR_CITY
       ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'addr'),'state'):"$"::STRING AS SUPPLY_AUTHOR_ADDR_STATE
       ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'addr'),'postalCode'):"$"::STRING AS SUPPLY_AUTHOR_ADDR_ZIP
       ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'addr'),'country'):"$"::STRING AS SUPPLY_AUTHOR_ADDR_COUNTRY
       ,GET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'telecom'),'@value')::STRING AS SUPPLY_AUTHOR_PHONE_NUM
      ,CASE
       WHEN 
            (XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING) IS NULL
       THEN 
            XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'):"$"::STRING
       ELSE  
            CONCAT (
                nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING,''), ', ',			
	            nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',0):"$"::STRING,''), ' ',
	            nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given',1):"$"::STRING,''), ' ',                
                nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING,''), ' '
                -- nvl( GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(SA.VALUE, 'supply'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'),'@qualifier')::STRING,'') 
           ) 
       END AS PERSON_NAME      
       ,ROW_NUM
	   ,TS_LAST_MODIFY
	   ,SCAN_TIME                  
FROM QUALITY.SECTION_XML X
     ,LATERAL FLATTEN(XMLGET(xml, 'section'):"$") F
     ,LATERAL FLATTEN(XMLGET(F.VALUE, 'substanceAdministration'):"$") SA
WHERE SECTION_TITLE = 'Medications'
AND F.VALUE LIKE'%entry%'
AND SA.VALUE LIKE '%entryRelationship%';