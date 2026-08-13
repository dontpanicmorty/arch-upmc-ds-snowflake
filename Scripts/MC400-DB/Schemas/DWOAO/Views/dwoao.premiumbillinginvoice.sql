CREATE OR REPLACE VIEW DWOAO.PremiumBillingInvoice
AS
SELECT A.* from 
	cdc_merge.dbo.PremiumBillingInvoice A 
	INNER JOIN cdc_merge.dbo.CustomerMaster B ON A.CustomerRowId = B.RowId 
	INNER JOIN cdc_merge.dbo.TPACustomer C ON C.ID=B.TPAROWID AND C.TPACLIENT='000001' AND C.TPADIVISION='0001' AND C.TPAIDOFCLIENT='000001';
