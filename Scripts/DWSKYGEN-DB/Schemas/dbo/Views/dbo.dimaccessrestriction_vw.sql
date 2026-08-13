CREATE OR REPLACE VIEW DBO.DimAccessRestriction_VW
AS 
SELECT 	$1:AccessRestrictionKey::NUMBER(38, 0) AS AccessRestrictionKey, 
		$1:RESTRICTION_ID::NUMBER(38, 0) AS RESTRICTION_ID, 
		$1:MarketID::NUMBER(38, 0) AS MarketID, 
		$1:AccessRestrictionDescription::VARCHAR AS AccessRestrictionDescription, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime, 
		$1:RecordStartDate::DATE AS RecordStartDate
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAccessRestriction/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
