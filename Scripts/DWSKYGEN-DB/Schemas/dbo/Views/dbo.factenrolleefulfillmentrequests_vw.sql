CREATE OR REPLACE VIEW DBO.FactEnrolleeFulfillmentRequests_VW
AS 
SELECT 	$1:BenefitPlanKey::NUMBER(38, 0) AS BenefitPlanKey, 
		$1:DateRequestKey::NUMBER(38, 0) AS DateRequestKey, 
		$1:DateSentToMemberKey::NUMBER(38, 0) AS DateSentToMemberKey, 
		$1:DateSentToVendorKey::NUMBER(38, 0) AS DateSentToVendorKey, 
		$1:EnrolleeKey::NUMBER(38, 0) AS EnrolleeKey, 
		$1:FulfillmentTypeKey::NUMBER(38, 0) AS FulfillmentTypeKey, 
		$1:FulfillmentSourceKey::NUMBER(38, 0) AS FulfillmentSourceKey, 
		$1:ENROLLEE_FULFILLMENT_REQUEST_ID::NUMBER(38, 0) AS ENROLLEE_FULFILLMENT_REQUEST_ID, 
		$1:Document_Count::NUMBER(38, 0) AS Document_Count, 
		$1:Partition::NUMBER(38, 0) AS Partition, 
		$1:RecordUpdateDatetime::TIMESTAMP_NTZ AS RecordUpdateDatetime
FROM 	'@DBO.HPDSDATALAKE_DBEXTRACT_DWSKYGEN/dbo/FactEnrolleeFulfillmentRequests/'
		( FILE_FORMAT => DBO.DWSKYGEN_PARQUET_FILE_FORMAT);
