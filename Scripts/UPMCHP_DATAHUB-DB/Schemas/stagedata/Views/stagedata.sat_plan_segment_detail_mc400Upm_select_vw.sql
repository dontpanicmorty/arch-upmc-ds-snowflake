CREATE OR REPLACE VIEW STAGEDATA.SAT_PLAN_SEGMENT_DETAIL_MC400Upm_SELECT_VW
COMMENT = 'This is a SAT source view containing plan segment detail data'
AS
SELECT
TpaCustomer.TpaClient  AS TPA_CLIENT_ID
,TpaCustomer.TpaIdOfClient AS TPA_ID
,TpaCustomer.TpaDivision AS TPA_DIV_ID
,'MC400Upm' AS DATA_SOURCE_NAME
,PlanCodeSegmentIdMaster.EffectiveDate AS EFFECTIVE_START_DATE
,PlanCodeSegmentIdMaster.PlanCode AS PLAN_CODE
,PlanCodeSegmentIdMaster.PlanSegmentId AS PLAN_SEGMENT_CODE
,IFF(PlanCodeSegmentIdMaster.TerminationDate = '0001-01-01', '9999-12-31', PlanCodeSegmentIdMaster.TerminationDate) AS EFFECTIVE_END_DATE
,NULLIF(TRIM(PlanCodeSegmentIdMaster.PlanSegmentDescription), '') AS SEGMENT_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) IN ('ER', 'PCP', 'PHYS', 'SPEC') 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits),':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END,', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'')
AS COPAY_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) = 'COINS' 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits), ':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END, ', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'')
AS COINSURANCE_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) = 'MH' 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits), ':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END, ', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'')
AS MENTAL_HEALTH_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) = 'MH LIMIT' 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits), ':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END, ', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'')
AS MENTAL_HEALTH_LIMIT_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) IN ('DME', 'IH', 'OP', 'SNF', 'XR') 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits), ':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END, ', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'')
AS OTHER_BENEFITS_DESC

,NULLIF(
    LISTAGG(
    CASE 
        WHEN UPPER(PlanCodeBenefitsMaster.Benefits) IN ('OON PCP', 'OON SPEC') 
            THEN NULLIF(CONCAT(TRIM(PlanCodeBenefitsMaster.Benefits), ':', TRIM(PlanCodeBenefitsMaster.BenefitsValue)), '')
        ELSE NULL
    END, ', '
    ) WITHIN GROUP (ORDER BY PlanCodeBenefitsMaster.Benefits)
    ,'') 
AS OUT_OF_NETWORK_DESC

,UTIL.FXN_ARRAY_HASH([TPA_CLIENT_ID, TPA_ID, TPA_DIV_ID, DATA_SOURCE_NAME, PLAN_CODE, PLAN_SEGMENT_CODE]) AS HUB_PLAN_SEGMENT_HKEY

FROM RAWDATA.MC400_DWOAO_PLANCODESEGMENTIDMASTER PlanCodeSegmentIdMaster
    LEFT OUTER JOIN RAWDATA.MC400_DWOAO_PLANCODEBENEFITSMASTER PlanCodeBenefitsMaster
        ON (PlanCodeBenefitsMaster.TpaClientPRowId = PlanCodeSegmentIdMaster.TpaClientRowId
        AND PlanCodeBenefitsMaster.PLANCODE = PlanCodeSegmentIdMaster.PLANCODE
        AND PlanCodeBenefitsMaster.SEGMENTID = PlanCodeSegmentIdMaster.PLANSEGMENTID)
    
    JOIN RAWDATA.MC400_DWOAO_TPACUSTOMER TpaCustomer
        ON (TpaCustomer.Id = PlanCodeSegmentIdMaster.TpaClientRowId)
    
WHERE PlanCodeBenefitsMaster.SEGMENTID <> '000' AND PlanCodeSegmentIdMaster.PLANSEGMENTID <> '000'

GROUP BY
TPA_CLIENT_ID
,TPA_ID
,TPA_DIV_ID
,PLAN_CODE
,PLAN_SEGMENT_CODE
,EFFECTIVE_START_DATE
,EFFECTIVE_END_DATE
,SEGMENT_DESC
;
