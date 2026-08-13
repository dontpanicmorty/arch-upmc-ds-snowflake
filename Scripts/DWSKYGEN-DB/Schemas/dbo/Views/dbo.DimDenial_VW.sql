CREATE OR REPLACE VIEW DBO.DimDenial_VW
AS 
SELECT 	$1:DenialCodeKey::NUMBER(38, 0) AS DenialCodeKey, 
		$1:DenialCode::NUMBER(38, 0) AS DenialCode, 
		$1:Type::NUMBER(38, 0) AS Type, 
		$1:TypeDescription::VARCHAR AS TypeDescription, 
		$1:CodeDesc::VARCHAR AS CodeDesc, 
		$1:CodeTypeID::NUMBER(38, 0) AS CodeTypeID, 
		$1:CodeTypeDesc::VARCHAR AS CodeTypeDesc, 
		$1:ANSI_CARC::VARCHAR AS ANSI_CARC, 
		$1:CARCDescription::VARCHAR AS CARCDescription, 
		$1:ANSI_RARC::VARCHAR AS ANSI_RARC, 
		$1:RARCDescription::VARCHAR AS RARCDescription, 
		$1:CodeCategoryID::NUMBER(38, 0) AS CodeCategoryID, 
		$1:CodeCategory::VARCHAR AS CodeCategory, 
		$1:FATAL_FLAG::BOOLEAN AS FATAL_FLAG, 
		$1:CRITICAL_FLAG::BOOLEAN AS CRITICAL_FLAG, 
		$1:CanBeApprovedFlag::VARCHAR AS CanBeApprovedFlag, 
		$1:AutoAdvanceFlag::VARCHAR AS AutoAdvanceFlag, 
		$1:KeepRecodedServiceFlag::VARCHAR AS KeepRecodedServiceFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDenial/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
