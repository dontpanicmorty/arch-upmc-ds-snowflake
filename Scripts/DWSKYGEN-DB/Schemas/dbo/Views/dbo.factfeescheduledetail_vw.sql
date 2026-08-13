CREATE OR REPLACE VIEW DBO.FactFeeScheduleDetail_VW
AS 
SELECT 	$1:AgeMinKey::NUMBER(38, 0) AS AgeMinKey, 
		$1:AgeMaxKey::NUMBER(38, 0) AS AgeMaxKey, 
		$1:CodeKey::NUMBER(38, 0) AS CodeKey, 
		$1:DateEffectiveKey::NUMBER(38, 0) AS DateEffectiveKey, 
		$1:DateTerminationKey::NUMBER(38, 0) AS DateTerminationKey, 
		$1:FeeScheduleKey::NUMBER(38, 0) AS FeeScheduleKey, 
		$1:PlaceOfServiceTypeKey::NUMBER(38, 0) AS PlaceOfServiceTypeKey, 
		$1:SubcodeKey::NUMBER(38, 0) AS SubcodeKey, 
		$1:ToothKey::NUMBER(38, 0) AS ToothKey, 
		$1:FEE_SCHEDULE_ID::NUMBER(38, 0) AS FEE_SCHEDULE_ID, 
		$1:GENDER::VARCHAR AS GENDER, 
		$1:UNITS_FROM::NUMBER(38, 0) AS UNITS_FROM, 
		$1:UNITS_TO::NUMBER(38, 0) AS UNITS_TO, 
		$1:VALUE::NUMBER(19, 4) AS VALUE, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime--, 
		--$1:DW_Hash::VARCHAR AS DW_Hash
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactFeeScheduleDetail/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
