CREATE OR REPLACE VIEW DBO.DimTime_VW
AS 
SELECT 	$1:TimeKey::NUMBER(38, 0) AS TimeKey, 
		$1:HourOfDay24::NUMBER(38, 0) AS HourOfDay24, 
		$1:HourOfDay12::NUMBER(38, 0) AS HourOfDay12, 
		$1:AM_PM::VARCHAR AS AM_PM, 
		$1:MinuteOfHour::NUMBER(38, 0) AS MinuteOfHour, 
		$1:HalfHour::NUMBER(38, 0) AS HalfHour, 
		$1:HalfHourOfDay::NUMBER(38, 0) AS HalfHourOfDay, 
		$1:QuarterHour::NUMBER(38, 0) AS QuarterHour, 
		$1:QuarterHourOfDay::NUMBER(38, 0) AS QuarterHourOfDay, 
		$1:HourMinute24::VARCHAR AS HourMinute24, 
		$1:HourMinute12::VARCHAR AS HourMinute12
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimTime/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
