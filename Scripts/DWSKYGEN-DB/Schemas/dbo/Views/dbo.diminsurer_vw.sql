CREATE OR REPLACE VIEW DBO.DimInsurer_VW
AS 
SELECT 	$1:InsurerKey::NUMBER(38, 0) AS InsurerKey, 
		$1:INSURER_ID::NUMBER(38, 0) AS INSURER_ID, 
		$1:InsurerDescription::VARCHAR AS InsurerDescription, 
		$1:MarketID::NUMBER(38, 0) AS MarketID, 
		$1:MarketDescription::VARCHAR AS MarketDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimInsurer/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
