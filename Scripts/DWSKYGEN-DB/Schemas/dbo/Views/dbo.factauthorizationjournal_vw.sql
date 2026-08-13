CREATE OR REPLACE VIEW DBO.FactAuthorizationJournal_VW
AS 
SELECT 	$1:DateCreationKey::NUMBER(38, 0) AS DateCreationKey, 
		$1:DomainSourceKey::NUMBER(38, 0) AS DomainSourceKey, 
		$1:FeatureKey::NUMBER(38, 0) AS FeatureKey, 
		$1:FieldNameKey::NUMBER(38, 0) AS FieldNameKey, 
		$1:LogTypeKey::NUMBER(38, 0) AS LogTypeKey, 
		$1:ModuleKey::NUMBER(38, 0) AS ModuleKey, 
		$1:AUTHORIZATION_ID::NUMBER(38, 0) AS AUTHORIZATION_ID, 
		$1:AuthItemNumber::NUMBER(38, 0) AS AuthItemNumber, 
		$1:LOG_ID::NUMBER(38, 0) AS LOG_ID, 
		$1:LogItemNumber::NUMBER(38, 0) AS LogItemNumber, 
		$1:FIELD_VALUE::VARCHAR AS FIELD_VALUE, 
		$1:MESSAGE::VARCHAR AS MESSAGE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactAuthorizationJournal/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
