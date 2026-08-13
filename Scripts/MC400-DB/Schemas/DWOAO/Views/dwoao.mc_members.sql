CREATE OR REPLACE VIEW DWOAO.MC_Members
AS
SELECT Distinct A.* From Members A, EligibilityHistory B Where A.MemberNbr = B.MemberNbr AND A.TPADIVISION=B.TPADIVISION And B.PlanType IN('C','F','M','Q','R','S','T','U','V','G') AND A.TPACLIENT = '000001' AND A.TPADIVISION = '0001' AND A.TPAIDOFCLIENT = '000001'
;
