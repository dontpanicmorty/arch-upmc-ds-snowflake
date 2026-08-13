CREATE OR REPLACE VIEW DBO.BridgeRolloverBenefitQualifyingEvent_VW
AS 
SELECT 	$1:RolloverBenefitKey::NUMBER(38, 0) AS RolloverBenefitKey, 
		$1:RolloverQualifyingEventKey::NUMBER(38, 0) AS RolloverQualifyingEventKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeRolloverBenefitQualifyingEvent/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);