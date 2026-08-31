!set variable_substitution=true;

CREATE OR REPLACE VIEW STAGEDATA.SAT_CLAIM_LINE_MC400DNT_SELECT_VW 
COMMENT='This is the select view to SAT_CLAIM_LINE for the MC400Dnt Data Source'
AS
SELECT 
'000001' AS TPA_CLIENT_ID
,'000001' AS TPA_ID
,'0001' AS TPA_DIV_ID
,'MC400Dnt' AS DATA_SOURCE_NAME
,ClaimsDetail.ClaimNbr AS CLAIM_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureModifier, ClaimsDetail.ProcedureCode, ClaimsDetail.SpecificDateOfService) AS CLAIM_LINE_NBR
,ClaimsDetail.ClaimSequence AS CLAIM_LINE_SEQ_NBR
,STAGEDATA.FXN_GET_CLAIM_LINE_PROCEDURE_ADJ_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureAdj) AS CLAIM_LINE_PROCEDURE_ADJ_CODE
,ClaimsDetail.ClaimType AS CLAIM_TYPE_CODE --(E)ncounter or (I)npatient, different from claimTypeCode on ClaimsDetail
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.ClaimReceiveDate),'YYYYMMDD') AS CLAIM_RECEIVED_DATE
,ClaimsDetail.ProcedureCode AS PROCEDURE_CODE
,ClaimsDetail.ProcedureQty AS PROCEDURE_QUANTITY
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfService),'YYYYMMDD') AS SERVICE_BEGIN_DATE
,CASE (ClaimsDetail.SpecificDateOfServiceThru)
    WHEN 0 THEN TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfService),'YYYYMMDD')
    ELSE TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.SpecificDateOfServiceThru),'YYYYMMDD')
END AS SERVICE_END_DATE
,TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.AddDate),'YYYYMMDD') AS ADD_DATE
,AccountsPayable.PayStatus AS ACCOUNTS_PAYABLE_PAY_STATUS_CODE
,IFF(TRIM(ClaimsDetail.AdjudicationStatus) = '', NULL, TRIM(ClaimsDetail.AdjudicationStatus)) AS ADJUDICATION_STATUS
,TRY_TO_DATE(TO_VARCHAR(AccountsPayable.ApPostingDate),'YYYYMMDD') AS AP_POSTING_DATE
,IFF(TRIM(ClaimsDetail.BenefitCategory) = '', NULL, TRIM(ClaimsDetail.BenefitCategory)) AS BENEFIT_CATEGORY_CODE
,IFF(TRIM(ClaimsDetail.BenefitLevel) = '', NULL, ClaimsDetail.BenefitLevel) AS BENEFIT_LEVEL_CODE
,TO_BOOLEAN(ClaimsDetail.BucketStatus) AS BUCKET_STATUS_FLAG
,COALESCE(
    TRY_TO_DATE(TO_VARCHAR(AccountsPayable.CheckDate),'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.CheckDate),'YYYYMMDD') 
) AS CHECK_DATE 
,COALESCE(
    IFF(TRIM(AccountsPayable.CheckNbr) = '', NULL, AccountsPayable.CheckNbr),
    IFF(TRIM(ClaimsDetail.CheckNbr) = '', NULL, ClaimsDetail.CheckNbr)
 ) AS CHECK_NUMBER
,CASE 
    WHEN (claimsdetail.revenuecode = '0022'
         AND claimsdetail.placeofservice = '31')
         OR (
                (claimsdetail.procedurecode BETWEEN '0100' AND '0219')
                OR (claimsdetail.revenuecode BETWEEN '0100' AND '0219')
             )
         AND (claimsdetail.notcoveredamt = 0 OR claimsdetail.notcoveredreason = 'PN')
         AND (
                (claims.DRGcode <> '391' AND claims.dischargedate < '2007-10-01')
                OR (claims.DRGcode <> '795' AND claims.dischargedate >= '2007-01-01')
             )
         AND claimsdetail.servicereason <> 'LL'
    THEN claimsdetail.procedureQty
    ELSE 0
END AS CLAIM_DAY_CNT
,IFF(TRIM(ClaimsDetail.CleanClaimIndicator) = '', NULL, TRIM(ClaimsDetail.CleanClaimIndicator)) AS CLEAN_CLAIM_IND
,IFF(TRIM(ClaimsDetail.CompanyCode) = '', NULL, TRIM(ClaimsDetail.CompanyCode)) AS COMPANY_CODE
,NULL AS DENIED_DAY_CNT --logic needs determined and revisted (talk with DOHE)
,IFF(TRIM(ELIGIBILITYHISTORY.MiscStatusCode) = '', NULL, TRIM(ELIGIBILITYHISTORY.MiscStatusCode))  AS ELIGIBILITY_MISC_STATUS_CODE
,ClaimsDetail.FormNbr AS FORM_NUMBER
,IFF(TRIM(ClaimsDetail.GlDistributionCode) = '', NULL, TRIM(ClaimsDetail.GlDistributionCode)) AS GL_DISTRIBUTION_CODE
,NULL AS IS_PROCESSING_COMPLETE --n/a for DNV
,TRIM(ClaimsDetail.KeyToSourceFile) AS KEY_TO_SOURCE_FILE
,STAGEDATA.FXN_GET_SERVICE_TYPE_CODE_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProviderTypeHCFA, ClaimsDetail.RevenueCode) AS SERVICE_TYPE_CODE
,STAGEDATA.FXN_GET_LOCATION_CODE_MC400(DATA_SOURCE_NAME, SERVICE_TYPE_CODE, ClaimsDetail.ServiceReason, CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.LOCATION_TYPE_CODE) AS LOCATION_CODE
,COALESCE(
    AccountsPayable.PayStatus, 
    ClaimsDetail.PayStatus
) AS PAY_STATUS_CODE
,COALESCE(
    TRY_TO_DATE(TO_VARCHAR(AccountsPayable.CheckDate),'YYYYMMDD'),
    TRY_TO_DATE(TO_VARCHAR(ClaimsDetail.CheckDate),'YYYYMMDD') 
) AS PAYMENT_DATE
,CASE
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('10','UR','01','02','03','04','05','06','07','08','51','52','53','54','55','56','57','58','A','B','C','D','E','AS','BS','CS','DS','ES')
        THEN '10' --maxillary arch, upper right quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('20','UL','09','10','11','12','13','14','15','16','59','60','61','62','63','64','65','66','F','G','H','I','J','FS','GS','HS','IS','JS')
        THEN '20' --maxillary arch, upper left quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('30','LL','17','18','19','20','21','22','23','24','67','68','69','70','71','72','73','74','K','L','M','N','O','KS','LS','MS','NS','OS')
        THEN '30' --mandibular arch, lower left quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('40','LR','25','26','27','28','29','30','31','32','75','76','77','78','79','80','81','82','P','Q','R','S','T','PS','QS','RS','SS','TS')
        THEN '40' --mandibular arch, lower right quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch)) IN ('')
        THEN NULL
    ELSE TRIM(UPPER(ClaimsDetail.QuadrantArch))
