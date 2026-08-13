CREATE OR REPLACE VIEW DBO.DimPublicTransportationMode_VW
AS 
SELECT 	$1:PublicTransportationModeKey::NUMBER(38, 0) AS PublicTransportationModeKey, 
		$1:PUBLIC_TRANSPORTATION_MODE::NUMBER(38, 0) AS PUBLIC_TRANSPORTATION_MODE, 
		$1:PublicTransportationModeDescription::VARCHAR AS PublicTransportationModeDescription,
        $1:RecordStartDate::DATE AS RecordStartDate,
        $1:RecordEndDate::DATE AS RecordEndDate,
        $1:RecordIsCurrent::BOOLEAN AS RecordIsCurrent,
        $1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime,
        $1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPublicTransportationMode/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
