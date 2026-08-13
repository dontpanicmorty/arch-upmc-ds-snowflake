CREATE OR REPLACE VIEW DBO.FactProviderBoardCertification_VW
AS 
SELECT 	$1:ProviderKey::NUMBER(38, 0) AS ProviderKey, 
		$1:BoardCertificationKey::NUMBER(38, 0) AS BoardCertificationKey, 
		$1:DateCertificationKey::NUMBER(38, 0) AS DateCertificationKey, 
		$1:DateExpirationKey::NUMBER(38, 0) AS DateExpirationKey, 
		$1:PROVIDER_BOARD_CERTIFICATION_ID::NUMBER(38, 0) AS PROVIDER_BOARD_CERTIFICATION_ID, 
		$1:BOARD_NAME::VARCHAR AS BOARD_NAME, 
		$1:CERTIFICATION_DATE::DATE AS CERTIFICATION_DATE, 
		$1:EXPIRATION_DATE::DATE AS EXPIRATION_DATE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		--$1:DW_Hash::VARCHAR AS DW_Hash, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactProviderBoardCertification/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
