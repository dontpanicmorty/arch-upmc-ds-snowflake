

CREATE OR REPLACE VIEW DWOAO.ARBalancesBilling
AS
SELECT A.* from cdc_merge.dbo.ARBalancesBilling A
INNER JOIN cdc_merge.dbo.ARBillingMaster E ON E.RowId = A.ARBillingMasterRowId
INNER JOIN cdc_merge.dbo.PremiumBillingInvoice D ON D.RowId = E.InvRowID
INNER JOIN cdc_merge.dbo.CustomerMaster B ON D.CustomerRowId = B.RowID
INNER JOIN cdc_merge.dbo.TPACustomer C ON C.ID = B.TpaRowId
WHERE C.TPACLIENT='000001' AND C.TPADIVISION='0001' AND C.TPAIDOFCLIENT='000001' 


;
