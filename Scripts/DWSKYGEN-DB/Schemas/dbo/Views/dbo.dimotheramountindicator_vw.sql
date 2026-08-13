CREATE OR REPLACE VIEW DBO.DimOtherAmountIndicator_VW
AS 
SELECT 	$1:OtherAmountIndicatorKey::NUMBER(38, 0) AS OtherAmountIndicatorKey, 
		$1:OTHER_AMOUNT_INDICATOR::VARCHAR AS OTHER_AMOUNT_INDICATOR, 
		$1:OtherAmountIndicatorDescription::VARCHAR AS OtherAmountIndicatorDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimOtherAmountIndicator/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
