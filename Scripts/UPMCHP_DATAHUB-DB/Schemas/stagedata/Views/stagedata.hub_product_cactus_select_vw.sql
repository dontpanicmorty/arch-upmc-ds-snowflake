CREATE OR REPLACE VIEW STAGEDATA.HUB_PRODUCT_CACTUS_SELECT_VW
COMMENT = 'This view Product contains Product data'
AS
SELECT 
       NULL AS SOURCE_KEY, 
      '000001' AS TPA_CLIENT_ID,
      '000001' AS TPA_ID,
      '0001' AS TPA_DIV_ID,
      'Cactus' AS DATA_SOURCE_NAME,
       RAWDATA.CACTUS_REFTABLE.REFTABLE_K AS PRODUCT_ID,
       TRIM(RAWDATA.CACTUS_REFTABLE.DESCRIPTION) AS PRODUCT_NAME,
       UTIL.FXN_ARRAY_HASH([
                            TPA_CLIENT_ID,
                            TPA_ID,
                            TPA_DIV_ID,
                            DATA_SOURCE_NAME,
                            PRODUCT_ID,
                            PRODUCT_NAME
                          ]) AS HUB_PRODUCT_HKEY
FROM RAWDATA.CACTUS_REFTABLE	
WHERE TRIM(REFERENCEMASTER_K) = '79'	--"79" (trimmed) is provider-level product name in ref table
AND TRIM(ENTITY_K) = 'FAC1'	--"FAC1" (trimmed) is entity used in reftable to pull values used in Cactus prod
AND DELETED <> 1	
AND ACTIVE = 1	

UNION

SELECT 
       NULL AS SOURCE_KEY, 
      '000001' AS TPA_CLIENT_ID,
      '000001' AS TPA_ID,
      '0001' AS TPA_DIV_ID,
      'Cactus' AS DATA_SOURCE_NAME,
       RAWDATA.CACTUS_REFTABLE.REFTABLE_K AS PRODUCT_ID,
       TRIM(RAWDATA.CACTUS_REFTABLE.DESCRIPTION) AS PRODUCT_NAME,
       UTIL.FXN_ARRAY_HASH([
                            TPA_CLIENT_ID,
                            TPA_ID,
                            TPA_DIV_ID,
                            DATA_SOURCE_NAME,
                            PRODUCT_ID,
                            PRODUCT_NAME
                          ]) AS HUB_PRODUCT_HKEY
FROM RAWDATA.CACTUS_REFTABLE	
WHERE TRIM(REFERENCEMASTER_K) = 'GRUPIDUDF1'	--"GRUPIDUDF1" (trimmed) is group-level product name in ref table
AND TRIM(ENTITY_K) = 'FAC1'	--"FAC1" (trimmed) is entity used in reftable to pull values used in Cactus prod
AND DELETED <> 1	
AND ACTIVE = 1	
;