END AS TOOTH_QUADRANT
,IFF(TRIM(ClaimsDetail.RevenueCode) = '', NULL, TRIM(ClaimsDetail.RevenueCode)) AS REVENUE_CODE
,STAGEDATA.FXN_GET_SERVICE_CNT_MC400(DATA_SOURCE_NAME, ClaimsDetail.ProcedureCode, ClaimsDetail.ProcedureQty) AS SERVICE_CNT
,IFF(TRIM(ClaimsDetail.ServiceReason) = '', NULL, TRIM(ClaimsDetail.ServiceReason)) AS SERVICE_REASON_CODE
,CASE
    WHEN (ClaimsDetail.AllowedAmt = ClaimsDetail.NotCoveredAmt AND ClaimsDetail.NotCoveredAmt <> 0)
        THEN 'D'
    ELSE 
        CASE
            WHEN ClaimsDetail.NetAmt <> 0 OR ClaimsDetail.CoPayAmt <> 0 OR ClaimsDetail.DeDuctAmt <> 0
                OR (ClaimsDetail.AllowedAmt <> 0 AND ClaimsDetail.AllowedAmt <> ClaimsDetail.NotCoveredAmt)
                OR (ClaimsDetail.OicPaidAmount <> 0 AND ClaimsDetail.NotCoveredAmt = 0)
            THEN 'P'
        ELSE
            'D'
        END
END AS SERVICE_STATUS_CODE
,IFF(SERVICE_STATUS_CODE = 'P','Paid','Denied') AS SERVICE_STATUS_DESC
,IFF(ClaimsDetail.ProcedureAdj LIKE '%R%','A','C') AS TRANSACTION_TYPE_CODE
,IFF(ClaimsDetail.ProcedureAdj LIKE '%R%','Adjustment','Charge') AS TRANSACTION_TYPE_DESC
,ClaimsDetail.LastUpdated AS SOURCE_LAST_UPDATED_DATETIME
,IFF(TRIM(ClaimsDetail.ProcedureModifier) = '', NULL, TRIM(ClaimsDetail.ProcedureModifier)) AS TOOTH_ID
,CASE
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('0','00')
        THEN '00' --entire oral cavity
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('10','UR','01','02','03','04','05','06','07','08','51','52','53','54','55','56','57','58','A','B','C','D','E','AS','BS','CS','DS','ES')
        THEN '01' --maxillary arch, upper right quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('20','UL','09','10','11','12','13','14','15','16','59','60','61','62','63','64','65','66','F','G','H','I','J','FS','GS','HS','IS','JS')
        THEN '01' --maxillary arch, upper left quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('30','LL','17','18','19','20','21','22','23','24','67','68','69','70','71','72','73','74','K','L','M','N','O','KS','LS','MS','NS','OS')
        THEN '02' --mandibular arch, lower left quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('40','LR','25','26','27','28','29','30','31','32','75','76','77','78','79','80','81','82','P','Q','R','S','T','PS','QS','RS','SS','TS')
        THEN '02' --mandibular arch, lower right quadrant
    WHEN TRIM(UPPER(ClaimsDetail.QuadrantArch))
            IN ('')
        THEN NULL
    ELSE TRIM(UPPER(ClaimsDetail.QuadrantArch))
