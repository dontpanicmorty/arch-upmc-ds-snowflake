CREATE OR REPLACE VIEW DBO.RefInsuredContractType_VW
AS 
SELECT 	$1:InsuredEnrolleeKey::NUMBER(38, 0) AS InsuredEnrolleeKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:EmployeeCount::NUMBER(38, 0) AS EmployeeCount, 
		$1:SpouseCount::NUMBER(38, 0) AS SpouseCount, 
		$1:DependentCount::NUMBER(38, 0) AS DependentCount, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/RefInsuredContractType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
