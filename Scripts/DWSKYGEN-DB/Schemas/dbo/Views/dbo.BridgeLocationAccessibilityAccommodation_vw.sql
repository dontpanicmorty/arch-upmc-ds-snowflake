CREATE OR REPLACE VIEW DBO.BridgeLocationAccessibilityAccommodation_VW
AS 
SELECT 	$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:AccessibilityAccommodationKey::NUMBER(38, 0) AS AccessibilityAccommodationKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime,
        $1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeLocationAccessibilityAccommodation/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);