CREATE OR REPLACE VIEW DBO.FactCommunicationInquiries_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateKey::NUMBER(38, 0) AS DateKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:InquiryTypeKey::NUMBER(38, 0) AS InquiryTypeKey, 
		$1:LocationKey::NUMBER(38, 0) AS LocationKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:INQUIRY_ID::NUMBER(38, 0) AS INQUIRY_ID, 
		$1:CommunicationID::NUMBER(38, 0) AS CommunicationID, 
		$1:InquiryCount::NUMBER(38, 0) AS InquiryCount, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactCommunicationInquiries/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
