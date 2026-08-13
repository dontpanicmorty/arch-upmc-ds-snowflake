CREATE OR REPLACE VIEW QUALITY.CCD_IMMUNIZATIONS_ATHENA_VW(
	FILENAME,
	MRN,
	SECTION_TITLE,
	TEMPLATE_ID_EXTENSION,
	TEMPLATE_ID_ROOT,
	TEMPLATE_ID_ROOT_2,
	IMMUNIZATION_CODE,
	CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	DISPLAY_NAME,
	TYPE_CODE,
	CLASS_CODE,
	MOOD_CODE,
	NEGATION_INDICATOR,
	SUBSTANCE_TEMPLATE_ID_EXTENSION,
	SUBSTANCE_TEMPLATE_ID_ROOT,
	SUBSTANCE_TEMPLATE_ID_ROOT_2,
	SUBSTANCE_ID_AUTHORITY_NAME,
	ENTRY_ID_EXTENSION,
	SUBSTANCE_ID_ROOT,
	TEXT_REF_VALUE,
	STATUS_CODE,
	EFFECTIVE_TIME,
	REPEAT_NUMBER,
	ROUTE_CODE_NULL,
	ROUTE_CODE,
	ROUTE_CODE_SYSTEM,
	ROUTE_CODE_SYSTEM_NAME,
	ROUTE_CODE_DISPLAY_NAME,
	APPROACH_SITE_CODE_NULL,
	APPROACH_SITE_CODE,
	APPROACH_SITE_CODE_SYSTEM,
	APPROACH_SITE_CODE_SYSTEM_NAME,
	APPROACH_SITE_DISPLAY_NAME,
	DOSE_QUANTITY_NULL,
	DOSE_QUANTITY_UNIT,
	DOSE_QUANTITY_VALUE,
	MFG_PRODUCT_CLASS_CODE,
	MFG_PRODUCT_TEMPLATE_ID_EXTENSION,
	MFG_PRODUCT_TEMPLATE_ID_ROOT,
	MFG_PRODUCT_TEMPLATE_ID_ROOT_2,
	MFG_MATERIAL_CODE,
	MFG_MATERIAL_CODE_SYSTEM,
	MFG_MATERIAL_CODE_SYSTEM_NAME,
	MFG_MATERIAL_CODE_DISPLAY_NAME,
	TRANSLATION_CODE,
	TRANSLATION_CODE_SYSTEM,
	TRANSLATION_CODE_SYSTEM_NAME,
	TRANSLATION_DISPLAY_NAME,
	LOT_NUMBER,
	MFG_ORGANIZATION_NAME,
	AUTHOR_TEMPLATE_ID_ROOT,
	AUTHOR_TEMPLATE_ID_ROOT_2,
	AUTHOR_TIME,
	PVID,
	PVID_OID,
	FACILITY,
	FACILITY_OID,
	NPI,
	NPI_OID,
	AUTHOR_ADDRESS_NULL,
	AUTHOR_STREET_ADDRESS_NULL,
	AUTHOR_STREET_ADDRESS,
	AUTHOR_CITY_NULL,
	AUTHOR_CITY,
	AUTHOR_STATE_NULL,
	AUTHOR_STATE,
	AUTHOR_ZIP_CODE_NULL,
	AUTHOR_ZIP_CODE,
	AUTHOR_COUNTRY_NULL,
	AUTHOR_COUNTRY,
	AUTHOR_PHONE_NULL,
	AUTHOR_PHONE_USE,
	AUTHOR_PHONE_NUMBER,
	ASSIGNED_PERSON_NAME,
	REP_ORGANIZATION_ID_NAME,
	REP_ORGANIZATION_ID_EXTENSION,
	REP_ORGANIZATION_ID_ROOT,
	REP_ORGANIZATION_NAME,
	REP_ORGANIZATION_TELECOM_USE,
	REP_ORGANIZATION_TELEPHONE_NUMBER,
	REP_ORGANIZATION_STREET_ADDRESS,
	REP_ORGANIZATION_STREET_ADDRESS_2,
	REP_ORGANIZATION_CITY,
	REP_ORGANIZATION_STATE,
	REP_ORGANIZATION_ZIP_CODE,
	XML_ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) AS
