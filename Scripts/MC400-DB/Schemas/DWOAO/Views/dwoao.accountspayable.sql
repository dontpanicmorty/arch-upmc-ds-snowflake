create or replace view DWOAO.ACCOUNTSPAYABLE(
	ADDRESSSEQUENCENBR,
	APPOSTINGDATE,
	APSOURCEFILETYPE,
	BANKACCOUNTCODE,
	CHECKDATE,
	CHECKNBR,
	COMPANYCODE,
	COSTCENTERNBR,
	DATERECORDADDED,
	DISCCOSTCENTERNBR,
	DISCOUNTAMT,
	DUEDATE,
	FLAGFOR1099TAXFORM,
	GLDISTRIBUTIONCODE,
	GLMONTHYYYYMM,
	GLNBR,
	GPDISCGLNBR,
	GROSSAMT,
	KEYTOSOURCEFILE,
	NETPAYABLEAMT,
	OFFSETCOSTCENTER,
	OFFSETGLACCOUNTNBR,
	PAYSTATUS,
	VENDORNBR,
	LASTUPDATED,
	LASTAPPLIED,
	DELETEDFLAG,
	ACCOUNTSPAYABLESEQNBR,
	COVERAGEGROUPCODE,
	INTERESTAMOUNT,
	INTERESTCOSTCENTER,
	INTERESTGLACCOUNT,
	SUBGROUPCODE,
	CLAIMSEQUENCE,
	CVPHISTEXTRTMSTMP,
	HIAGLACCT1,
	HIAGLDISTCOD,
	HIAPAIDAMT,
	HRAGLACCT1,
	HRAGLDISTCOD,
	HRAPAIDAMT,
	INSERTTIMESTAMP,
	INSERTUSER,
	LASTCHANGEUSER,
	LASTCHGTIMESTAMP,
	HIAGLACCT2,
	HRAGLACCT2,
	INTERESTOFFSETCOSTCENTER,
	INTERESTOFFSETGLACCOUNT,
	REMITTANCEADVICEDATE,
	XXXGLACCT1,
	XXXGLACCT2,
	XXXGLDISTCOD,
	XXXPAIDAMT,
	YYYGLACCT1,
	YYYGLACCT2,
	YYYGLDISTCOD,
	YYYPAIDAMT,
	CHGLAST,
	CHGORIG,
	CHGUSER,
	TPACLIENT,
	TPADIVISION,
	TPAIDOFCLIENT,
	APCHECKRUNBATCH,
	ASSOCIATEDBANKCODE,
	DISCOUNTOFFSETCOSTCENTER,
	DISCOUNTOFFSETGLACCOUNT
) as 

