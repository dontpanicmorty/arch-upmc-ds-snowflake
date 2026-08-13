CREATE OR REPLACE VIEW DWDNV_NONCLAIMS.trnPremiumBillingHistory
AS
SELECT * from cdc_merge.dbo.trnPremiumBillingHistory_DNV
;
