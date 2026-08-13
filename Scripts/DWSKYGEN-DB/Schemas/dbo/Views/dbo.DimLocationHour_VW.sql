CREATE OR REPLACE VIEW DBO.DimLocationHour_VW
AS 
SELECT 	$1:LocationHourKey::NUMBER(38, 0) AS LocationHourKey, 
		$1:DayOfWeek::VARCHAR AS DayOfWeek, 
		($1:TimeOpen1::TIMESTAMP_NTZ)::TIME AS TimeOpen1, 
		($1:TimeClosed1::TIMESTAMP_NTZ)::TIME AS TimeClosed1, 
        ($1:TimeOpen2::TIMESTAMP_NTZ)::TIME AS TimeOpen2, 
        ($1:TimeClosed2::TIMESTAMP_NTZ)::TIME AS TimeClosed2,
		$1:HoursOpen::NUMBER(38, 0) AS HoursOpen, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimLocationHour/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);