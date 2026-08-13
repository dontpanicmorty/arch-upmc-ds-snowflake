CREATE OR REPLACE VIEW DBO.DimBoardCertification_VW
AS 
SELECT 	$1:BoardCertificationKey::NUMBER(38, 0) AS BoardCertificationKey, 
		$1:BOARD_CERTIFICATION_ID::NUMBER(38, 0) AS BOARD_CERTIFICATION_ID, 
		$1:BoardCertificationDescription::VARCHAR AS BoardCertificationDescription, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimBoardCertification/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
