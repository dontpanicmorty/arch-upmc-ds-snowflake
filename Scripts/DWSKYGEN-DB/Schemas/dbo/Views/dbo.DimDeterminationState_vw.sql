CREATE OR REPLACE VIEW DBO.DimDeterminationState_VW
AS 
SELECT 	$1:DeterminationStateKey::NUMBER(38, 0) AS DeterminationStateKey, 
		$1:ServiceDeterminationStatusID::NUMBER(38, 0) AS ServiceDeterminationStatusID, 
		$1:ServiceDeterminationStatusDescription::VARCHAR AS ServiceDeterminationStatusDescription, 
		$1:AuthorizationDeterminationStatusID::NUMBER(38, 0) AS AuthorizationDeterminationStatusID, 
		$1:AuthorizationDeterminationStatusDescription::VARCHAR AS AuthorizationDeterminationStatusDescription, 
		$1:AuthorizationDeterminationGroupID::NUMBER(38, 0) AS AuthorizationDeterminationGroupID, 
		$1:AuthorizationDeterminationGroupDescription::VARCHAR AS AuthorizationDeterminationGroupDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimDeterminationState/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
