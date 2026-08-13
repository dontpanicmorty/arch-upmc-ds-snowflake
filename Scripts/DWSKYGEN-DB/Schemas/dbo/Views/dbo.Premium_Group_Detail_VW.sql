CREATE OR REPLACE VIEW DBO.Premium_group_Detail_VW
AS 
SELECT 	$1:PremiumGroupKey::NUMBER(38, 0) AS PremiumGroupKey, 
		$1:premium_group_ID::NUMBER(38, 0) AS premium_group_ID, 
		$1:Company_Code::VARCHAR AS Company_Code, 
		$1:CorpID::VARCHAR AS CorpID, 
		$1:Group_Number::VARCHAR AS Group_Number, 
		$1:SubGroup::VARCHAR AS SubGroup, 
		$1:Plan_Type::VARCHAR AS Plan_Type, 
		$1:Plan_Code::VARCHAR AS Plan_Code, 
		$1:Rider::VARCHAR AS Rider, 
		$1:notes::VARCHAR AS notes, 
		$1:effective_date::DATE AS effective_date, 
		$1:termination_date::DATE AS termination_date, 
		$1:creation_date::DATE AS creation_date, 
		$1:job_ID::NUMBER(38, 0) AS job_ID, 
		$1:FileName::VARCHAR AS Filename
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/Premium_group_Detail/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
