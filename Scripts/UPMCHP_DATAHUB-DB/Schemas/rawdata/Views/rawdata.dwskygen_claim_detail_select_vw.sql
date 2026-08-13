!set variable_substitution=true;
CREATE OR REPLACE VIEW RAWDATA.DWSKYGEN_CLAIM_DETAIL_SELECT_VW
COMMENT = 'Joins tables from SkygenDW at the claimDetail level for easier change data set processing'
AS
SELECT FactServices_VW.ENCOUNTER_ID AS CLAIM_NBR
,FactServices_VW.ITEM_NUMBER::varchar AS CLAIM_LINE_NBR
,FactServices_VW.ADJUSTMENT_NUMBER::varchar as CLAIM_LINE_SEQ_NBR
,RANK() OVER (PARTITION BY FactServices_VW.ENCOUNTER_ID, FactServices_VW.ITEM_NUMBER, FactServices_VW.ADJUSTMENT_NUMBER
	order by FactServices_VW.ENCOUNTER_ID, FactServices_VW.ITEM_NUMBER, FactServices_VW.ADJUSTMENT_NUMBER, FactServices_VW.DatePaidKey ASC)::VARCHAR
	AS PROCEDURE_ADJ_CODE
,CASE 
	WHEN FactServices_VW.DateOfServiceKey > 0 THEN TRY_TO_DATE(TO_CHAR(FactServices_VW.DateOfServiceKey),'YYYYMMDD')
	ELSE NULL
END as ADMIT_DATE
,DimCode_VW.Code AS PROCEDURE_CODE
,DimCode_VW.DescriptionShort AS PROCEDURE_DESC
,CASE
	WHEN DimTooth_VW.ToothKey NOT IN ('-3','-1') THEN DimTooth_VW.ToothId
	ELSE NULL
END as PROCEDURE_MODIFIER_01
,CASE
	WHEN FactServices_VW.DateOfServiceKey > 0 THEN TRY_TO_DATE(TO_CHAR(FactServices_VW.DateOfServiceKey),'YYYYMMDD')
	ELSE NULL
END as SERVICE_BEGIN_DATE
,NULL as SERVICE_END_DATE
,DimAdjustmentReason_VW.ADJUSTMENT_CODE::varchar as ADJUSTMENT_REASON_CODE_01
,FactServices_VW.ALLOWED_AMOUNT
,DimBenefitLevel_VW.OON_FLAG as BENEFIT_LEVEL_CODE
,DimBenefitLevel_VW.BenefitLevelDescription as BENEFIT_LEVEL_DESC
,FactServices_VW.BILLED_AMOUNT
,CASE
	WHEN FactServices_VW.DatePaidKey > 0 THEN TRY_TO_DATE(TO_CHAR(FactServices_VW.DatePaidKey),'YYYYMMDD')
	ELSE NULL
END as CHECK_DATE
,FactServices_VW.CHECK_NUMBER::varchar AS CHECK_NBR
,CASE
	WHEN FactServices_VW.DateReceivedKey > 0 THEN TRY_TO_DATE(TO_CHAR(FactServices_VW.DateReceivedKey),'YYYYMMDD')
	ELSE NULL
END as CLAIM_RECEIVED_DATE
,FactServices_VW.DEDUCTIBLE_APPLIED_AMOUNT AS DEDUCTIBLE_AMOUNT
,FactServices_VW.SUBSCRIBER_ID AS MEMBER_NBR
,FactServices_VW.MEMBER_ID AS SUBSCRIBER_NBR
,FactServices_VW.PAID_AMOUNT
,FactServices_VW.PROVIDER_WRITEOFF_AMOUNT AS NOT_COVERED_AMOUNT
,DimProcessingState_VW.ProcessingStatusID::varchar AS PAY_STATUS
,DimProcessingState_VW.ProcessingStatusDescription AS PAY_STATUS_DESC
,LPAD(DimPlaceOfService_VW.PLACE_OF_SERVICE, 2, '0') AS PLACE_OF_SERVICE_CODE /*leading 0 for standard formatting*/
,DimPlaceOfService_VW.PLACE_OF_SERVICE_TYPE::varchar AS PLACE_OF_SERVICE_TYPE
,TO_VARCHAR(DimLocation_VW.LOCATIONTYPEID) AS LOCATION_TYPE_CODE
,FactServices_VW.QUANTITY AS PROCEDURE_QTY
,CONCAT('PROVIDER_', DimProviderSimple_VW.PROVIDER_ID) AS RENDERING_PROVIDER_ID
,DimSurface_VW.SurfaceCode as TOOTH_SURFACE_CODE_LIST
,DimTooth_VW.ToothID AS TOOTH_ID
,DimTooth_VW.Quadrant AS TOOTH_QUADRANT
,DimTooth_VW.Arch AS TOOTH_ARCH
,FactServices_VW.Coinsurance_Amount AS COINSURANCE_AMOUNT
,'Y' AS CLEAN_CLAIM_IND
,'TBD' AS BENEFIT_CATEGORY_CODE
,FactServices_VW.COPAY_AMT_SH AS COPAY_AMOUNT
,CASE
	WHEN FactServices_VW.DateAdjudicationKey > 0 THEN TRY_TO_DATE(TO_CHAR(FactServices_VW.DateAdjudicationKey),'YYYYMMDD')
	ELSE NULL
