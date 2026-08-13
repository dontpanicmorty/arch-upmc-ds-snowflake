CREATE OR REPLACE VIEW DBO.FactClaimInventory_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:ClaimInventoryTypeKey::NUMBER(38, 0) AS ClaimInventoryTypeKey, 
		$1:DateOfServiceKey::NUMBER(38, 0) AS DateOfServiceKey, 
		$1:DateReceivedKey::NUMBER(38, 0) AS DateReceivedKey, 
		$1:DateResolutionKey::NUMBER(38, 0) AS DateResolutionKey, 
		$1:DeletedFlagKey::NUMBER(38, 0) AS DeletedFlagKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:InventoryClaimTypeKey::NUMBER(38, 0) AS InventoryClaimTypeKey, 
		$1:PaymentRecipientKey::NUMBER(38, 0) AS PaymentRecipientKey, 
		$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:RecordSourceKey::NUMBER(38, 0) AS RecordSourceKey, 
		$1:ResolutionTypeKey::NUMBER(38, 0) AS ResolutionTypeKey, 
		$1:TaxEntityKey::NUMBER(38, 0) AS TaxEntityKey, 
		$1:CLAIM_INVENTORY_ID::NUMBER(38, 0) AS CLAIM_INVENTORY_ID, 
		$1:ENCOUNTER_ID::VARCHAR AS ENCOUNTER_ID, 
		$1:SUBSCRIBER_ID::VARCHAR AS SUBSCRIBER_ID, 
		$1:MEMBER_ID::VARCHAR AS MEMBER_ID, 
		$1:AUTHORIZATION_NUMBER::VARCHAR AS AUTHORIZATION_NUMBER, 
		$1:LAST_MODIFIED_DATE::TIMESTAMP_NTZ AS LAST_MODIFIED_DATE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactClaimInventory/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
