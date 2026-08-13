CREATE OR REPLACE VIEW DBO.DimAppealInitiatorType_VW
AS 
SELECT 	$1:AppealInitiatorTypeKey::NUMBER(38, 0) AS AppealInitiatorTypeKey, 
		$1:APPEAL_INITIATOR_TYPE::NUMBER(38, 0) AS APPEAL_INITIATOR_TYPE, 
		$1:AppealInitiatorTypeDescription::VARCHAR AS AppealInitiatorTypeDescription, 
		$1:AppealTypeID::NUMBER(38, 0) AS AppealTypeID, 
		$1:AppealTypeDescription::VARCHAR AS AppealTypeDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAppealInitiatorType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
