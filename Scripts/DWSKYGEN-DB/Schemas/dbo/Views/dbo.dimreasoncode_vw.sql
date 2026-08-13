CREATE OR REPLACE VIEW DBO.DimReasonCode_VW
AS 
SELECT 	$1:ReasonCodeKey::NUMBER(38, 0) AS ReasonCodeKey, 
		$1:REASON_CODE::NUMBER(38, 0) AS REASON_CODE, 
		$1:ReasonCodeDescription::VARCHAR AS ReasonCodeDescription, 
		$1:CodeTypeID::NUMBER(38, 0) AS CodeTypeID, 
		$1:CodeTypeDesc::VARCHAR AS CodeTypeDesc, 
		$1:ANSI_CARC::VARCHAR AS ANSI_CARC, 
		$1:ANSI_RARC::VARCHAR AS ANSI_RARC, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimReasonCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