END as AP_POSTING_DATE
,CASE
    WHEN DimProcessingState_VW.ProcessingStateDescription = 'Paid' then NULL
    ELSE DimDenialGroup_VW.DenialGroupListing 
END as DENIAL_REASON_CODE_LIST
,NULLIF(FactServices_VW.AUTH_ID::varchar,'') AS AUTH_ID --convert empty strings to null
,NULLIF(FactServices_VW.AUTH_NUMBER::varchar,'') AS AUTH_NBR --force empty strings to populate as null inste
,NULLIF(FactServices_VW.AUTH_ITEM_NUMBER::varchar,'') AS AUTH_ITEM_NBR --force empty strings to populate as null
,FactServices_VW.COB_COLLECTED_AMOUNT AS THIRD_PARTY_PAID_AMOUNT
,CASE
        WHEN FactServices_VW.COB_COLLECTED_AMOUNT > 0 
            OR FactServices_VW.COB > 0 
            OR FactServices_VW.COPAY_AMT_CH > 0 
            OR FactServices_VW.COPAY_AMT_SH > 0 
            OR FactServices_VW.COPAY_VISIT_AMT > 0 
            OR FactServices_VW.COINSURANCE_AMOUNT > 0 
            OR FactServices_VW.PATIENT_PAY_APPLIED_AMOUNT > 0 
            OR FactServices_VW.DEDUCTIBLE_APPLIED_AMOUNT > 0 
            OR FactServices_VW.AMOUNT_OVER_OOP > 0 
            OR FactServices_VW.OOP_APPLIED_AMOUNT > 0 
            OR FactServices_VW.COB_ADJUSTMENT_AMOUNT > 0 
            OR FactServices_VW.PROVIDER_WRITEOFF_AMOUNT > 0 
        THEN TRUE
        ELSE FALSE
    END AS MEMBER_PAY_FLAG  --This not actually used downstream there is other logic in the stagedata layer to calculate 2024/06/25
,DimAge_VW.Age AS MEMBER_AGE

FROM &{DWSKYGEN}.DBO.FactServices_VW
	INNER JOIN &{DWSKYGEN}.DBO.DimCode_VW
		on (FactServices_VW.CodeKey = DimCode_VW.CodeKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimAdjustmentReason_VW
		on (FactServices_VW.AdjustmentReasonKey = DimAdjustmentReason_VW.AdjustmentReasonKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimBenefitLevel_VW
		on (FactServices_VW.BenefitLevelKey = DimBenefitLevel_VW.BenefitLevelKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimLocation_VW
		on (FactServices_VW.LocationKey = DimLocation_VW.LocationKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimProcessingState_VW
		ON (FactServices_VW.ProcessingStateKey = DimProcessingState_VW.ProcessingStateKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimPlaceOfService_VW
		ON (FactServices_VW.PlaceOfServiceKey = DimPlaceOfService_VW.PlaceOfServiceKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimProviderSimple_VW
		ON (FactServices_VW.ProviderSimpleKey = DimProviderSimple_VW.ProviderKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimSurface_VW
		ON (FactServices_VW.SurfaceKey = DimSurface_VW.SurfaceKey)
	INNER JOIN &{DWSKYGEN}.DBO.DimTooth_VW
		ON (FactServices_VW.ToothKey = DimTooth_VW.ToothKey)
    INNER JOIN &{DWSKYGEN}.DBO.DimDenialGroup_VW
        on (FactServices_VW.DenialGroupKey = DimDenialGroup_VW.DenialGroupKey)
    INNER JOIN &{DWSKYGEN}.DBO.DimAge_VW
        on (DimAge_VW.AgeKey = FactServices_VW.AgeKey)


WHERE DimProcessingState_VW.ProcessingStatusGroupID in (3,4)--TEMPORARY FIX, must go back and fix once skygen does more research on their side.
AND FactServices_VW.ClaimStatusKey NOT IN (7) --ignore deleted claim
;

!set variable_substitution=false;