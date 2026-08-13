CREATE OR REPLACE VIEW DBO.DimAccessibilityAccommodation_VW
AS 
SELECT 	$1:AccessibilityAccommodationKey::NUMBER(38, 0) AS AccessibilityAccommodationKey, 
		$1:ACCESSIBILITY_ACCOMMODATION::NUMBER(38, 0) AS ACCESSIBILITY_ACCOMMODATION, 
		$1:AccessibilityAccommodationDescription::VARCHAR AS AccessibilityAccommodationDescription,
        $1:RecordStartDate::DATE AS RecordStartDate,
        $1:RecordEndDate::DATE AS RecordEndDate,
        $1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent,
        $1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime,
        $1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAccessibilityAccommodation/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
