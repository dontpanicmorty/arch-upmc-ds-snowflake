CREATE OR REPLACE VIEW DBO.FactClientDeliquentPremiumCriteria_VW
AS 
SELECT 	$1:ClientDeliquentCriteriaKey::NUMBER(38, 0) AS ClientDeliquentCriteriaKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:DateEffectiveKey::VARCHAR AS DateEffectiveKey, 
		$1:DateTerminationKey::VARCHAR AS DateTerminationKey, 
		$1:DateFirstBillPeriodKey::VARCHAR AS DateFirstBillPeriodKey, 
		$1:INTEREST_RATE::VARCHAR AS INTEREST_RATE, 
		$1:LATE_FEE_AMOUNT::VARCHAR AS LATE_FEE_AMOUNT, 
		$1:GRACE_PERIOD::VARCHAR AS GRACE_PERIOD, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactClientDeliquentPremiumCriteria/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
