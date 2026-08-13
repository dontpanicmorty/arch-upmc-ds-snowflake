CREATE OR REPLACE VIEW DBO.DimEnrolleeContract_VW
AS 
SELECT 	$1:EnrolleeContractKey::NUMBER(38, 0) AS EnrolleeContractKey, 
		$1:ENROLLEE_CONTRACT_ID::NUMBER(38, 0) AS ENROLLEE_CONTRACT_ID, 
		$1:InsuredEnrolleeID::NUMBER(38, 0) AS InsuredEnrolleeID, 
		$1:ContractBeginDate::DATE AS ContractBeginDate, 
		$1:ContractEndDate::DATE AS ContractEndDate, 
		$1:BillingCycleType::NUMBER(38, 0) AS BillingCycleType, 
		$1:RelationshipCodeToApplicant::VARCHAR AS RelationshipCodeToApplicant, 
		$1:CreationDate::TIMESTAMP_NTZ AS CreationDate, 
		$1:LastModifiedDomainSourceID::NUMBER(38, 0) AS LastModifiedDomainSourceID, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimEnrolleeContract/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