SELECT 
CLM.AddressSequenceNbr, --AddressSequenceNbr
APW.PostDate as APPostingDate, --APPostingDate
APW.FileType as APSourceFileType, --APSourceFileType
APW.BankCode as BankAccountCode , --BankAccountCode
0 as CheckDate, --CheckDate
'' as CheckNbr, --CheckNbr
APW.CompCode as CompanyCode, --CompanyCode
GLD.DebitCostCntrNbr as CostCenterNbr, --CostCenterNbr
CLD.AddDate as DateRecordAdded, --DateRecordAdded
GLD.DiscountCostCenter as DiscCostCenterNbr, --DiscCostCenterNbr
0.00 AS DiscountAmt, --DiscountAmt
APW.ClaimsDetailReceiveDate as DueDate, --DueDate
'' as Flagfor1099taxform, --Flagfor1099taxform
APW.GLDistCode as GLDistributionCode , --GLDistributionCode
0 as GLMonthYYYYMM, --GLMonthYYYYMM
GLD.DebitGLNbr as GLNbr, --GLNbr
GLD.DiscountGLAccount as GPDiscGLNbr, --GPDiscGLNbr
0.00 AS GrossAmt , --GrossAmt
CLD.KeyToSourceFile as KeytoSourceFile, --KeytoSourceFile
APW.Amount as NetPayableAmt, --NetPayableAmt
GLD.CreditCostCntrNbr as OffsetCostCenter, --OffsetCostCenter
GLD.CreditGLNbr as OffsetGLAccountNbr, --OffsetGLAccountNbr
IFF ( APW.NonEncCap = 'X','X',
CASE APW.Status 
WHEN 'EC' THEN '0'
WHEN 'SL' THEN '1'
WHEN 'NG' THEN '1'
WHEN 'RD' THEN '2'
WHEN 'PD' THEN '3' 
WHEN 'NP' THEN '4'
ELSE APW.Status 
END ) AS PayStatus 
, --PayStatus
APW.VendorNo, --VendorNbr
APW.LastUpdated, --LastUpdated
APW.LastApplied, --LastApplied
APW.DeletedFlag, --DeletedFlag
APW.APWorkSeqNbr as AccountsPayableSeqNbr, --AccountsPayableSeqNbr
CLM.GroupNbr as CoverageGroupCode, --CoverageGroupCode
CLD.InterestDiscountAmt as InterestAmount, --InterestAmount
GLD.InterestCostCenter as InterestCostCenter, --InterestCostCenter
IFNULL(APGLINT.InterestGLAccount,'') as InterestGLAccount, --InterestGLAccount
CLM.SubGroup as SubgroupCode, --SubgroupCode
CLD.ClaimSequence as ClaimSequence, --ClaimSequence
'' AS CVPHistExtrTmstmp, --CVPHistExtrTmstmp
IFF (APGLHIA.ApWorkpRowID IS NULL,'','HIA')  as HIAGLAcct1, --HIAGLAcct1
IFNULL(APGLHIA.DebitGLNbr,'') as HIAGLDistCod, --HIAGLDistCod
IFNULL(APGLHIA.GLAmount,0.00) as HIAPaidAmt, --HIAPaidAmt
IFF (APGLHRA.ApWorkpRowID IS NULL,'','HRA') as HRAGLAcct1, --HRAGLAcct1
IFNULL(APGLHRA.DebitGLNbr,'') as HRAGLDistCod, --HRAGLDistCod
IFNULL(APGLHRA.GLAmount,0.00) as HRAPaidAmt, --HRAPaidAmt
TO_VARCHAR (APW.CHGORIG) as InsertTimestamp, --InsertTimestamp
APW.CHGUSER as InsertUser, --InsertUser*
APW.CHGUSER as LastChangeUser, --LastChangeUser
TO_VARCHAR (APW.CHGLAST) as LastChgTimestamp, --LastChgTimestamp
IFNULL(APGLHIA.CreditGLNbr,'') as HIAGLAcct2, --HIAGLAcct2
IFNULL(APGLHRA.CreditGLNbr,'') as HRAGLAcct2, --HRAGLAcct2
IFNULL(APGLINT.InterestOffsetCostCenter,''), --InterestOffsetCostCenter
IFNULL(APGLINT.InterestOffsetGLAccount,0.00), --InterestOffsetGLAccount
0 as RemittanceAdviceDate, --RemittanceAdviceDate
'' as XXXGLAcct1, --XXXGLAcct1
'' as XXXGLAcct2, --XXXGLAcct2
'' as XXXGLDistCod, --XXXGLDistCod
0.00 as XXXPaidAmt, --XXXPaidAmt
' ' as YYYGLAcct1, --YYYGLAcct1
' ' as YYYGLAcct2, --YYYGLAcct2
' ' as YYYGLDistCod, --YYYGLDistCod
0.00 as YYYPaidAmt, --YYYPaidAmt
TO_TIMESTAMP_NTZ(APW.CHGLAST), --CHGLAST
TO_TIMESTAMP_NTZ(APW.CHGORIG), --CHGORIG
APW.CHGUSER, --CHGUSER
TPA.TPACLIENT, --TPACLIENT
TPA.TPADIVISION, --TPADIVISION
TPA.TPAIDOFCLIENT, --TPAIDOFCLIENT
APW.BatchNumber as APCheckRunBatch, --APCheckRunBatch
APW.BankCode as AssociatedBankCode, --AssociatedBankCode
GLD.DiscountOffsetCostCenter, --DiscountOffsetCostCenter
GLD.DiscountOffsetGLAccount --DiscountOffsetGLAccount */
FROM DWOAO.APWork APW
LEFT OUTER JOIN DWOAO.ClaimsDetail CLD on  CLD.ClaimType = APW.FileType AND 
(CASE APW.FileType WHEN 'I' THEN APW.HinsdpRowID
WHEN 'E' THEN APW.HencdpRowID END ) = CLD.RowId
LEFT OUTER JOIN DWOAO.Claims CLM on CLM.ClaimNbr= CLD.ClaimNbr
LEFT OUTER JOIN DWOAO.GLDistributionCode GLD ON (
GLD.GLDistributionCode = APW.GLDistCode AND
GLD.CompanyCode = APW.CompCode AND
GLD.TPAROWID = APW.TPARowID 
)
LEFT OUTER JOIN (SELECT APWGL_INT.ApWorkpRowID,APWGL_INT.GLAmount,GLDI.CompanyCode,GLDI.InterestOffsetCostCenter,GLDI.InterestOffsetGLAccount,GLDI.InterestGLAccount FROM DWOAO.APWorkGL APWGL_INT 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APWGL_INT.GLType AND APWGL_INT.TPARowID= GLDI.TPAROWID
WHERE APWGL_INT.GLType ='INT') APGLINT ON APGLINT.ApWorkpRowID = APW.RowId AND   APGLINT.CompanyCode = APW.CompCode
LEFT OUTER JOIN (SELECT APWGL_HIA.ApWorkpRowID,APWGL_HIA.GLAmount,GLDI.DebitGLNbr ,GLDI.CompanyCode, GLDI.CreditGLNbr AS CreditGLNbr FROM DWOAO.APWorkGL APWGL_HIA 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APWGL_HIA.GLType AND APWGL_HIA.TPARowID= GLDI.TPAROWID
WHERE APWGL_HIA.GLType ='HIA') APGLHIA ON APGLHIA.ApWorkpRowID = APW.RowId AND APGLHIA.CompanyCode = APW.CompCode
LEFT OUTER JOIN (SELECT APWGL_HRA.ApWorkpRowID,APWGL_HRA.GLAmount,GLDI.DebitGLNbr ,GLDI.CompanyCode, GLDI.CreditGLNbr FROM DWOAO.APWorkGL APWGL_HRA 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APWGL_HRA.GLType AND APWGL_HRA.TPARowID= GLDI.TPAROWID
WHERE APWGL_HRA.GLType ='HRA') APGLHRA ON APGLHRA.ApWorkpRowID = APW.RowId AND APGLHRA.CompanyCode = APW.CompCode
INNER JOIN DWOAO.TPACustomer TPA on TPA.ID = APW.TPARowID
WHERE APW.RecIdent = '01'
UNION ALL
	SELECT 
	CLM.AddressSequenceNbr AS AddressSequenceNbr , --AddressSequenceNbr
	APP.PostDate as APPostingDate , --APPostingDate
	APP.FileType as APSourceFileType, --APSourceFileType
	APP.BankCode as BankAccountCode, --BankAccountCode
	APP.CheckDate as CheckDate, --CheckDate
	APP.CheckNbr as CheckNbr, --CheckNbr
	APP.CompCode as CompanyCode , --CompanyCode
	GLD.DebitCostCntrNbr as CostCenterNbr, --CostCenterNbr
	CLD.AddDate as DateRecordAdded, --DateRecordAdded
	GLD.DiscountCostCenter as DiscCostCenterNbr, --DiscCostCenterNbr
	0.00 AS DiscountAmt, --DiscountAmt
	APP.ClaimsDetailReceiveDate as DueDate, --DueDate
	'' as Flagfor1099taxform, --Flagfor1099taxform
	APP.GLDistCode as GLDistributionCode , --GLDistributionCode
	APP.GLMon as GLMonthYYYYMM, --GLMonthYYYYMM
	GLD.DebitGLNbr as GLNbr, --GLNbr
	GLD.DiscountGLAccount as GPDiscGLNbr, --GPDiscGLNbr
	APP.Amount AS GrossAmt , --GrossAmt
	CLD.KeyToSourceFile as KeytoSourceFile, --KeytoSourceFile
	APP.Amount as NetPayableAmt, --NetPayableAmt
	GLD.CreditCostCntrNbr as OffsetCostCenter, --OffsetCostCenter
	GLD.CreditGLNbr as OffsetGLAccountNbr , --OffsetGLAccountNbr
	IFF ( APP.NonEncCap = 'X','X',
	CASE APP.Status 
	WHEN 'EC' THEN '0'
	WHEN 'SL' THEN '1'
	WHEN 'NG' THEN '1'
	WHEN 'RD' THEN '2'
	WHEN 'PD' THEN '3' 
	WHEN 'NP' THEN '4'
	ELSE APP.Status 
	END ) AS PayStatus
	, --PayStatus*
	APP.VendorNo, --VendorNbr
	APP.LastUpdated, --LastUpdated
	APP.LastApplied, --LastApplied
	APP.DeletedFlag, --DeletedFlag
	APP.APPermanentPaymentSeqNbr as AccountsPayableSeqNbr, --AccountsPayableSeqNbr
	CLM.GroupNbr as CoverageGroupCode , --CoverageGroupCode
	CLD.InterestDiscountAmt as InterestAmount, --InterestAmount
	GLD.InterestCostCenter as InterestCostCenter, --InterestCostCenter
	IFNULL(APPGLINT.InterestGLAccount,'') as InterestGLAccount, --InterestGLAccount
	CLM.SubGroup as SubgroupCode , --SubgroupCode
	CLD.ClaimSequence as ClaimSequence, --ClaimSequence
	TO_VARCHAR(APP.CvpHeTs) AS CVPHistExtrTmstmp, --CVPHistExtrTmstmp
	IFF (APPGLHIA.ApPaypRowID IS NULL,'','HIA')  as HIAGLAcct1, --HIAGLAcct1
	IFNULL(APPGLHIA.DebitGLNbr,'') as HIAGLDistCod, --HIAGLDistCod
	IFNULL(APPGLHIA.GLAmount,0.00) as HIAPaidAmt, --HIAPaidAmt
	IFF (APPGLHRA.ApPaypRowID IS NULL,'','HRA') as HRAGLAcct1, --HRAGLAcct1
	IFNULL(APPGLHRA.DebitGLNbr,'') as HRAGLDistCod, --HRAGLDistCod
	IFNULL(APPGLHRA.GLAmount,0.00) as HRAPaidAmt , --HRAPaidAmt
	TO_VARCHAR(APP.CHGORIG) as InsertTimestamp, --InsertTimestamp
	APP.CHGUSER as InsertUser, --InsertUser*
	APP.CHGUSER as LastChangeUser, --LastChangeUser
	TO_VARCHAR(APP.CHGLAST) as LastChgTimestamp, --LastChgTimestamp
	IFNULL(APPGLHIA.CreditGLNbr,'') as HIAGLAcct2, --HIAGLAcct2
	IFNULL(APPGLHRA.CreditGLNbr,'') as HRAGLAcct2, --HRAGLAcct2
	IFNULL(APPGLINT.InterestOffsetCostCenter,''), --InterestOffsetCostCenter
	IFNULL(APPGLINT.InterestOffsetGLAccount,0.00), --InterestOffsetGLAccount
	0 as RemittanceAdviceDate, --RemittanceAdviceDate
	'' as XXXGLAcct1, --XXXGLAcct1
	'' as XXXGLAcct2, --XXXGLAcct2
	'' as XXXGLDistCod, --XXXGLDistCod
	0.00 as XXXPaidAmt, --XXXPaidAmt
	' ' as YYYGLAcct1, --YYYGLAcct1
	' ' as YYYGLAcct2, --YYYGLAcct2
	' ' as YYYGLDistCod, --YYYGLDistCod
	0.00 as YYYPaidAmt, --YYYPaidAmt
	TO_TIMESTAMP_NTZ(APP.CHGLAST) AS CHGLAST, --CHGLAST
	TO_TIMESTAMP_NTZ(APP.CHGORIG) AS CHGORIG, --CHGORIG
	APP.CHGUSER, --CHGUSER
	TPA.TPACLIENT, --TPACLIENT
	TPA.TPADIVISION, --TPADIVISION
	TPA.TPAIDOFCLIENT, --TPAIDOFCLIENT
	APP.BatchNbr as APCheckRunBatch, --APCheckRunBatch
	APP.BankCode as AssociatedBankCode, --AssociatedBankCode
	GLD.DiscountOffsetCostCenter, --DiscountOffsetCostCenter
	GLD.DiscountOffsetGLAccount --DiscountOffsetGLAccount  
