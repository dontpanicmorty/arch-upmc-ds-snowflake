!set variable_substitution=true;
--&{IDAP_LAKE} is passed via the pipeline for each environment

CREATE OR REPLACE VIEW STAGEDATA.APIM_LOGS_MOBILE_VW 
AS
SELECT 
FILENAME
,FILE_ROW_NUMBER AS FILE_ROW_NUMBER
,APIM_LOGS_KEY AS APIM_LOGS_KEY
,PRODUCT AS PRODUCT
,JSON_DATA:OperationName::string AS OPERATION_NAME
,TRY_PARSE_JSON(JSON_DATA:"ResponseBody") AS RESPONSE_BODY_JSON
,RESPONSE_BODY_JSON:sessionId::string AS SESSION_ID
,EVENT_DATETIME_UTC AS EVENT_DATETIME
,RESPONSE_BODY_JSON:eventData:eventName::string AS EVENT_NAME
,RESPONSE_BODY_JSON:eventData:eventValues AS EVENT_VALUES
,RESPONSE_BODY_JSON:deviceData:platform::string AS DEVICE_PLATFORM
,RESPONSE_BODY_JSON:deviceData:operatingSystem::string AS DEVICE_OPERATING_SYSTEM
,RESPONSE_BODY_JSON:deviceData:deviceModelName::string AS DEVICE_MODEL_NAME
,RESPONSE_BODY_JSON:deviceData:deviceId::string AS DEVICE_ID
,RESPONSE_BODY_JSON:deviceData:language::string AS DEVICE_LANGUAGE
,RESPONSE_BODY_JSON:deviceData:appVersion::string AS DEVICE_APP_VERSION_NBR
,JSON_DATA:tpa_client::string as TPA_CLIENT_ID
,JSON_DATA:tpa_div::string as TPA_DIV_ID
,JSON_DATA:tpa_id::string as TPA_ID
,JSON_DATA:"Response Status Code"::string AS RESPONSE_STATUS_CODE
,JSON_DATA:"Response Status Reason"::string AS RESPONSE_STATUS_REASON
,CASE
    WHEN JSON_DATA:medical_member_id::string IS NOT NULL THEN JSON_DATA :medical_member_id::string
    WHEN TRY_PARSE_JSON(JSON_DATA:"ResponseBody"):medicalMember:memberId::string IS NOT NULL THEN TRY_PARSE_JSON(JSON_DATA:"ResponseBody"):medicalMember:memberId::string
    WHEN TRY_PARSE_JSON(JSON_DATA:"ResponseBody"):dentalVisionMember:memberId::string IS NOT NULL THEN TRY_PARSE_JSON(JSON_DATA:"ResponseBody"):dentalVisionMember:memberId::string
    ELSE NULL
END AS MEMBER_NBR
FROM &{IDAP_LAKE}.APPLICATION_EVENTS.APIM_LOGS
WHERE API_NAME IN (&{APPANALYTICS})
AND PRODUCT = 'Mobile'
AND RESPONSE_BODY_JSON IS NOT NULL
;

!set variable_substitution=false;