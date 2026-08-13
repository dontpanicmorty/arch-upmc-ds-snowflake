

CREATE OR REPLACE VIEW DWOAO.ARTransactionHeader
AS
SELECT A.* from cdc_merge.dbo.ARTransactionHeader A 
INNER JOIN cdc_merge.dbo.ARAdjustmentsBatchHeader B ON B.RowId = A.BatchRowId
INNER JOIN cdc_merge.dbo.TPACustomer C ON C.id = B.TpaRowId
WHERE TPACLIENT='000001' AND TPADIVISION='0001' AND TPAIDOFCLIENT='000001' 
;
