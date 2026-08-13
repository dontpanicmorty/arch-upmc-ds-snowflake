CREATE OR REPLACE VIEW DBO.BridgePremiumTypeSubscriberContractType_VW
AS 
SELECT 	$1:PremiumGroupPremiumTypeKey::NUMBER(38, 0) AS PremiumGroupPremiumTypeKey, 
		$1:SubscriberContractTypeKey::NUMBER(38, 0) AS SubscriberContractTypeKey, 
		$1:ActiveFlag::BOOLEAN AS ActiveFlag, 
		$1:InactiveDate::DATE AS InactiveDate, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgePremiumTypeSubscriberContractType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);