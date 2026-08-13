CREATE OR REPLACE VIEW DBO.Table_Processing_Reconciliation_VW
AS 
SELECT 	$1:Loadkey::NUMBER(38, 0) AS Loadkey, 
		$1:TABLE_SCHEMA::VARCHAR AS TABLE_SCHEMA, 
		$1:TABLE_NAME::VARCHAR AS TABLE_NAME, 
		$1:ROW_COUNT::NUMBER(38, 0) AS ROW_COUNT, 
		$1:LoadEndDateTime::TIMESTAMP_NTZ AS LoadEndDateTime, 
		$1:SourceCount::NUMBER(38, 0) AS SourceCount, 
		$1:TotalCount_MinusDefaultValues::NUMBER(38, 0) AS TotalCount_MinusDefaultValues, 
		$1:Variance::NUMBER(38, 0) AS Variance
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/Table_Processing_Reconciliation/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
