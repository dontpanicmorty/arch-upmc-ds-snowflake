CREATE OR REPLACE VIEW DBO.DimCommissionType_VW
AS 
SELECT 	$1:CommissionTypeKey::NUMBER(38, 0) AS CommissionTypeKey, 
		$1:CommissionTypeDescription::VARCHAR AS CommissionTypeDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimCommissionType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
