

CREATE OR REPLACE VIEW DWDNV_NONCLAIMS.CashReceiptsHeader
AS
SELECT A.* from cdc_merge.dbo.CashReceiptsHeader A 
INNER JOIN cdc_merge.dbo.ARCashBatchControl B ON B.RowId = A.CashBatchRowId
INNER JOIN cdc_merge.dbo.TPACustomer C ON C.ID = B.TPACLIENTPROWID
WHERE C.TPACLIENT='000001' AND C.TPADIVISION='0002' AND C.TPAIDOFCLIENT='000001' 



;
