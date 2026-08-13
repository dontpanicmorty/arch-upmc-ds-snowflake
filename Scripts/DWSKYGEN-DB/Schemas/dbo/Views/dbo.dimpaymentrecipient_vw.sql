CREATE OR REPLACE VIEW DBO.DimPaymentRecipient_VW
AS 
SELECT 	$1:PaymentRecipientKey::NUMBER(38, 0) AS PaymentRecipientKey, 
		$1:PAY_MEMBER_FLAG::VARCHAR::BOOLEAN AS PAY_MEMBER_FLAG, 
		$1:PaymentRecipientDescription::VARCHAR AS PaymentRecipientDescription
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/DimPaymentRecipient/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT)
;