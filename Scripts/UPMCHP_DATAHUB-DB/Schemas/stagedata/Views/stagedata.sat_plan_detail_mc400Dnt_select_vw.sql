CREATE OR REPLACE VIEW STAGEDATA.SAT_PLAN_DETAIL_MC400DNT_SELECT_VW
COMMENT = 'This is a SAT source view containing plan detail data'
AS
SELECT
'000001' AS TPA_CLIENT_ID,
'000001' AS TPA_ID,
'0001' AS TPA_DIV_ID,
'MC400Dnt' AS DATA_SOURCE_NAME
,PlanMaster.PlanCode AS PLAN_CODE
,NULLIF(TRIM(PlanMaster.Description), '') AS PLAN_DESC
,NULLIF(TRIM(PlanMaster.PlanType), '') PLAN_TYPE_CODE
,LOB_PLAN_TYPE.LINE_OF_BUSINESS_CODE AS LOB_CODE
,LOB_PLAN_TYPE.PROGRAM_CODE AS LOB_PRODUCT_CODE
/* ================= PLAN CATEGORY ================= */
,NULLIF(
TRIM(
COALESCE(
/* ---- PART 1 ---- */
  CASE
    WHEN LENGTH(PlanMaster.PlanCode) = 5 AND SUBSTR(PlanMaster.PlanCode,1,1) IN ('X','N','Z','E','P')
  THEN
    CASE
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('027','032') 
        THEN 'BRONZE PLUS PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3)='028'
        THEN 'SILVER PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('029','031')
        THEN 'GOLD PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('030','033')
        THEN 'PLATINUM PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('001','002','003','005','007','010','016','018','019')
        THEN 'PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('006','038','039','040','042','043','044','045','047','049','052','054','055','056')
        THEN 'SMALL GROUP FI COMMERCIAL PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,1)='P' AND SUBSTR(PlanMaster.PlanCode,3,3) IN ('008','011','012','013','026','037','041','046','050','051','053')
        THEN 'SMALL GROUP MYCARE ADVANTAGE FI COMMERCIAL PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='HM' THEN 'HMO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2) IN ('NP','PP') THEN 'PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='PS' THEN 'POS'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='EP' THEN 'EPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='RE' THEN 'HRA EPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='RP' THEN 'HRA PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='RH' THEN 'HRA HMO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='RS' THEN 'HRA POS'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='SE' THEN 'HSA EPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='SP' THEN 'HSA PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='IE' THEN 'HIA EPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='IP' THEN 'HIA PPO'
      WHEN SUBSTR(PlanMaster.PlanCode,2,2)='IH' THEN 'HIA HMO'
      WHEN SUBSTR(PlanMaster.PlanCode,1,1)='E' THEN 'EPO'
      WHEN SUBSTR(PlanMaster.PlanCode,1,1)='P' THEN 'PPO'
    END
  END

,
/* ---- PART 2 ---- */
  CASE
    WHEN LENGTH(PlanMaster.PlanCode) = 5
      THEN
        CASE
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='HM' THEN 'HMO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='PS' THEN 'POS'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2) IN ('PP','PF') THEN 'PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='EP' THEN 'EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='RE' THEN 'HRA EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='RP' AND SUBSTR(PlanMaster.PlanCode,3,1)<>'S' THEN 'HRA PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='RH' THEN 'HRA HMO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='RS' THEN 'HRA POS'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='SE' THEN 'HSA EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='SP' THEN 'HSA PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='IE' AND SUBSTR(PlanMaster.PlanCode,3,1)<>'E' THEN 'HIA EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='IE' AND SUBSTR(PlanMaster.PlanCode,3,1)='E' THEN 'HealthyU EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='IP' AND SUBSTR(PlanMaster.PlanCode,3,1)<>'E' THEN 'HIA PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,2)='IP' AND SUBSTR(PlanMaster.PlanCode,3,1)='E' THEN 'HealthyU PPO'
        END
  END
,
/* ---- PART 2_1 ---- */
  CASE
    WHEN LENGTH(PlanMaster.PlanCode) = 4
      THEN
        CASE
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)||SUBSTR(PlanMaster.PlanCode,2,2)||SUBSTR(PlanMaster.PlanCode,4,1)='GAA1'
            THEN 'HMO RX ENHANCED - WPA, CPA, OH'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)||SUBSTR(PlanMaster.PlanCode,2,2)||SUBSTR(PlanMaster.PlanCode,4,1)='GAA2'
            THEN 'HMO DEDUCTIBLE WITH RX - WPA & OH'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)||SUBSTR(PlanMaster.PlanCode,2,2)||SUBSTR(PlanMaster.PlanCode,4,1)='GAA3'
            THEN 'HMO RX CHOICE - PA & OH'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)||SUBSTR(PlanMaster.PlanCode,2,2)||SUBSTR(PlanMaster.PlanCode,4,1)='GAA4'
            THEN 'HMO RX'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)||SUBSTR(PlanMaster.PlanCode,2,2)||SUBSTR(PlanMaster.PlanCode,4,1)='GAA5'
            THEN 'HMO PREMIER RX'
        END
  END
