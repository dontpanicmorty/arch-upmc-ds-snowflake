CREATE OR REPLACE VIEW DBO.DimTooth_VW
AS 
SELECT 	$1:ToothKey::NUMBER(38, 0) AS ToothKey, 
		$1:SUBCODE::VARCHAR AS SUBCODE, 
		$1:DentitionGroup::NUMBER(38, 0) AS DentitionGroup, 
		$1:DentitionGroupName::VARCHAR AS DentitionGroupName, 
		$1:ToothID::VARCHAR AS ToothID, 
		$1:Quadrant::VARCHAR AS Quadrant, 
		$1:Arch::VARCHAR AS Arch, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTooth/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
