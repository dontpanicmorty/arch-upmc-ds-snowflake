CREATE OR REPLACE VIEW DBO.DimAuthorizationFlag_VW
AS 
SELECT 	$1:AuthorizationFlagKey::NUMBER(38, 0) AS AuthorizationFlagKey, 
		$1:INCOMPLETE_AUTH_FLAG::NUMBER(38, 0) AS INCOMPLETE_AUTH_FLAG, 
		$1:IncompleteAuthorizationIndicator::VARCHAR AS IncompleteAuthorizationIndicator, 
		$1:ORTHODONTIC_TREATMENT_FLAG::NUMBER(38, 0) AS ORTHODONTIC_TREATMENT_FLAG, 
		$1:OrthodonticTreatmentIndicator::VARCHAR AS OrthodonticTreatmentIndicator, 
		$1:OUT_OF_AREA_INDICATOR_FLAG::NUMBER(38, 0) AS OUT_OF_AREA_INDICATOR_FLAG, 
		$1:OutOfAreaIndicator::VARCHAR AS OutOfAreaIndicator, 
		$1:RELATED_TO_AUTO_ACCIDENT_FLAG::NUMBER(38, 0) AS RELATED_TO_AUTO_ACCIDENT_FLAG, 
		$1:RelatedToAutoAccidentIndicator::VARCHAR AS RelatedToAutoAccidentIndicator, 
		$1:RELATED_TO_EMPLOYMENT_FLAG::NUMBER(38, 0) AS RELATED_TO_EMPLOYMENT_FLAG, 
		$1:RelatedToEmploymentIndicator::VARCHAR AS RelatedToEmploymentIndicator, 
		$1:RELATED_TO_OTHER_ACCIDENT_FLAG::NUMBER(38, 0) AS RELATED_TO_OTHER_ACCIDENT_FLAG, 
		$1:RelatedToOtherAccidentIndicator::VARCHAR AS RelatedToOtherAccidentIndicator
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimAuthorizationFlag/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
