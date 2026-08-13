CREATE OR REPLACE VIEW DBO.FactNetworkParticipationExceptions_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:NetworkKey::NUMBER(38, 0) AS NetworkKey, 
		$1:ProviderAccessStatusKey::NUMBER(38, 0) AS ProviderAccessStatusKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:LIST_IN_DIRECTORY_FLAG::BOOLEAN AS LIST_IN_DIRECTORY_FLAG, 
		$1:OTHER_ID1::VARCHAR AS OTHER_ID1, 
		$1:OTHER_ID2::VARCHAR AS OTHER_ID2, 
		$1:LAST_MODIFIED_DATE_TIME::TIMESTAMP_NTZ AS LAST_MODIFIED_DATE_TIME, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactNetworkParticipationExceptions/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