WITH AUTHOR AS (
     SELECT
           FILENAME
          ,MRN
          ,GET(XMLGET(substance_admin.value,'id'),'@extension')::STRING AS AUTHOR_ID_EXTENSION -- ENTRY_ID_EXTENSION
          ,GET(XMLGET(author.value,'templateId'),'@root')::STRING AS AUTHOR_TEMPLATE_ID_ROOT
          ,GET(XMLGET(author.value,'time'),'@value')::STRING AS AUTHOR_TIME
     
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = ' Providers by PVID' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS PVID         
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = ' Providers by PVID' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS PVID_OID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = ' Providers by DoctorFacility' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS FACILITY
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = ' Providers by DoctorFacility' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS FACILITY_OID
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' THEN ID.VALUE:"@extension"::VARCHAR ELSE NULL END) AS NPI
          ,MAX(CASE WHEN ID.VALUE:"@assigningAuthorityName"::VARCHAR = 'US National Provider Identifiers' THEN ID.VALUE:"@root"::VARCHAR ELSE NULL END) AS NPI_OID     

          FROM QUALITY.SECTION_XML X
                  ,LATERAL FLATTEN(X.XML) SECTION     
                  ,LATERAL FLATTEN(SECTION.VALUE:"$"::ARRAY) ENTRY
                  ,LATERAL FLATTEN(ENTRY.VALUE:"$"::ARRAY) SUBSTANCE_ADMIN
                  ,LATERAL FLATTEN( INPUT => SUBSTANCE_ADMIN.VALUE:"$"::ARRAY ) AUTHOR
                  ,LATERAL FLATTEN( INPUT => AUTHOR.VALUE:"$"::ARRAY ) ASSIGNED_AUTHOR
                  ,LATERAL FLATTEN( INPUT => ASSIGNED_AUTHOR.VALUE:"$"::ARRAY ) ID
             
          WHERE X.SECTION_TITLE = 'HISTORY OF IMMUNIZATIONS'
                AND GET(SECTION.VALUE, '@') = 'section'
                AND GET(ENTRY.VALUE, '@') = 'entry'
                AND GET(SUBSTANCE_ADMIN.VALUE, '@') = 'substanceAdministration'
                AND GET(AUTHOR.VALUE, '@') = 'author'
                AND GET(ASSIGNED_AUTHOR.VALUE, '@') = 'assignedAuthor'
                AND GET(ID.VALUE, '@') = 'id'
     GROUP BY  X.FILENAME
	          ,X.MRN
              ,X.SECTION_TITLE
              ,X.XML
              ,ENTRY.VALUE
              ,X.ROW_NUM
              ,X.TS_LAST_MODIFY
              ,X.SCAN_TIME
              ,AUTHOR.VALUE
              ,SUBSTANCE_ADMIN.VALUE
),
MAIN AS (
  SELECT
      X.FILENAME AS FILENAME
     ,X.MRN AS MRN
     ,SECTION_TITLE
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'id'),'@extension')::STRING AS ENTRY_ID_EXTENSION
     -- ,A.AUTHOR_ID_EXTENSION
     ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS TEMPLATE_ID_EXTENSION
     ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS TEMPLATE_ID_ROOT
     ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING AS TEMPLATE_ID_ROOT_2
     ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS IMMUNIZATION_CODE
     ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
     ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS DISPLAY_NAME
     ,GET(ENTRY.VALUE,'@typeCode')::STRING AS TYPE_CODE
     ,GET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'@classCode')::STRING AS CLASS_CODE
     ,GET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'@moodCode')::STRING AS MOOD_CODE
     ,GET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'@negationInd')::STRING AS NEGATION_INDICATOR
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'templateId'),'@extension')::STRING AS SUBSTANCE_TEMPLATE_ID_EXTENSION  
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'templateId'),'@root')::STRING AS SUBSTANCE_TEMPLATE_ID_ROOT
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'templateId',1),'@root')::STRING AS SUBSTANCE_TEMPLATE_ID_ROOT_2
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'id'),'@assigningAuthorityName')::STRING AS SUBSTANCE_ID_AUTHORITY_NAME
     -- GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'id'),'@extension')::STRING AS ENTRY_ID_EXTENSION
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'id'),'@root')::STRING AS SUBSTANCE_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'text'),'reference'),'@value')::STRING AS TEXT_REF_VALUE
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'statusCode'),'@code')::STRING AS STATUS_CODE
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'effectiveTime'),'@value')::STRING AS EFFECTIVE_TIME
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'repeatNumber'),'@value')::STRING AS REPEAT_NUMBER
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'routeCode'),'@nullFlavor')::STRING AS ROUTE_CODE_NULL     
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'routeCode'),'@code')::STRING AS ROUTE_CODE
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'routeCode'),'@codeSystem')::STRING AS ROUTE_CODE_SYSTEM
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'routeCode'),'@codeSystemName')::STRING AS ROUTE_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'routeCode'),'@displayName')::STRING AS ROUTE_CODE_DISPLAY_NAME
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'approachSiteCode'),'@nullFlavor')::STRING AS APPROACH_SITE_CODE_NULL
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'approachSiteCode'),'@code')::STRING AS APPROACH_SITE_CODE
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'approachSiteCode'),'@codeSystem')::STRING AS APPROACH_SITE_CODE_SYSTEM
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'approachSiteCode'),'@codeSystemName')::STRING AS APPROACH_SITE_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'approachSiteCode'),'@displayName')::STRING AS APPROACH_SITE_DISPLAY_NAME
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'doseQuantity'),'@nullFlavor')::STRING AS DOSE_QUANTITY_NULL      
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'doseQuantity'),'@unit')::STRING AS DOSE_QUANTITY_UNIT
     ,GET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'doseQuantity'),'@value')::STRING AS DOSE_QUANTITY_VALUE
     ,GET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'@classCode')::STRING AS MFG_PRODUCT_CLASS_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'templateId'),'@extension')::STRING AS MFG_PRODUCT_TEMPLATE_ID_EXTENSION
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'templateId'),'@root')::STRING AS MFG_PRODUCT_TEMPLATE_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'templateId',1),'@root')::STRING AS MFG_PRODUCT_TEMPLATE_ID_ROOT_2
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@code')::STRING AS MFG_MATERIAL_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@codeSystem')::STRING AS MFG_MATERIAL_CODE_SYSTEM
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@codeSystemName')::STRING AS MFG_MATERIAL_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),'@displayName')::STRING AS MFG_MATERIAL_CODE_DISPLAY_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),
             'translation'),'@code')::STRING AS TRANSLATION_CODE       
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),
             'translation'),'@codeSystem')::STRING AS TRANSLATION_CODE_SYSTEM
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),
             'translation'),'@codeSystemName')::STRING AS TRANSLATION_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'code'),
             'translation'),'@displayName')::STRING AS TRANSLATION_DISPLAY_NAME
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturedMaterial'),'lotNumberText'):"$"::STRING AS LOT_NUMBER
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'consumable'),'manufacturedProduct'),'manufacturerOrganization'),
             'name'):"$"::STRING AS MFG_ORGANIZATION_NAME
     ,GET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'templateId'),'@root')::STRING AS AUTHOR_TEMPLATE_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'templateId',1),'@root')::STRING AS AUTHOR_TEMPLATE_ID_ROOT_2
     ,GET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'time'),'@value')::STRING AS AUTHOR_TIME     
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'@nullFlavor')::STRING AS AUTHOR_ADDRESS_NULL
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),
             'streetAddressLine'),'@nullFlavor')::STRING AS AUTHOR_STREET_ADDRESS_NULL
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'streetAddressLine'):"$"::STRING AS AUTHOR_STREET_ADDRESS
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'city'),'@nullFlavor')::STRING AS AUTHOR_CITY_NULL
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'city'):"$"::STRING AS AUTHOR_CITY
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'state'),'@nullFlavor')::STRING AS AUTHOR_STATE_NULL
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'state'):"$"::STRING AS AUTHOR_STATE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'postalCode'),'@nullFlavor')::STRING AS AUTHOR_ZIP_CODE_NULL
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'postalCode'):"$"::STRING AS AUTHOR_ZIP_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'country'),'@nullFlavor')::STRING AS AUTHOR_COUNTRY_NULL
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'addr'),'country'):"$"::STRING AS AUTHOR_COUNTRY
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'telecom'),'@nullFlavor')::STRING AS AUTHOR_PHONE_NULL
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'telecom'),'@use')::STRING AS AUTHOR_PHONE_USE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'telecom'),'@value')::STRING AS AUTHOR_PHONE_NUMBER
     ,CONCAT (
          XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
          XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING, ' ',
          NVL(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'assignedPerson'),'name'),'suffix'):"$"::STRING, '')
          ) AS ASSIGNED_PERSON_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),
            'id'),'@assigningAuthorityName')::STRING AS REP_ORGANIZATION_ID_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),
            'id'),'@extension')::STRING AS REP_ORGANIZATION_ID_EXTENSION
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),
            'id'),'@root')::STRING AS REP_ORGANIZATION_ID_ROOT
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'name'):"$"::STRING AS REP_ORGANIZATION_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),
            'telecom'),'@use')::STRING AS REP_ORGANIZATION_TELECOM_USE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'telecom'),'@value')::STRING AS REP_ORGANIZATION_TELEPHONE_NUMBER
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS REP_ORGANIZATION_STREET_ADDRESS
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'streetAddressLine',1):"$"::STRING AS REP_ORGANIZATION_STREET_ADDRESS_2
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'city'):"$"::STRING AS REP_ORGANIZATION_CITY
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'state'):"$"::STRING AS REP_ORGANIZATION_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(ENTRY.VALUE,'substanceAdministration'),'author'),'assignedAuthor'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS REP_ORGANIZATION_ZIP_CODE
     ,ROW_NUM AS XML_ROW_NUM
     ,TS_LAST_MODIFY
     ,SCAN_TIME
     FROM QUALITY.SECTION_XML X
         ,LATERAL FLATTEN(X.xml) SECTION     
         ,LATERAL FLATTEN(SECTION.VALUE:"$"::ARRAY) ENTRY
         ,LATERAL FLATTEN(ENTRY.VALUE:"$"::ARRAY) SUBSTANCE_ADMIN
     WHERE X.SECTION_TITLE = 'HISTORY OF IMMUNIZATIONS'
           AND GET(SECTION.VALUE, '@') = 'section'
           AND GET(ENTRY.VALUE, '@') = 'entry'
           AND GET(SUBSTANCE_ADMIN.VALUE, '@') = 'substanceAdministration'
)
SELECT  
      M.FILENAME
     ,M.MRN
     ,M.SECTION_TITLE
     ,M.TEMPLATE_ID_EXTENSION
     ,M.TEMPLATE_ID_ROOT
     ,M.TEMPLATE_ID_ROOT_2
     ,M.IMMUNIZATION_CODE
     ,M.CODE_SYSTEM
     ,M.CODE_SYSTEM_NAME
     ,M.DISPLAY_NAME
     ,M.TYPE_CODE
     ,M.CLASS_CODE
     ,M.MOOD_CODE
     ,M.NEGATION_INDICATOR
     ,M.SUBSTANCE_TEMPLATE_ID_EXTENSION  
     ,M.SUBSTANCE_TEMPLATE_ID_ROOT
     ,M.SUBSTANCE_TEMPLATE_ID_ROOT_2
     ,M.SUBSTANCE_ID_AUTHORITY_NAME
     ,M.ENTRY_ID_EXTENSION
     ,M.SUBSTANCE_ID_ROOT
     ,M.TEXT_REF_VALUE
     ,M.STATUS_CODE
     ,M.EFFECTIVE_TIME
     ,M.REPEAT_NUMBER
     ,M.ROUTE_CODE_NULL     
     ,M.ROUTE_CODE
     ,M.ROUTE_CODE_SYSTEM
     ,M.ROUTE_CODE_SYSTEM_NAME
     ,M.ROUTE_CODE_DISPLAY_NAME
     ,M.APPROACH_SITE_CODE_NULL
     ,M.APPROACH_SITE_CODE
     ,M.APPROACH_SITE_CODE_SYSTEM
     ,M.APPROACH_SITE_CODE_SYSTEM_NAME
     ,M.APPROACH_SITE_DISPLAY_NAME
     ,M.DOSE_QUANTITY_NULL
     ,M.DOSE_QUANTITY_UNIT
     ,M.DOSE_QUANTITY_VALUE
     ,M.MFG_PRODUCT_CLASS_CODE
     ,M.MFG_PRODUCT_TEMPLATE_ID_EXTENSION
     ,M.MFG_PRODUCT_TEMPLATE_ID_ROOT
     ,M.MFG_PRODUCT_TEMPLATE_ID_ROOT_2
     ,M.MFG_MATERIAL_CODE
     ,M.MFG_MATERIAL_CODE_SYSTEM
     ,M.MFG_MATERIAL_CODE_SYSTEM_NAME
     ,M.MFG_MATERIAL_CODE_DISPLAY_NAME
     ,M.TRANSLATION_CODE
     ,M.TRANSLATION_CODE_SYSTEM
     ,M.TRANSLATION_CODE_SYSTEM_NAME
     ,M.TRANSLATION_DISPLAY_NAME
     ,M.LOT_NUMBER
     ,M.MFG_ORGANIZATION_NAME
     ,M.AUTHOR_TEMPLATE_ID_ROOT
     ,M.AUTHOR_TEMPLATE_ID_ROOT_2
     ,M.AUTHOR_TIME     
     ,A.PVID      -- author
     ,A.PVID_OID  -- author
     ,A.FACILITY  -- author
     ,A.FACILITY_OID
     ,A.NPI
     ,A.NPI_OID     -- author
     ,M.AUTHOR_ADDRESS_NULL
     ,M.AUTHOR_STREET_ADDRESS_NULL
     ,M.AUTHOR_STREET_ADDRESS
     ,M.AUTHOR_CITY_NULL
     ,M.AUTHOR_CITY
     ,M.AUTHOR_STATE_NULL
     ,M.AUTHOR_STATE
     ,M.AUTHOR_ZIP_CODE_NULL
     ,M.AUTHOR_ZIP_CODE
     ,M.AUTHOR_COUNTRY_NULL
     ,M.AUTHOR_COUNTRY
     ,M.AUTHOR_PHONE_NULL
     ,M.AUTHOR_PHONE_USE
     ,M.AUTHOR_PHONE_NUMBER
     ,M.ASSIGNED_PERSON_NAME
     ,M.REP_ORGANIZATION_ID_NAME
     ,M.REP_ORGANIZATION_ID_EXTENSION
     ,M.REP_ORGANIZATION_ID_ROOT
     ,M.REP_ORGANIZATION_NAME
     ,M.REP_ORGANIZATION_TELECOM_USE
     ,M.REP_ORGANIZATION_TELEPHONE_NUMBER
     ,M.REP_ORGANIZATION_STREET_ADDRESS
     ,M.REP_ORGANIZATION_STREET_ADDRESS_2
     ,M.REP_ORGANIZATION_CITY
     ,M.REP_ORGANIZATION_STATE
     ,M.REP_ORGANIZATION_ZIP_CODE
     ,M.XML_ROW_NUM 
     ,M.TS_LAST_MODIFY
     ,M.SCAN_TIME
FROM MAIN M
LEFT OUTER JOIN AUTHOR A 
     ON A.FILENAME = M.FILENAME
    AND A.AUTHOR_ID_EXTENSION = M.ENTRY_ID_EXTENSION;
