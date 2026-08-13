
CREATE OR REPLACE VIEW QUALITY.CCD_FUNCTIONAL_STATUS_VW(
	SECTION_TITLE,
	FILENAME,
	MRN,
	FS_OID,
	FS_EXT,
	FS_OID_2,
	SECTION_CODE,
	DISPLAY_NAME,
	CODE_SYSTEM,
	CODE_SYSTEM_NAME,
	FS_CONDITION,
	FS_COMMENT,
	FS_DATE,
	FS_STATUS,
	ROW_NUM,
	TS_LAST_MODIFY,
	SCAN_TIME
) as 
SELECT SECTION_TITLE,
       FILENAME, 
       MRN,
       FS_OID,
       FS_EXT,
       FS_OID_2,
       SECTION_CODE,
       DISPLAY_NAME,
       CODE_SYSTEM,
       CODE_SYSTEM_NAME,
       FS_CONDITION,
       FS_COMMENT,
       FS_DATE,
       FS_STATUS,
       ROW_NUM,
       TS_LAST_MODIFY,
       SCAN_TIME
FROM (
    SELECT 
       X.SECTION_TITLE
      ,X.FILENAME
      ,X.MRN
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@root')::STRING AS FS_OID
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId'),'@extension')::STRING AS FS_EXT
      ,GET(XMLGET(XMLGET(X.XML,'section'),'templateId',1),'@root')::STRING AS FS_OID_2
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@code')::STRING AS SECTION_CODE
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@displayName')::STRING AS DISPLAY_NAME
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystem')::STRING AS CODE_SYSTEM
      ,GET(XMLGET(XMLGET(X.XML,'section'),'code'),'@codeSystemName')::STRING AS CODE_SYSTEM_NAME
      ,XMLGET( F.VALUE, 'td'):"$"::STRING AS FS_CONDITION
      ,XMLGET( F.VALUE, 'td',1):"$"::STRING AS FS_COMMENT
      ,XMLGET( F.VALUE, 'td',2):"$"::STRING AS FS_DATE
      ,XMLGET( F.VALUE, 'td',3):"$"::STRING AS FS_STATUS
      ,ROW_NUM
      ,TS_LAST_MODIFY
	  ,SCAN_TIME
      ,ROW_NUMBER() OVER ( PARTITION BY  FILENAME,
                                         SECTION_TITLE,
                                         MRN,
                                         FS_CONDITION,
                                         FS_COMMENT,
                                         FS_DATE,
                                         FS_STATUS
                               ORDER BY FILENAME, MRN, SECTION_TITLE, MRN, FS_CONDITION ) AS RN      
    FROM QUALITY.SECTION_XML X
        ,LATERAL FLATTEN(to_array(XMLGET(XMLGET(XMLGET(XMLGET(X.XML, 'section'),'text'),'table'),'tbody'):"$")) F
    WHERE SECTION_TITLE = 'Functional Status'
    AND F.VALUE like '%tr%'
)
WHERE RN = 1;
