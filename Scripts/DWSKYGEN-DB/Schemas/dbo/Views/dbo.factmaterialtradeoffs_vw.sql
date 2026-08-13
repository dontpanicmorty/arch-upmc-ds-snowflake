CREATE OR REPLACE VIEW DBO.FactMaterialTradeOffs_VW
AS 
SELECT 	$1:CodesetKey::NUMBER(38, 0) AS CodesetKey, 
		$1:MaterialPlanKey::NUMBER(38, 0) AS MaterialPlanKey, 
		$1:SubcodeKey::NUMBER(38, 0) AS SubcodeKey, 
		$1:TradeOffCodesetKey::NUMBER(38, 0) AS TradeOffCodesetKey, 
		$1:TradeOffSubcodeKey::NUMBER(38, 0) AS TradeOffSubcodeKey, 
		$1:MaterialTradeOffCount::NUMBER(38, 0) AS MaterialTradeOffCount, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactMaterialTradeOffs/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