,
/* ---- PART 3 ---- */
  CASE
    WHEN LENGTH(PlanMaster.PlanCode) = 3
      THEN
        CASE
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('A','B') THEN 'HMO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('C','D') AND PlanMaster.PlanCode <> 'DEF' THEN 'POS'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('E','F') THEN 'PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)='H' THEN 'MC PPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)='J' THEN 'MEDICAID'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('K','L') THEN 'EPO'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('M','N') THEN 'HRA'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1) IN ('P','Q') AND PlanMaster.PlanCode NOT IN ('PEN','PND') THEN 'HSA'
          WHEN SUBSTR(PlanMaster.PlanCode,1,1)='R' THEN 'MC SUPPLIMENT'
        END
    END
,NULL
)
),NULL) AS PLAN_CATEGORY_NAME

/* =================  PLAN_CATEGORY END ================= */

,CASE WHEN HraHsaLookup.IsHealthyUInd = 'Y' THEN 'Y' ELSE 'N' END AS HEALTHY_U_IND  --QUESTION THIS LOGIC, NEEDS TO BE REVIEWED
,CASE WHEN PlanMaster.PlanType = 'W' THEN 'Y' ELSE 'N' END AS WELLNESS_IND
,IFF(TRIM(PlanMaster.CompanyCode) = '', NULL, TRIM(PlanMaster.CompanyCode)) AS COMPANY_CODE
,CASE
   WHEN PlanMaster.CompanyCode = 'A' THEN 'ASO'
   WHEN PlanMaster.CompanyCode IN ('B','N','P','M','O','C') THEN 'FULLY INSURED'
   ELSE NULL
END AS FUNDING_TYPE_DESC
,CASE
   WHEN PlanMaster.CompanyCode = 'P' THEN 'UPMC HEALTH PLAN'
   WHEN PlanMaster.CompanyCode = 'B' THEN 'UPMC HEALTH BENEFITS INC.'
   WHEN PlanMaster.CompanyCode = 'N' THEN 'UPMC HEALTH NETWORK INC.'
   WHEN PlanMaster.CompanyCode = 'A' THEN 'BENEFIT MANAGEMENT SERVICE INC.'
   WHEN PlanMaster.CompanyCode = 'M' THEN 'UPMC FOR YOU'
   WHEN PlanMaster.CompanyCode = 'O' THEN 'UPMC HEALTH OPTIONS INC.'
   WHEN PlanMaster.CompanyCode = 'C' THEN 'UPMC HEALTH COVERAGE INC.'
   ELSE NULL
END AS BUSINESS_UNIT_DESC
,NULL AS GRANDFATHERED_ACA_PLAN_IND  -- DOUBLE CHECK THE LOGIC FOR THIS!!!!
,UTIL.FXN_ARRAY_HASH(['000001', '000001', '0001', DATA_SOURCE_NAME, PlanMaster.PlanCode]) AS HUB_PLAN_HKEY

FROM RAWDATA.MC400_DWDNV_PLANMASTER PlanMaster
    LEFT JOIN RAWDATA.LOB_PLAN_TYPE LOB_PLAN_TYPE
        ON (LOB_PLAN_TYPE.Plan_Type = PlanMaster.PlanType
        AND LOB_PLAN_TYPE.Tpa_Client_Id = '000001'
        AND LOB_PLAN_TYPE.Tpa_Id = '000001'
        AND LOB_PLAN_TYPE.Tpa_Div_Id = '0001')

    LEFT JOIN (
            SELECT DISTINCT
            PlanCode,
            TpaClient,
            TpaIdOfClient,
            TpaDivision,
            'Y' AS IsHealthyUInd
            FROM RAWDATA.MC400_DWOAO_HRAHSAGROUP
            WHERE BenefitType IN ('HRA/', 'HSA/', 'HIA')
            ) HraHsaLookup
        ON (HraHsaLookup.PlanCode = PlanMaster.PlanCode
        AND HraHsaLookup.TpaClient = '000001'
        AND HraHsaLookup.TpaIdOfClient = '000001'
        AND HraHsaLookup.TpaDivision = '0001')
;
