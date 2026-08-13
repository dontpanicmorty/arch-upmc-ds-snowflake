CREATE OR REPLACE VIEW DWDNV_NONCLAIMS.PremiumBillingInvoice
AS
SELECT A.* from 
	cdc_merge.dbo.PremiumBillingInvoice A 
	INNER JOIN cdc_merge.dbo.CustomerMaster B ON A.CustomerRowId = B.RowId 
	INNER JOIN cdc_merge.dbo.TPACustomer C ON C.ID=B.TPAROWID AND C.TPACLIENT='000001' AND C.TPADIVISION='0002' AND C.TPAIDOFCLIENT='000001';
