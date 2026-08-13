CREATE OR REPLACE VIEW DBO.DimState_VW
AS 
SELECT 	$1:StateKey::NUMBER(38, 0) AS StateKey, 
		$1:STATE::VARCHAR AS STATE, 
		$1:StateFullName::VARCHAR AS StateFullName, 
		$1:DOR_PayeeID::NUMBER(38, 0) AS DOR_PayeeID, 
		$1:BackupWithholdingPercent::NUMBER(9, 4) AS BackupWithholdingPercent, 
		$1:BackupWithholdingContactInfo::VARCHAR AS BackupWithholdingContactInfo, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimState/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
