CREATE OR REPLACE VIEW DBO.DimClaimType_VW
AS 
SELECT 	$1:ClaimTypeKey::NUMBER(38, 0) AS ClaimTypeKey, 
		$1:ClaimTypeID::NUMBER(38, 0) AS ClaimTypeID, 
		$1:ClaimType::VARCHAR AS ClaimType, 
		$1:ClaimCategoryID::NUMBER(38, 0) AS ClaimCategoryID, 
		$1:ClaimCategory::VARCHAR AS ClaimCategory, 
		$1:TOB_ClassificationID::NUMBER(38, 0) AS TOB_ClassificationID, 
		$1:TOB_Classification::VARCHAR AS TOB_Classification, 
		$1:TOB_FacilityID::NUMBER(38, 0) AS TOB_FacilityID, 
		$1:TOB_Facility::VARCHAR AS TOB_Facility, 
		$1:TOB_FrequencyID::VARCHAR AS TOB_FrequencyID, 
		$1:TOB_Frequency::VARCHAR AS TOB_Frequency, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimClaimType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