END AS TOOTH_ARCH
,CLAIMS.MemberAge AS MEMBER_AGE_NBR
,NULL AS AUTHORIZATION_NBR
,IFF(TRIM(ClaimsDetail.ToothSurface) = '', NULL,
        STRTOK_TO_ARRAY
        (
            CONCAT( 
                SUBSTR(TRIM(ClaimsDetail.ToothSurface),1,1),','
                ,SUBSTR(TRIM(ClaimsDetail.ToothSurface),2,1),','
                ,SUBSTR(TRIM(ClaimsDetail.ToothSurface),3,1),','
                ,SUBSTR(TRIM(ClaimsDetail.ToothSurface),4,1),','
                ,SUBSTR(TRIM(ClaimsDetail.ToothSurface),5,1)
                ) 
            ,','
        )
    ) AS TOOTH_SURFACE_ARRAY --There are a max of 5 coming from MC400Dnt
,NULL AS HCPCS_CODE
,NULL AS CMS_CURRENT_ITERATION_FLAG
,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, CLAIM_NBR, CLAIM_LINE_NBR, CLAIM_LINE_SEQ_NBR, CLAIM_LINE_PROCEDURE_ADJ_CODE]) AS HUB_CLAIM_DETAIL_HKEY
,UTIL.FXN_ARRAY_HASH(
    [CLAIM_TYPE_CODE
    ,CLAIM_RECEIVED_DATE
    ,PROCEDURE_CODE
    ,PROCEDURE_QUANTITY
    ,SERVICE_BEGIN_DATE
    ,SERVICE_END_DATE
    ,ADD_DATE
    ,ACCOUNTS_PAYABLE_PAY_STATUS_CODE
    ,ADJUDICATION_STATUS
    ,AP_POSTING_DATE
    ,BENEFIT_CATEGORY_CODE
    ,BENEFIT_LEVEL_CODE
    ,BUCKET_STATUS_FLAG
    ,CHECK_DATE
    ,CHECK_NUMBER
    ,CLAIM_DAY_CNT
    ,CLEAN_CLAIM_IND
    ,COMPANY_CODE
    ,DENIED_DAY_CNT
    ,ELIGIBILITY_MISC_STATUS_CODE
    ,FORM_NUMBER
    ,GL_DISTRIBUTION_CODE
    ,IS_PROCESSING_COMPLETE
    ,KEY_TO_SOURCE_FILE
    ,LOCATION_CODE
    ,PAY_STATUS_CODE
    ,PAYMENT_DATE 
    ,TOOTH_QUADRANT
    ,REVENUE_CODE
    ,SERVICE_CNT
    ,SERVICE_REASON_CODE
    ,SERVICE_STATUS_CODE
    ,SERVICE_STATUS_DESC
    ,SERVICE_TYPE_CODE
    ,TRANSACTION_TYPE_CODE
    ,TRANSACTION_TYPE_DESC
    ,SOURCE_LAST_UPDATED_DATETIME
    ,TOOTH_ID
    ,TOOTH_ARCH
    ,MEMBER_AGE_NBR
    ,AUTHORIZATION_NBR
    ,TOOTH_SURFACE_ARRAY
    ,HCPCS_CODE
    ,CMS_CURRENT_ITERATION_FLAG]
) AS HASH_DIFF

FROM &{MC400}.DWDNV.ClaimsDetail
    JOIN &{MC400}.DWDNV.CLAIMS
        ON (CLAIMS.ClaimNbr = ClaimsDetail.ClaimNbr
        AND CLAIMS.MemberNbr <> '99999999901' --Exclude Generic Default Member Claims
        )
    
    LEFT OUTER JOIN &{MC400}.DWDNV.ACCOUNTSPAYABLE
        ON (ACCOUNTSPAYABLE.KeyToSourceFile = ClaimsDetail.KeyToSourceFile)

    LEFT OUTER JOIN &{MC400}.DWDNV.ELIGIBILITYHISTORY
        ON (ELIGIBILITYHISTORY.MemberNbr = ClaimsDetail.MemberNbr
        AND ELIGIBILITYHISTORY.EligibilityStartDate <= ClaimsDetail.SpecificDateOfService
        AND IFF(ELIGIBILITYHISTORY.EligibilityEndDate = 0, 99991231, ELIGIBILITYHISTORY.EligibilityEndDate) >= ClaimsDetail.SpecificDateOfService)

    LEFT OUTER JOIN REFDATA.CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL
        ON (CLAIM_PLACE_OF_SERVICE_LOCATION_TYPE_REL.PLACE_OF_SERVICE_CODE = ClaimsDetail.PlaceOfService)

;
!set variable_substitution=false;