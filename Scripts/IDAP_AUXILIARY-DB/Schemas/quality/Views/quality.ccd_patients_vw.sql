!set variable_substitution=true;

CREATE OR REPLACE VIEW QUALITY.CCD_PATIENTS_VW(
	MRN,
	SECTION_TITLE,
	FILENAME,
	ID_EXTENSION,
	ID_ROOT,
	ID_CODE,
	ID_CODE_NAME,
	ID_CODE_SYSTEM,
	ID_CODE_SYSTEM_NAME,
	PATIENT_LANGUAGE_CODE,
	PATIENT_ID_EXT,
	PATIENT_NAME,
	PATIENT_ADDRESS_LINE,
	PATIENT_CITY,
	PATIENT_STATE,
	PATIENT_ZIP,
	PATIENT_COUNTY,
	PATIENT_PHONE_NUM,
	PATIENT_CONTACT_2,
	PATIENT_CONTACT_3,
	GENDER_CODE,
	GENDER,
	BIRTH_DATE,
	MARITAL_CODE,
	MARITAL_STATUS,
	RACE_CODE,
	RACE_NAME,
	RACE_CODE_SYSTEM,
	ETHNICITY_CODE,
	ETHNICITY_NAME,
	ETHNICITY_CODE_SYSTEM_NAME,
	LANGUAGE_CODE,
	LANGUAGE_PROFICIENCY,
	LANGUAGE_PREFERENCE_IND,
	AUTHOR_TIME,
	AUTHOR_ID_ROOT,
	AUTHOR_ADDR_NULL_FLAVOR,
	AUTHOR_PHONE_NUMBER,
	ASSIGNED_NAME,
	MODEL_NAME,
	SOFTWARE_NAME,
	ORG_ROOT,
	ORG_EXT,
	ORG_NAME,
	ORG_PHONE_NUMBER,
	ORG_STREET_ADDRESS,
	ORG_CITY,
	ORG_STATE,
	ORG_ZIP_CODE,
	ORG_COUNTRY,
	CUSTODIAN_ID,
	CUSTODIAN_NAME,
	CUSTODIAN_PHONE_NUM,
	CUSTODIAN_STREET_ADDRESS,
	CUSTODIAN_CITY,
	CUSTODIAN_STATE,
	CUSTODIAN_ZIP_CODE,
	CUSTODIAN_COUNTRY,
	SERVICE_EVENT_CLASS,
	SERVICE_EVENT_START_DATE,
	SERVICE_EVENT_END_DATE,
	PERFORMER_TYPE_CODE,
	PERFORMER_FUNCTION_CODE,
	PERFORMER_FUNCTION_NAME,
	PERFORMER_FUNCTION_CODE_SYSTEM,
	PERFORMER_FUNCTION_TEXT,
	ENTITY_ID,
	ENTITY_ID_ROOT,
	ENTITY_CODE,
	ENTITY_NAME,
	ENTITY_CODE_SYSTEM_NAME,
	ENTITY_ADDR_NULL_FLAVOR,
	ENTITY_TELECOM_NULL_FLAVOR,
	ENTITY_PERSON_NAME,
	XML_DATA_ROW_NUM,
	XML_DATA_TS_LAST_MODIFY,
	XML_DATA_SCAN_TIME
) as 
SELECT 
      GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id'),'@extension')::STRING as MRN
     ,XMLGET( XML, 'title'):"$"::STRING as SECTION_TITLE
     ,BASE_FILENAME
     ,GET( XMLGET( X.XML, 'id' ), '@extension')::STRING as ID_EXTENSION
     ,GET( XMLGET( X.XML, 'id' ), '@root')::STRING as ID_ROOT
     ,GET( XMLGET( X.XML, 'code' ), '@code')::STRING as ID_CODE
     ,GET( XMLGET( X.XML, 'code' ), '@displayName')::STRING as ID_CODE_NAME
     ,GET( XMLGET( X.XML, 'code' ), '@codeSystem')::STRING as ID_CODE_SYSTEM
     ,GET( XMLGET( X.XML, 'code' ), '@codeSystemName')::STRING as ID_CODE_SYSTEM_NAME
     ,GET( XMLGET( X.XML, 'languageCode' ), '@code')::STRING as PATIENT_LANGUAGE_CODE
     ,GET(XMLGET(XMLGET(XMLGET( XML, 'recordTarget'),'patientRole'),'id',1),'@extension')::STRING as PATIENT_ID_EXT     
	 ,CONCAT (
              NVL(XMLGET( XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'name'),'family'):"$"::STRING,''),', ',
              NVL(XMLGET( XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'name'),'given'):"$"::STRING,''), ' ',
              NVL(XMLGET( XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'name'),'given',1):"$"::STRING,''), ' '
             ) AS PATIENT_NAME 
     ,XMLGET( XMLGET( PATIENTROLE.THIS, 'addr' ), 'streetAddressLine'):"$"::STRING as PATIENT_ADDRESS_LINE
     ,XMLGET( XMLGET( PATIENTROLE.THIS, 'addr' ), 'city'):"$"::STRING as PATIENT_CITY
     ,XMLGET( XMLGET( PATIENTROLE.THIS, 'addr' ), 'state'):"$"::STRING as PATIENT_STATE
     ,XMLGET( XMLGET( PATIENTROLE.THIS, 'addr' ), 'postalCode'):"$"::STRING as PATIENT_ZIP
     ,XMLGET( XMLGET( PATIENTROLE.THIS, 'addr' ), 'country'):"$"::STRING as PATIENT_COUNTRY
     ,GET( XMLGET( PATIENTROLE.THIS, 'telecom'),'@value')::STRING AS PATIENT_PHONE_NUM
     ,GET( XMLGET( PATIENTROLE.THIS, 'telecom',1),'@value')::STRING AS PATIENT_CONTACT_2
     ,GET( XMLGET( PATIENTROLE.THIS, 'telecom',2),'@value')::STRING as PATIENT_CONTACT_3
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'administrativeGenderCode'),'@code')::STRING AS GENDER_CODE
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'administrativeGenderCode'),'@displayName')::STRING AS GENDER
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'birthTime'),'@value')::STRING AS BIRTH_DATE
     ,nvl( GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'maritalStatusCode'),'@code')::STRING,
           GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'maritalStatusCode'),'@nullFlavor')::STRING) as marital_code
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'maritalStatusCode'),'@displayName')::STRING as MARITAL_STATUS
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'raceCode'),'@code')::STRING AS RACE_CODE
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'raceCode'),'@displayName')::STRING AS RACE_NAME
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'raceCode'),'@codeSystemName')::STRING as RACE_CODE_SYSTEM                  
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'ethnicGroupCode'),'@code')::STRING AS ETHNICITY_CODE
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'ethnicGroupCode'),'@displayName')::STRING AS ETHNICITY_NAME
     ,GET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'ethnicGroupCode'),'@codeSystemName')::STRING as ETHNICITY_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'languageCommunication'),'languageCode'),'@code')::STRING AS LANGUAGE_CODE
     ,GET(XMLGET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'languageCommunication'),'proficiencyLevelCode'), 
             '@nullFlavor')::STRING AS LANGUAGE_PROFICIENCY
     ,GET(XMLGET(XMLGET( XMLGET( PATIENTROLE.THIS, 'patient' ), 'languageCommunication'),'preferenceInd'), '@value')::STRING AS LANGUAGE_PREFERENCE_IND
     ,GET(XMLGET(XMLGET( X.XML, 'author'),'time'),'@value')::STRING AS AUTHOR_TIME
     ,GET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'id'),'@root')::STRING as AUTHOR_ID_ROOT     
     ,GET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'addr'),'@nullFlavor')::STRING AS AUTHOR_ADDR_NULL_FLAVOR
     ,GET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'telecom'),'@value')::STRING AS AUTHOR_PHONE_NUMBER
	 ,CONCAT(
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'assignedPerson'),'name'),'family'):"$"::STRING, ', ',
           XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'assignedPerson'),'name'),'given'):"$"::STRING           
          ) AS ASSIGNED_NAME
     ,XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'assignedAuthoringDevice'),'manufacturerModelName'):"$"::STRING AS MODEL_NAME
     ,XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'assignedAuthoringDevice'),'softwareName'):"$"::STRING AS SOFTWARE_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'id'),'@root')::STRING AS ORG_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'id'),'@extension')::STRING AS ORG_EXT
     ,XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'name'):"$"::STRING AS ORG_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'telecom'),'@value')::STRING AS ORG_PHONE_NUMBER
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'addr'),'streetAddressLine'):"$"::STRING AS ORG_STREET_ADDRESS
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'addr'),'city'):"$"::STRING AS ORG_CITY
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'addr'),'state'):"$"::STRING AS ORG_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'addr'),'postalCode'):"$"::STRING AS ORG_ZIP_CODE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'author'),'assignedAuthor'),'representedOrganization'),'addr'),'country'):"$"::STRING AS ORG_COUNTRY
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'id'),'@extension')::STRING AS CUSTODIAN_ID
     ,XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'name'):"$"::STRING AS CUSTODIAN_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'telecom'),'@value')::STRING AS CUSTODIAN_PHONE_NUM
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),
                                                 'streetAddressLine'):"$"::STRING AS CUSTODIAN_STREET_ADDRESS
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'city'):"$"::STRING AS CUSTODIAN_CITY
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'state'):"$"::STRING AS CUSTODIAN_STATE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'postalCode'):"$"::STRING AS CUSTODIAN_ZIP_CODE
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'custodian'),'assignedCustodian'),'representedCustodianOrganization'),'addr'),'country'):"$"::STRING AS CUSTODIAN_COUNTRY
     ,GET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'@classCode')::STRING AS SERVICE_EVENT_CLASS
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'effectiveTime'),'low'),'@value')::STRING AS SERVICE_EVENT_START_DATE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'effectiveTime'),'high'),'@value')::STRING AS SERVICE_EVENT_END_DATE
     ,GET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'@typeCode')::STRING AS PERFORMER_TYPE_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'functionCode'),'@code')::STRING AS PERFORMER_FUNCTION_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'functionCode'),'@displayName')::STRING AS PERFORMER_FUNCTION_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'functionCode'),'@codeSystemName')::STRING AS PERFORMER_FUNCTION_CODE_SYSTEM
     ,XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'functionCode'),'originalText'):"$"::STRING AS PERFORMER_FUNCTION_TEXT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'id'),'@extension')::STRING AS ENTITY_ID
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'id'),'@root')::STRING AS ENTITY_ID_ROOT
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'code'),'@code')::STRING AS ENTITY_CODE
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'code'),'@displayName')::STRING AS ENTITY_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'code'),
                             '@codeSystemName')::STRING AS ENTITY_CODE_SYSTEM_NAME
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'addr'),
                             '@nullFlavor')::STRING AS ENTITY_ADDR_NULL_FLAVOR
     ,GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'telecom'),
                             '@nullFlavor')::STRING AS ENTITY_TELECOM_NULL_FLAVOR
     ,CONCAT( 
             XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'assignedPerson'),
                                                              'name'),'family'):"$"::STRING, ', ',
	         XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),'assignedPerson'),
                                                              'name'),'given'):"$"::STRING, ' ',
             nvl(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),
                                                              'assignedPerson'),'name'),'suffix'):"$"::STRING,'')
             --nvl(GET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET(XMLGET( X.XML, 'documentationOf'),'serviceEvent'),'performer'),'assignedEntity'),
             --                                                 'assignedPerson'),'name'),'suffix'),'@qualifier')::STRING,'')
            )  AS ENTITY_PERSON_NAME
     ,ROW_NUM
	 ,TS_LAST_MODIFY
	 ,SCAN_TIME
FROM &{idap_lake}.QUALITY.RAW_XML X
    ,LATERAL FLATTEN( X.XML:"$") RECORDTARGET
    ,LATERAL FLATTEN( recordTarGET.value:"$") PATIENTROLE
WHERE GET( recordTarget.value,'@') ='recordTarget' 
AND SECTION_TITLE LIKE 'Continuity of Care Document%'
AND PATIENTROLE.VALUE like '%patientRole%'
AND BASE_FILENAME IN (
    SELECT FILENAME FROM (
          SELECT PATIENT_MRN AS MRN, 
                 MAX( CS_TRANSACTION_ID ) || '.xml' AS FILENAME
           FROM &{idap_lake}.QUALITY.CCD_CONTROL
           GROUP BY PATIENT_MRN
           )          
     );

!set variable_substitution=false;     
