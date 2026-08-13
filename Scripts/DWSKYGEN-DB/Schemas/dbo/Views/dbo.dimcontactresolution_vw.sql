CREATE OR REPLACE VIEW DBO.DimContactResolution_VW
AS 
SELECT 	$1:ContactResolutionKey::NUMBER(38, 0) AS ContactResolutionKey, 
		$1:ContactResolution::NUMBER(38, 0) AS ContactResolution, 
		$1:ContactResolutionDescription::VARCHAR AS ContactResolutionDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimContactResolution/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
