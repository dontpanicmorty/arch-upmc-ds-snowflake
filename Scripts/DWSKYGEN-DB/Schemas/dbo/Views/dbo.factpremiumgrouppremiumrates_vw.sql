CREATE OR REPLACE VIEW DBO.FactPremiumGroupPremiumRates_VW
AS 
SELECT 	$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:DateLastUpdatedKey::NUMBER(38, 0) AS DateLastUpdatedKey, 
		$1:LastUpdateDomainSourceKey::NUMBER(38, 0) AS LastUpdateDomainSourceKey, 
		$1:PremiumGroupPremiumTypeKey::NUMBER(38, 0) AS PremiumGroupPremiumTypeKey, 
		$1:PremiumRateChangeReasonKey::NUMBER(38, 0) AS PremiumRateChangeReasonKey, 
		$1:LAST_UPDATED_DATE_TIME::TIMESTAMP_NTZ AS LAST_UPDATED_DATE_TIME, 
		$1:PREMIUM_RATE::NUMBER(19, 4) AS PREMIUM_RATE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactPremiumGroupPremiumRates/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
