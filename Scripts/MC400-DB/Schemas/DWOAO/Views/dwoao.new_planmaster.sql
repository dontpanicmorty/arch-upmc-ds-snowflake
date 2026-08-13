
/* COMMENTING OUT FOR NOT, WILL REVIST -- GENTILE

CREATE OR REPLACE VIEW DWOAO.New_PlanMaster as 
WITH T AS (
SELECT 
TPACLIENTPROWID,
PlanCode ,
CASE
    WHEN Benefits in ('PHYS','PCP','SPEC','ER','ER','GYN','MAJ MED','ADULT','PEDS','CHIRO')
        THEN 'BenefitDescription1'
    WHEN Benefits in ('COINS','INN DED','URG CARE','URG CARE')
        THEN 'BenefitDescription2'
    WHEN Benefits ='MH' 
        THEN 'BenefitDescription3'
    WHEN Benefits in ('MH LIMIT','PCP REF')
        THEN 'BenefitDescription4'
    WHEN Benefits in ('IH','SNF','XR','DME','OP','OP','PCP REF')
        THEN 'BenefitDescription5'
    WHEN Benefits ='COC'
        THEN 'BenefitDescription6'
    WHEN Benefits in ('DNT ADV')
        THEN 'BenefitDescription7'
END as BenefitDescriptionN, 
CONCAT(RTRIM(Benefits), ':', RTRIM(BenefitsValue)) AS BenDesc
FROM DWOAO.PlanCodeBenefitsMaster
--WHERE PLANCODE = '10A'
)

,SQL_2 
AS 
(
    SELECT 
    TPACLIENTPROWID,PlanCode,BenefitDescriptionN,
    STUFF((
    SELECT ':'+ CAST(BenDesc AS VARCHAR(MAX))
    FROM T WHERE (PlanCode = Results.PlanCode and BenefitDescriptionN = Results.BenefitDescriptionN AND TPACLIENTPROWID= Results.TPACLIENTPROWID
    --AND PLANCODE = '10A'
)
FOR XML PATH(''),TYPE
).value('.','VARCHAR(MAX)')
,1,1,'') as BenDesc
FROM T Results
GROUP BY TPACLIENTPROWID,PlanCode,BenefitDescriptionN 
),

SQL_3 AS (
SELECT TPACLIENTPROWID,PlanCode,
'COPAYS: ' + ISNULL(BenefitDescription1,'') AS BenefitDescription1,
'' AS BenefitDescription10, 
 '' AS BenefitDescription11, 
 '' AS BenefitDescription12, 
 '' AS BenefitDescription13, 
 '' AS BenefitDescription14, 
 '' AS BenefitDescription15, 
 '' AS BenefitDescription16, 
 '' AS BenefitDescription17, 
 '' AS BenefitDescription18, 
 '' AS BenefitDescription19, 
ISNULL(BenefitDescription2,'COINS:') AS BenefitDescription2,
'' AS BenefitDescription20, 
 '' AS BenefitDescription21, 
 '' AS BenefitDescription22, 
 '' AS BenefitDescription23, 
 '' AS BenefitDescription24, 
 '' AS BenefitDescription25, 
 '' AS BenefitDescription26, 
 '' AS BenefitDescription27, 
 '' AS BenefitDescription28, 
 '' AS BenefitDescription29, 
ISNULL(BenefitDescription3,'') AS BenefitDescription3,
 '' AS BenefitDescription30, 
 '' AS BenefitDescription31, 
 '' AS BenefitDescription32, 
 '' AS BenefitDescription33, 
 '' AS BenefitDescription34, 
 '' AS BenefitDescription35, 
 '' AS BenefitDescription36, 
 '' AS BenefitDescription37, 
 '' AS BenefitDescription38, 
 '' AS BenefitDescription39, 
ISNULL(BenefitDescription4,'') AS BenefitDescription4,
 '' AS BenefitDescription40, 
 '' AS BenefitDescription41, 
 '' AS BenefitDescription42, 
 '' AS BenefitDescription43, 
 '' AS BenefitDescription44, 
 '' AS BenefitDescription45, 
 '' AS BenefitDescription46, 
 '' AS BenefitDescription47, 
 '' AS BenefitDescription48, 
 '' AS BenefitDescription49, 
ISNULL(BenefitDescription5,'') AS BenefitDescription5,
'' AS BenefitDescription50, 
 '' AS BenefitDescription51, 
 '' AS BenefitDescription52, 
 '' AS BenefitDescription53, 
 '' AS BenefitDescription54, 
 '' AS BenefitDescription55, 
 '' AS BenefitDescription56,
ISNULL(BenefitDescription6,'') AS BenefitDescription6,
ISNULL(BenefitDescription7,'') AS BenefitDescription7,
 '' AS BenefitDescription8, 
 '' AS BenefitDescription9 
FROM SQL_2
PIVOT (
MAX(BenDesc) FOR BenefitDescriptionN IN
(BenefitDescription1,BenefitDescription2,BenefitDescription3,BenefitDescription4
,BenefitDescription5,BenefitDescription6,BenefitDescription7)
) AS P )
SELECT 
PM.PLANCODE,PM.AccumulatorType,S3.BenefitDescription1,S3.BenefitDescription10,S3.BenefitDescription11,S3.BenefitDescription12,S3.BenefitDescription13,S3.BenefitDescription14,S3.BenefitDescription15,S3.BenefitDescription16,S3.BenefitDescription17,S3.BenefitDescription18,S3.BenefitDescription19,S3.BenefitDescription2,S3.BenefitDescription20,S3.BenefitDescription21,S3.BenefitDescription22,S3.BenefitDescription23,S3.BenefitDescription24,S3.BenefitDescription25,S3.BenefitDescription26,S3.BenefitDescription27,S3.BenefitDescription28,S3.BenefitDescription29,S3.BenefitDescription3,S3.BenefitDescription30,S3.BenefitDescription31,S3.BenefitDescription32,S3.BenefitDescription33,S3.BenefitDescription34,S3.BenefitDescription35,S3.BenefitDescription36,S3.BenefitDescription37,S3.BenefitDescription38,S3.BenefitDescription39,S3.BenefitDescription4,S3.BenefitDescription40,S3.BenefitDescription41,S3.BenefitDescription42,S3.BenefitDescription43,S3.BenefitDescription44,S3.BenefitDescription45,S3.BenefitDescription46,S3.BenefitDescription47,S3.BenefitDescription48,S3.BenefitDescription49,S3.BenefitDescription5,S3.BenefitDescription50,S3.BenefitDescription51,S3.BenefitDescription52,S3.BenefitDescription53,S3.BenefitDescription54,S3.BenefitDescription55,S3.BenefitDescription56,S3.BenefitDescription6,S3.BenefitDescription7,S3.BenefitDescription8,S3.BenefitDescription9,PM.CarryoverMonths,PM.Description,PM.Entity,PM.GrandfatherIndicator,PM.Level1Date,PM.Level2Date,PM.Level3Date,PM.PlanType,PM.PoolBenefitsbyUserField,PM.PrimaryCareCopayLevel1,PM.PrimaryCareCopayLevel2,PM.PrimaryCareCopayLevel3,PM.YearType,PM.LastUpdated,PM.LastApplied,PM.DeletedFlag,PM.PlanMasterSeqNbr,PM.ConsumerConnectTemplate,PM.AggregateOOP,PM.CHGLAST,PM.CHGORIG,PM.CHGUSER,TPA.TPACLIENT,TPA.TPADIVISION,TPA.TPAIDOFCLIENT,PM.CompanyCode,PM.SpendingAccountType,PM.ExceptionFlag,PM.ASOFlag,PM.RowId
FROM 
DWOAO.PlanMaster PM 
INNER JOIN TPACustomer TPA ON PM.TPACLIENT = TPA.TPACLIENT AND PM.TPADIVISION= TPA.TPADIVISION AND PM.TPAIDOFCLIENT=TPA.TPAIDOFCLIENT
INNER JOIN SQL_3 S3 ON S3.TPACLIENTPROWID = TPA.ID AND PM.PLANCODE=S3.PlanCode
--where pm.PLANCODE='13J'
;
*/