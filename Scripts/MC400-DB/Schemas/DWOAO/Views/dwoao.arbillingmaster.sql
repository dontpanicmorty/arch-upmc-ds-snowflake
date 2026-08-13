

CREATE OR REPLACE VIEW DWOAO.ARBillingMaster
AS
SELECT A.* from cdc_merge.dbo.ARBillingMaster A
INNER JOIN cdc_merge.dbo.PremiumBillingInvoice B ON B.RowID = A.InvRowID
INNER JOIN CDC_Merge.dbo.CustomerMaster C ON C.RowID= B.CustomerRowId
INNER JOIN cdc_merge.dbo.TPACustomer D ON D.ID = c.TPARowID
WHERE D.TPACLIENT='000001' AND D.TPADIVISION='0001' AND D.TPAIDOFCLIENT='000001' 

;
