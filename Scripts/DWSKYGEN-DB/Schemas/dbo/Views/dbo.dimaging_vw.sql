CREATE OR REPLACE VIEW DBO.DimAging_VW
AS 
SELECT 	$1:AgingKey::NUMBER(38, 0) AS AgingKey, 
		$1:TurnaroundDay::NUMBER(38, 0) AS TurnaroundDay, 
		$1:AgingRangeID::NUMBER(38, 0) AS AgingRangeID, 
		$1:AgingRange::VARCHAR AS AgingRange, 
		$1:AgingRange2ID::NUMBER(38, 0) AS AgingRange2ID, 
		$1:AgingRange2::VARCHAR AS AgingRange2
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAging/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
