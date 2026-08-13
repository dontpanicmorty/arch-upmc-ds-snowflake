CREATE OR REPLACE VIEW DBO.DimApproval_VW
AS 
SELECT 	$1:ApprovalCodeKey::NUMBER(38, 0) AS ApprovalCodeKey, 
		$1:ApprovalCode::NUMBER(38, 0) AS ApprovalCode, 
		$1:Type::NUMBER(38, 0) AS Type, 
		$1:TypeDescription::VARCHAR AS TypeDescription, 
		$1:CodeDesc::VARCHAR AS CodeDesc, 
		$1:CodeTypeID::NUMBER(38, 0) AS CodeTypeID, 
		$1:CodeTypeDesc::VARCHAR AS CodeTypeDesc, 
		$1:ANSI_CARC::VARCHAR AS ANSI_CARC, 
		$1:CARCDescription::VARCHAR AS CARCDescription, 
		$1:ANSI_RARC::VARCHAR AS ANSI_RARC, 
		$1:RARCDescription::VARCHAR AS RARCDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimApproval/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
