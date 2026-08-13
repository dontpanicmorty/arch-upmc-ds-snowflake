CREATE OR REPLACE VIEW DBO.DimCommunicationType_VW
AS 
SELECT 	$1:CommunicationTypeKey::NUMBER(38, 0) AS CommunicationTypeKey, 
		$1:COMMUNICATOR_TYPE::NUMBER(38, 0) AS COMMUNICATOR_TYPE, 
		$1:CommunicatorType::VARCHAR AS CommunicatorType, 
		$1:COMMUNICATION_TYPE::NUMBER(38, 0) AS COMMUNICATION_TYPE, 
		$1:CommuniationType::VARCHAR AS CommuniationType, 
		$1:COMMUNICATION_CATEGORY::NUMBER(38, 0) AS COMMUNICATION_CATEGORY, 
		$1:CommunicationCategory::VARCHAR AS CommunicationCategory, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCommunicationType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
