CREATE OR REPLACE VIEW DBO.DimSurface_VW
AS 
SELECT 	$1:SurfaceKey::NUMBER(38, 0) AS SurfaceKey, 
		$1:SurfaceCode::VARCHAR AS SurfaceCode, 
		$1:SurfaceDescription::VARCHAR AS SurfaceDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimSurface/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
