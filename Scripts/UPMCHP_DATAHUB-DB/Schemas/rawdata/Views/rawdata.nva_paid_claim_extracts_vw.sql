CREATE OR REPLACE VIEW RAWDATA.NVA_PAID_CLAIM_EXTRACTS_VW
COMMENT = 'Most Current Version of Each Claim Line Record'
AS
SELECT
    FILENAME,
	FILE_ROW_NUMBER,
	FILE_LOAD_DATETIME,
	LTRIM("ClaimNo",'0') AS "ClaimNo", --need to strip leading zeroes because NVA files are inconsistent about whether or not to include leading zeroes and this can result in claim duplication
	"ClaimSeqNo",
	"ClaimType",
	"Group",
	CASE
		WHEN LEN("MemberID") = 9 THEN CONCAT("MemberID", "RelCode")
		ELSE "MemberID"
	END AS "MemberID", -- make all member IDs 11 characters, including RelCode (person number)
	"RelCode",
	"LastName",
	"FirstName",
	"DOB",
	"Sex",
	"Trantype",
	"TranDesc",
	"DOS",
	"TotalChargeAmt",
	"PaidAmt",
	"PaidDate",
	"ReceivedDate",
	"Copay",
	"ChargeAmt",
	"Units",
	"ProcedureCode",
	"Mod1",
	"Diag1",
	"Diag2",
	"Diag3",
	"AuthCode",
	"POS",
	"RendProvID",
	"RendProvName",
	"RendProvNPI",
	"BillProvID",
	"BillProvName",
	"BillProvNPI",
	"ICD_TYPE",
	"DepCode",
	"PlanCode",
	"Non-CoveredAmt",
	"ReasonCd1",
	"ReasonSuf1",
	"ReasonCd2",
	"ReasonSuf2",
	"AllowedAmt",
	"COBamt",
	"BillProvLoc",
	"BillProvPhone",
	"BillProvAddr1",
	"BillProvAddr2",
	"BillProvCity",
	"BillProvState",
	"BillProvZip",
	"Company Code"
FROM RAWDATA.NVA_PAID_CLAIM_EXTRACTS
WHERE NVA_PAID_CLAIM_EXTRACTS."ClaimNo" != 'TRAILER'
QUALIFY ROW_NUMBER() 
    OVER(PARTITION BY LTRIM("ClaimNo",'0'), NVA_PAID_CLAIM_EXTRACTS."ClaimSeqNo", NVA_PAID_CLAIM_EXTRACTS."Trantype"
        ORDER BY SPLIT_PART(SPLIT_PART(NVA_PAID_CLAIM_EXTRACTS.FILENAME, '_', 7), '.', 1) DESC) = 1
;