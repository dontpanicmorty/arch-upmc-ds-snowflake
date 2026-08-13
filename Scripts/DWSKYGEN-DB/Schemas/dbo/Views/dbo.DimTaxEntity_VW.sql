CREATE OR REPLACE VIEW DBO.DimTaxEntity_VW
AS 
SELECT 	$1:TaxEntityKey::NUMBER(38, 0) AS TaxEntityKey, 
		$1:TAX_ID::VARCHAR AS TAX_ID, 
		$1:TaxEntityName::VARCHAR AS TaxEntityName, 
		$1:BusinessName::VARCHAR AS BusinessName, 
		$1:BusinessTypeID::NUMBER(38, 0) AS BusinessTypeID, 
		$1:BusinessTypeDescription::VARCHAR AS BusinessTypeDescription, 
		$1:TaxEntityAddress1::VARCHAR AS TaxEntityAddress1, 
		$1:TaxEntityAddress2::VARCHAR AS TaxEntityAddress2, 
		$1:TaxEntityCity::VARCHAR AS TaxEntityCity, 
		$1:TaxEntityState::VARCHAR AS TaxEntityState, 
		$1:TaxEntityZip::VARCHAR AS TaxEntityZip, 
		$1:TaxEntityZip_4::VARCHAR AS TaxEntityZip_4, 
		$1:TaxEntityVoicePhone::VARCHAR AS TaxEntityVoicePhone, 
		$1:TaxIDTypeID::NUMBER(38, 0) AS TaxIDTypeID, 
		$1:TaxIDTypeDescription::VARCHAR AS TaxIDTypeDescription, 
		$1:IsBrokerTaxEntityFlag::BOOLEAN AS IsBrokerTaxEntityFlag, 
		$1:RecordStartDate::DATE AS RecordStartDate, 
		$1:RecordEndDate::DATE AS RecordEndDate, 
		$1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTaxEntity/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);

