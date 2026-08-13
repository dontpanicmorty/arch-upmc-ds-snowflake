CREATE OR REPLACE VIEW DBO.DimPremiumRateChangeReason_VW
AS 
SELECT 	$1:PremiumRateChangeReasonKey::NUMBER(38, 0) AS PremiumRateChangeReasonKey, 
		$1:PREMIUM_RATE_CHANGE_REASON::NUMBER(38, 0) AS PREMIUM_RATE_CHANGE_REASON, 
		$1:PremiumRateChangeReasonDescription::VARCHAR AS PremiumRateChangeReasonDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumRateChangeReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
