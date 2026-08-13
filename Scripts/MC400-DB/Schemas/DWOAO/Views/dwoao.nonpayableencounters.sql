CREATE  OR REPLACE VIEW DWOAO.NonPayableEncounters (APPostingDate, 
APSourceFileType, 
BankAccountCode, 
CheckDate, 
CheckNumber, 
CompanyCode, 
CoverageGroupCode, 
DateRecordAdded, 
DueDate, 
EncounterReportedIndicator, 
KeytoSourceFile, 
NetPayableAmount, 
PayStatus, 
SubgroupCode, 
VendorNumber, 
LastUpdated, 
LastApplied, 
DeletedFlag, 
NonPayableEncountersSeqNbr, 
ClaimSequence, 
CHGLAST, 
CHGORIG, 
CHGUSER, 
TPACLIENT, 
TPADIVISION, 
TPAIDOFCLIENT,
APCheckRunBatch,
AssociatedBankCode,
RemittanceAdviceDate) AS 
-- HNPAYP - APWORKP
SELECT
APW.PostDate, -- APPostingDate
APW.FileType, --APSourceFileType
APW.BankCode, --BankAccountCode
0 AS CheckDate,--CheckDate
'' AS CheckNbr,--CheckNumber
APW.CompCode,--CompanyCode
C.GroupNbr, --CoverageGroupCode
TO_NUMBER(CD.AddDate) as DateRecordAdded , --DateRecordAdded
APW.ClaimsDetailReceiveDate, --DueDate
CASE APW.NonEncCap WHEN 'X' THEN '4'  ELSE '' END AS NonEncCap , --EncounterReportedIndicator
CD.KeytoSourceFile, --KeytoSourceFile
APW.Amount, --NetPayableAmount
IFF ( APW.NonEncCap = 'X','X',
CASE APW.Status 
WHEN 'EC' THEN '0'
WHEN 'SL' THEN '1'
WHEN 'RD'  THEN '2'
WHEN 'PD' THEN '3' 
WHEN 'NP' THEN '4'
ELSE APW.Status 
END ) AS PayStatus, -- PayStatus (Use case stmt to match with latest values)
C.SubGroup,--SubgroupCode
APW.VendorNo ,--VendorNumber
APW.LastUpdated,
APW.LastApplied,
APW.DeletedFlag,
APW.APWorkSeqNbr,--NonPayableEncountersSeqNbr
CD.ClaimSequence,--ClaimSequence
APW.CHGLAST,
APW.CHGORIG,
APW.CHGUSER,
TPA.TPACLIENT,
TPA.TPADIVISION,
TPA.TPAIDOFCLIENT,
APW.BatchNumber,--APCheckRunBatch
APW.BankCode,--AssociatedBankCode
TO_NUMBER(CASE SystemTimeStamp WHEN '0001-01-01 00:00:00.0000000' THEN 0 ELSE 0 END) AS RemittanceAdviceDate--CONVERT(INT,APP.SystemTimeStamp) --RemittanceAdviceDate 
FROM DWOAO.APWork APW
LEFT OUTER JOIN DWOAO.ClaimsDetail CD ON 
APW.FileType = CD.ClaimType AND (CASE APW.FileType WHEN 'I' THEN APW.HinsdpRowID
WHEN 'E' THEN APW.HencdpRowID END ) = CD.RowId
LEFT OUTER JOIN DWOAO.Claims C ON C.ClaimNbr= CD.ClaimNbr
LEFT OUTER JOIN DWOAO.TPACustomer TPA on TPA.ID = APW.TPARowID
WHERE APW.RecIdent= '02'
UNION ALL
--HNPAYP - APPAYP
SELECT
APP.PostDate, -- APPostingDate
APP.FileType, --APSourceFileType
APP.BankCode, --BankAccountCode
APP.CheckDate,--CheckDate
APP.CheckNbr,--CheckNumber
APP.CompCode,--CompanyCode
C.GroupNbr, --CoverageGroupCode
TO_NUMBER(CD.AddDate) as DateRecordAdded , --DateRecordAdded
APP.ClaimsDetailReceiveDate, --DueDate
CASE APP.NonEncCap WHEN 'X' THEN '4'  ELSE '' END AS NonEncCap , --EncounterReportedIndicator
CD.KeytoSourceFile, --KeytoSourceFile
APP.Amount, --NetPayableAmount
IFF ( APP.NonEncCap = 'X','X',
CASE APP.Status 
WHEN 'EC' THEN '0'
WHEN 'SL' THEN '1'
WHEN 'RD'  THEN '2'
WHEN 'PD' THEN '3' 
WHEN 'NP' THEN '4'
ELSE APP.Status 
END ) AS PayStatus, -- PayStatus (Use case stmt to match with latest values)
C.SubGroup,--SubgroupCode
APP.VendorNo ,--VendorNumber
APP.LastUpdated,
APP.LastApplied,
APP.DeletedFlag,
APP.APPermanentPaymentSeqNbr,--NonPayableEncountersSeqNbr
CD.ClaimSequence,--ClaimSequence
APP.CHGLAST,
APP.CHGORIG,
APP.CHGUSER,
TPA.TPACLIENT,
TPA.TPADIVISION,
TPA.TPAIDOFCLIENT,
APP.BatchNbr,--APCheckRunBatch
APP.BankCode,--AssociatedBankCode
TO_NUMBER(CASE SystemTimeStamp WHEN '0001-01-01 00:00:00.0000000' THEN 0 ELSE 0 END) AS RemittanceAdviceDate--CONVERT(INT,APP.SystemTimeStamp) --RemittanceAdviceDate 
FROM DWOAO.APPermanentPayment APP
LEFT OUTER JOIN DWOAO.ClaimsDetail CD ON 
APP.FileType = CD.ClaimType AND APP.TableRowId= CD.RowId
LEFT OUTER JOIN DWOAO.Claims C ON C.ClaimNbr= CD.ClaimNbr
LEFT OUTER JOIN DWOAO.TPACustomer TPA on TPA.ID = APP.TPARowID
WHERE APP.RecIdent= '02';