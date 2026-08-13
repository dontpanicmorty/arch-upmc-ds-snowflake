CREATE OR REPLACE VIEW DBO.DimEducationalInstutition_VW
AS 
SELECT 	$1:EducationalInstutitionKey::NUMBER(38, 0) AS EducationalInstutitionKey, 
		$1:EDUCATIONAL_INSTITUTION_ID::NUMBER(38, 0) AS EDUCATIONAL_INSTITUTION_ID, 
		$1:CountryID::NUMBER(38, 0) AS CountryID, 
		$1:SchoolName::VARCHAR AS SchoolName, 
		$1:Address1::VARCHAR AS Address1, 
		$1:Address2::VARCHAR AS Address2, 
		$1:City::VARCHAR AS City, 
		$1:State::VARCHAR AS State, 
		$1:Zip::VARCHAR AS Zip, 
		$1:Region::VARCHAR AS Region, 
		$1:PostalCode::VARCHAR AS PostalCode, 
		$1:ContactName::VARCHAR AS ContactName, 
		$1:VoicePhone::VARCHAR AS VoicePhone, 
		$1:VoicePhoneExtension::VARCHAR AS VoicePhoneExtension, 
		$1:FaxPhone::VARCHAR AS FaxPhone, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEducationalInstutition/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
