CREATE OR REPLACE VIEW DBO.DimCallerType_VW
AS 
SELECT 	$1:CallerTypeKey::NUMBER(38, 0) AS CallerTypeKey, 
		$1:CallerTypeID::NUMBER(38, 0) AS CallerTypeID, 
		$1:CallerTypeDescription::VARCHAR AS CallerTypeDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCallerType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
