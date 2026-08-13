

CREATE OR REPLACE VIEW DWDNV_NONCLAIMS.ARTransactionDetail
AS
SELECT A.* from cdc_merge.dbo.ARTransactionDetail A 
INNER JOIN cdc_merge.dbo.ARTransactionHeader B ON B.RowId = A.HeaderRowId
INNER JOIN CDC_Merge.dbo.ARAdjustmentsBatchHeader C ON C.RowId = B.BatchRowId
INNER JOIN cdc_merge.dbo.TPACustomer D ON D.id = C.TpaRowId
WHERE TPACLIENT='000001' AND TPADIVISION='0002' AND TPAIDOFCLIENT='000001' 



;
