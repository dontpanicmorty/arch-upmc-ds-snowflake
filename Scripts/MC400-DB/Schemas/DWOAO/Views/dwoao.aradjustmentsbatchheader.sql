

CREATE OR REPLACE VIEW DWOAO.ARAdjustmentsBatchHeader
AS
SELECT A.* from cdc_merge.dbo.ARAdjustmentsBatchHeader A 
INNER JOIN cdc_merge.dbo.TPACustomer B ON B.id = A.TpaRowId
WHERE TPACLIENT='000001' AND TPADIVISION='0001' AND TPAIDOFCLIENT='000001' 



;
