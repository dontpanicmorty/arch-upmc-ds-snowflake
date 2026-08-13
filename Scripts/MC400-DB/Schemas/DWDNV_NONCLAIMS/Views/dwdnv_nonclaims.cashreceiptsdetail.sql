

CREATE OR REPLACE VIEW DWDNV_NONCLAIMS.CashReceiptsDetail
AS
SELECT A.* from cdc_merge.dbo.CashReceiptsDetail A
INNER JOIN CDC_Merge.dbo.CashReceiptsHeader C ON C.RowID=A.CashHeaderId
INNER JOIN cdc_merge.dbo.ARCashBatchControl B ON B.RowId = C.CashBatchRowId
INNER JOIN cdc_merge.dbo.TPACustomer D ON D.ID = B.TPACLIENTPROWID
WHERE D.TPACLIENT='000001' AND D.TPADIVISION='0002' AND D.TPAIDOFCLIENT='000001' 



;
