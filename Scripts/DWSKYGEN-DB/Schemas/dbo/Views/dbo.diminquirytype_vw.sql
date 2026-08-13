CREATE OR REPLACE VIEW DBO.DimInquiryType_VW
AS 
SELECT 	$1:InquiryTypeKey::NUMBER(38, 0) AS InquiryTypeKey, 
		$1:InquiryTypeID::NUMBER(38, 0) AS InquiryTypeID, 
		$1:InquiryType::VARCHAR AS InquiryType, 
		$1:InquiryCategoryID::NUMBER(38, 0) AS InquiryCategoryID, 
		$1:InquiryCategory::VARCHAR AS InquiryCategory, 
		$1:MEMBER_SERVICES_FLAG::NUMBER(38, 0) AS MEMBER_SERVICES_FLAG, 
		$1:MemberServicesInquiry::VARCHAR AS MemberServicesInquiry, 
		$1:PROVIDER_SERVICES_FLAG::NUMBER(38, 0) AS PROVIDER_SERVICES_FLAG, 
		$1:ProviderServicesInquiry::VARCHAR AS ProviderServicesInquiry, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimInquiryType/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
