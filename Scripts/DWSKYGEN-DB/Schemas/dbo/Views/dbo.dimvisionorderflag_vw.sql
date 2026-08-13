CREATE OR REPLACE VIEW DBO.DimVisionOrderFlag_VW
AS 
SELECT 	$1:VisionOrderFlagKey::NUMBER(38, 0) AS VisionOrderFlagKey, 
		$1:ShipToPatientFlag::NUMBER(38, 0) AS ShipToPatientFlag, 
		$1:ShipToPatientIndicator::VARCHAR AS ShipToPatientIndicator, 
		$1:LensesOnlyFlag::NUMBER(38, 0) AS LensesOnlyFlag, 
		$1:LensesOnlyIndicator::VARCHAR AS LensesOnlyIndicator, 
		$1:RedoFlag::NUMBER(38, 0) AS RedoFlag, 
		$1:RedoIndicator::VARCHAR AS RedoIndicator, 
		$1:MaterialsDueFlag::NUMBER(38, 0) AS MaterialsDueFlag, 
		$1:MaterialsDueIndicator::VARCHAR AS MaterialsDueIndicator, 
		$1:MaterialsReturnFlag::NUMBER(38, 0) AS MaterialsReturnFlag, 
		$1:MaterialsReturnIndicator::VARCHAR AS MaterialsReturnIndicator
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimVisionOrderFlag/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
