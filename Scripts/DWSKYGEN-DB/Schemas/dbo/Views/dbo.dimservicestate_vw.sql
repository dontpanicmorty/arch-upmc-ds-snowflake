CREATE OR REPLACE VIEW DBO.DimServiceState_VW
AS 
SELECT 	$1:ServiceStateKey::NUMBER(38, 0) AS ServiceStateKey, 
		$1:ServiceStateID::NUMBER(38, 0) AS ServiceStateID, 
		$1:ServiceStateDescription::VARCHAR AS ServiceStateDescription, 
		$1:ServiceTypeID::NUMBER(38, 0) AS ServiceTypeID, 
		$1:ServiceTypeDescription::VARCHAR AS ServiceTypeDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimServiceState/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
