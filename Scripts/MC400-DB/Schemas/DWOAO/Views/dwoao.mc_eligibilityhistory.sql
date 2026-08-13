CREATE OR REPLACE VIEW DWOAO.MC_EligibilityHistory
AS
SELECT * From EligibilityHistory Where PlanType IN('C','F','M','Q','R','S','T','U','V','G') AND TPACLIENT = '000001' AND TPADIVISION = '0001' AND TPAIDOFCLIENT = '000001'
;
