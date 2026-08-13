CREATE OR REPLACE VIEW DBO.FactCommunications_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:CommunicationTypeKey::NUMBER(38, 0) AS CommunicationTypeKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:InquiryTypeKey::NUMBER(38, 0) AS InquiryTypeKey, 
		$1:MemberDemographicKey::NUMBER(38, 0) AS MemberDemographicKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:DateKey::NUMBER(38, 0) AS DateKey, 
		$1:ContactResolutionKey::NUMBER(38, 0) AS ContactResolutionKey, 
		$1:CommunicationID::NUMBER(38, 0) AS CommunicationID, 
		$1:FollowUpFlag::BOOLEAN AS FollowUpFlag, 
		$1:CALL_START_TIME::TIMESTAMP_NTZ AS CALL_START_TIME, 
		$1:CALL_END_TIME::TIMESTAMP_NTZ AS CALL_END_TIME, 
		$1:CommunicationCount::NUMBER(38, 0) AS CommunicationCount, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactCommunications/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
