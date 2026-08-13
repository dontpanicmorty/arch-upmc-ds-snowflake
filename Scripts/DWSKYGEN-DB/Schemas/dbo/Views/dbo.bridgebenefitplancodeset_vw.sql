CREATE OR REPLACE VIEW DBO.BridgeBenefitPlanCodeSet_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:CodeSetKey::NUMBER(38, 0) AS CodeSetKey, 
		$1:StandardEnrolleeDays::NUMBER(38, 0) AS StandardEnrolleeDays, 
		$1:LateEnrolleeDays::NUMBER(38, 0) AS LateEnrolleeDays, 
		$1:WaitingPeriodCreditAppliesFlag::BOOLEAN AS WaitingPeriodCreditAppliesFlag, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeBenefitPlanCodeSet/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
