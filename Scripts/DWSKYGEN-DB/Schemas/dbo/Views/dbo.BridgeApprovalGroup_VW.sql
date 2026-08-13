CREATE OR REPLACE VIEW DBO.BridgeApprovalGroup_VW
AS 
SELECT 	$1:ApprovalGroupKey::NUMBER(38, 0) AS ApprovalGroupKey, 
		$1:ApprovalCodeKey::NUMBER(38, 0) AS ApprovalCodeKey, 
		$1:RecordCreateDatetime::TIMESTAMP_NTZ AS RecordCreateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/BridgeApprovalGroup/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
