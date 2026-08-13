CREATE OR REPLACE VIEW DBO.BridgeRolloverBenefitProcessing_VW
AS 
SELECT 	$1:RolloverBenefitKey::NUMBER(38, 0) AS RolloverBenefitKey, 
		$1:RolloverBenefitProcessingKey::NUMBER(38, 0) AS RolloverBenefitProcessingKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeRolloverBenefitProcessing/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);