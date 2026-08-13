CREATE OR REPLACE VIEW DBO.DimDeterminationReason_VW
AS 
SELECT 	$1:DeterminationReasonKey::NUMBER(38, 0) AS DeterminationReasonKey, 
		$1:DETERMINATION_REASON_CODE_ID::NUMBER(38, 0) AS DETERMINATION_REASON_CODE_ID, 
		$1:DeterminationTypeID::NUMBER(38, 0) AS DeterminationTypeID, 
		$1:DeterminationType::VARCHAR AS DeterminationType, 
		$1:DeterminationReasonGroupID::NUMBER(38, 0) AS DeterminationReasonGroupID, 
		$1:DeterminationReasonGroup::VARCHAR AS DeterminationReasonGroup, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDeterminationReason/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
