CREATE OR REPLACE VIEW DBO.DimClaimAdjudication_VW
AS 
SELECT 	$1:ClaimAdjudicationKey::NUMBER(38, 0) AS ClaimAdjudicationKey, 
		$1:ManualAdjudicatedID::NUMBER(38, 0) AS ManualAdjudicatedID, 
		$1:ManualAdjudicated::VARCHAR AS ManualAdjudicated, 
		$1:FirstPassID::NUMBER(38, 0) AS FirstPassID, 
		$1:FirstPass::VARCHAR AS FirstPass
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClaimAdjudication/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
