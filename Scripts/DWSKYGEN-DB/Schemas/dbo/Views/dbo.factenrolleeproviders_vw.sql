CREATE OR REPLACE VIEW DBO.FactEnrolleeProviders_VW
AS 
SELECT 	$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:ProviderEntityTypeKey::NUMBER(38, 0) AS ProviderEntityTypeKey, 
		$1:ProviderChangeReasonKey::NUMBER(38, 0) AS ProviderChangeReasonKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:IPA::NUMBER(38, 0) AS IPA, 
		$1:CLIENT_PROVIDER_ID::VARCHAR AS CLIENT_PROVIDER_ID, 
		$1:CLIENT_LOCATION_ID::VARCHAR AS CLIENT_LOCATION_ID, 
		$1:CLIENT_IPA_ID::VARCHAR AS CLIENT_IPA_ID, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnrolleeProviders/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