FROM DWOAO.APPermanentPayment APP
LEFT OUTER JOIN DWOAO.ClaimsDetail CLD on  CLD.ClaimType = APP.FileType AND 
APP.TableRowId= CLD.RowId
LEFT OUTER JOIN DWOAO.Claims CLM on CLM.ClaimNbr= CLD.ClaimNbr
LEFT OUTER JOIN DWOAO.GLDistributionCode GLD ON (
GLD.GLDistributionCode = APP.GLDistCode AND
GLD.CompanyCode = APP.CompCode AND
GLD.TPAROWID = APP.TPARowID 
)
LEFT OUTER JOIN (SELECT APPGL_INT.ApPaypRowID,APPGL_INT.GLAmount,GLDI.CompanyCode,GLDI.InterestOffsetCostCenter,GLDI.InterestOffsetGLAccount,GLDI.InterestGLAccount FROM DWOAO.APPermanentPaymentGL APPGL_INT 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APPGL_INT.GLType AND APPGL_INT.TPARowID= GLDI.TPAROWID
WHERE APPGL_INT.GLType ='INT') APPGLINT ON APPGLINT.ApPaypRowID = APP.RowId AND   APPGLINT.CompanyCode = APP.CompCode
LEFT OUTER JOIN (SELECT APPGL_HIA.ApPaypRowID,APPGL_HIA.GLAmount,GLDI.DebitGLNbr ,GLDI.CompanyCode, GLDI.CreditGLNbr AS CreditGLNbr FROM DWOAO.APPermanentPaymentGL APPGL_HIA 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APPGL_HIA.GLType AND APPGL_HIA.TPARowID= GLDI.TPAROWID
WHERE APPGL_HIA.GLType ='HIA') APPGLHIA ON APPGLHIA.ApPaypRowID = APP.RowId AND APPGLHIA.CompanyCode = APP.CompCode
LEFT OUTER JOIN (SELECT APPGL_HRA.ApPaypRowID,APPGL_HRA.GLAmount,GLDI.DebitGLNbr ,GLDI.CompanyCode, GLDI.CreditGLNbr FROM DWOAO.APPermanentPaymentGL APPGL_HRA 
INNER JOIN DWOAO.GLDistributionCode GLDI ON GLDI.GLDistributionCode = APPGL_HRA.GLType AND APPGL_HRA.TPARowID= GLDI.TPAROWID
WHERE APPGL_HRA.GLType ='HRA') APPGLHRA ON APPGLHRA.ApPaypRowID = APP.RowId AND APPGLHRA.CompanyCode = APP.CompCode
INNER JOIN DWOAO.TPACustomer TPA on TPA.ID = APP.TPARowID
WHERE APP.RecIdent = '01';