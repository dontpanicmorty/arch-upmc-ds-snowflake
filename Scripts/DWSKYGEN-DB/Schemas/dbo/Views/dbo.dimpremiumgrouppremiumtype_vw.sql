CREATE OR REPLACE VIEW DBO.DimPremiumGroupPremiumType_VW
AS 
SELECT 	$1:PremiumGroupPremiumTypeKey::NUMBER(38, 0) AS PremiumGroupPremiumTypeKey, 
		$1:PREMIUM_GROUP_PREMIUM_TYPE_ID::NUMBER(38, 0) AS PREMIUM_GROUP_PREMIUM_TYPE_ID, 
		$1:PremiumGroupPremiumTypeDescription::VARCHAR AS PremiumGroupPremiumTypeDescription, 
		$1:PremiumGroupID::NUMBER(38, 0) AS PremiumGroupID, 
		$1:ProductID::NUMBER(38, 0) AS ProductID, 
		$1:ActiveFlag::BOOLEAN AS ActiveFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPremiumGroupPremiumType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
