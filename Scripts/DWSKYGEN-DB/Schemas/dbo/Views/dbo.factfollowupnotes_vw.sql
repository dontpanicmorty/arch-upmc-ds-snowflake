CREATE OR REPLACE VIEW DBO.FactFollowUpNotes_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:ClientKey::NUMBER(38, 0) AS ClientKey, 
		$1:CommunicationTypeKey::NUMBER(38, 0) AS CommunicationTypeKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:FollowUpStatusKey::NUMBER(38, 0) AS FollowUpStatusKey, 
		$1:DateCallStartKey::NUMBER(38, 0) AS DateCallStartKey, 
		$1:DateNoteCreateKey::NUMBER(38, 0) AS DateNoteCreateKey, 
		$1:DateResolutionKey::NUMBER(38, 0) AS DateResolutionKey, 
		$1:CommunicationDomainSourceKey::NUMBER(38, 0) AS CommunicationDomainSourceKey, 
		$1:NotesDomainSourceKey::NUMBER(38, 0) AS NotesDomainSourceKey, 
		$1:InquiryTypeKey::NUMBER(38, 0) AS InquiryTypeKey, 
		$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:COMMUNICATION_ID::NUMBER(38, 0) AS COMMUNICATION_ID, 
		$1:FOLLOWUP_ID::NUMBER(38, 0) AS FOLLOWUP_ID, 
		$1:NOTE_ID::NUMBER(38, 0) AS NOTE_ID, 
		$1:AUTHORIZATION_REF::VARCHAR AS AUTHORIZATION_REF, 
		$1:ENCOUNTER_REF::VARCHAR AS ENCOUNTER_REF, 
		$1:PROVIDER_REF::VARCHAR AS PROVIDER_REF, 
		$1:APPEAL_ID::NUMBER(38, 0) AS APPEAL_ID, 
		$1:LONG_NOTES::VARCHAR AS LONG_NOTES, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactFollowUpNotes/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
