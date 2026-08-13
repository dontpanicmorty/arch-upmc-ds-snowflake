!set variable_substitution=true;

CREATE OR REPLACE VIEW RAWDATA.DWSKYGEN_CLAIM_DETAIL_DENIAL_REASON_SELECT_VW
COMMENT = 'Joins tables from SkygenDW to return denial reason codes in rows per claim line'
AS
SELECT DISTINCT 
FactServices_VW.ENCOUNTER_ID AS CLAIM_NBR
,FactServices_VW.ITEM_NUMBER::VARCHAR AS CLAIM_LINE_NBR
,FactServices_VW.ADJUSTMENT_NUMBER::VARCHAR as CLAIM_LINE_SEQ_NBR
, RANK() OVER (PARTITION BY FactServices_VW.ENCOUNTER_ID, FactServices_VW.ITEM_NUMBER, FactServices_VW.ADJUSTMENT_NUMBER
	order by FactServices_VW.ENCOUNTER_ID, FactServices_VW.ITEM_NUMBER, FactServices_VW.ADJUSTMENT_NUMBER, FactServices_VW.DatePaidKey ASC)::VARCHAR
    as PROCEDURE_ADJ_CODE
,DimDenial_VW.DENIALCODE::VARCHAR as DENIAL_CODE
,DimDenial_VW.TYPEDESCRIPTION
FROM &{DWSKYGEN}.DBO.FactServices_VW
    JOIN &{DWSKYGEN}.DBO.BridgeDenialGroup_VW
        on (FactServices_VW.denialgroupkey = BridgeDenialGroup_VW.denialgroupkey)
    JOIN &{DWSKYGEN}.DBO.DimDenial_VW
        on (DimDenial_VW.DenialCodeKey = BridgeDenialGroup_VW.DenialCodeKey)
-- Filter out claimlines that are Explicitly approved.
WHERE NOT EXISTS (  SELECT 1 FROM &{DWSKYGEN}.dbo.BridgeApprovalGroup_vw  
                    inner join &{DWSKYGEN}.dbo.DimApproval_vw on BridgeApprovalGroup_vw.ApprovalCodeKey = DimApproval_vw.ApprovalCodeKey
                    where FactServices_VW.ApprovalGroupKey = BridgeApprovalGroup_vw.ApprovalGroupKey
                    AND DimApproval_vw.CodeTypeID <> '-1' 
                 )

-- Filter out claimlines that only have exceptions (in other words, which have no "reasons"), but which have a paid amount.
 AND
    (
        NOT EXISTS (SELECT 1 from  &{DWSKYGEN}.DBO.BridgeDenialGroup_VW bdg2 
                    JOIN &{DWSKYGEN}.DBO.DimDenial_VW dd2
                        on dd2.DenialCodeKey = bdg2.DenialCodeKey
                    WHERE factservices_vw.denialgroupkey = bdg2.denialgroupkey
                    AND dd2.type = 2
                    AND FactServices_VW.ALLOWED_AMOUNT > 0
                    )     
    )
;

!set variable_substitution=false;