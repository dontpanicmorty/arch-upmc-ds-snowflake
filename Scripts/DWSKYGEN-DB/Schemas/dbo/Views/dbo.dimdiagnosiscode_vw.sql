CREATE OR REPLACE VIEW DBO.DimDiagnosisCode_VW
AS 
SELECT 	$1:DiagnosisCodeKey::NUMBER(38, 0) AS DiagnosisCodeKey, 
		$1:DIAGNOSIS_CODE::VARCHAR AS DIAGNOSIS_CODE, 
		$1:DiagnosisDescription::VARCHAR AS DiagnosisDescription, 
		$1:CodeTypeID::NUMBER(38, 0) AS CodeTypeID, 
		$1:CodeTypeDescription::VARCHAR AS CodeTypeDescription, 
		$1:DiagnosisGroupID::VARCHAR AS DiagnosisGroupID, 
		$1:DiagnosisGroupDescription::VARCHAR AS DiagnosisGroupDescription, 
		$1:DiagnosisTypeID::NUMBER(38, 0) AS DiagnosisTypeID, 
		$1:DiagnosisTypeDescription::VARCHAR AS DiagnosisTypeDescription, 
		$1:DiagnosisCategoryID::NUMBER(38, 0) AS DiagnosisCategoryID, 
		$1:DiagnosisCategoryDescription::VARCHAR AS DiagnosisCategoryDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDiagnosisCode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
