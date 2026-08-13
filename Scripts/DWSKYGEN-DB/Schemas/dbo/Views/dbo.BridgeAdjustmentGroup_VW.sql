CREATE OR REPLACE VIEW DBO.BridgeAdjustmentGroup_VW
AS 
SELECT 	$1:AdjustmentGroupKey::NUMBER(38, 0) AS AdjustmentGroupKey, 
		$1:AdjustmentReasonKey::NUMBER(38, 0) AS AdjustmentReasonKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeAdjustmentGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
