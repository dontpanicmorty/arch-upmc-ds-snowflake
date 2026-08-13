!set variable_substitution=true;

CREATE OR REPLACE VIEW RAWDATA.DWSKYGEN_CLAIM_HEADER_DIAGNOSIS_CODE_SELECT_VW
COMMENT = 'Joins tables from SkygenDW to return diagnosis codes in rows per claimId'
AS
SELECT 
FactServicesAgg.ENCOUNTER_ID AS CLAIM_NBR,
DimDiagnosisCode_VW.DIAGNOSIS_CODE,
DimDiagnosisCode_VW.DiagnosisDescription, /*can be removed once refData is fully built into the HUB*/
RANK() OVER(PARTITION BY FactServicesAgg.ENCOUNTER_ID ORDER BY BridgeDiagnosisGroup_VW.DiagnosisCodeKey) AS ICD_POSITION,
CASE ICD_POSITION
    WHEN 1 THEN 'ABK'
    ELSE 'ABF'
END AS CODE_QUALIFIER,
CASE
    WHEN (DimDiagnosisCode_VW.DIAGNOSIS_CODE <> '-1')
        THEN SUBSTRING(DimDiagnosisCode_VW.CODETYPEDESCRIPTION, CHARINDEX('-', DimDiagnosisCode_VW.CODETYPEDESCRIPTION) + 1, LEN(DimDiagnosisCode_VW.CODETYPEDESCRIPTION))
    ELSE NULL
END AS CODE_VERSION,
CASE WHEN (DimDiagnosisCode_VW.DIAGNOSIS_CODE <> '-1')
    THEN SUBSTRING(DimDiagnosisCode_VW.DIAGNOSIS_CODE, 1, IFF(CHARINDEX('.', DimDiagnosisCode_VW.DIAGNOSIS_CODE) > 0, CHARINDEX('.', DimDiagnosisCode_VW.DIAGNOSIS_CODE) - 1, LEN(DimDiagnosisCode_VW.DIAGNOSIS_CODE)))
    ELSE NULL
END AS GROUP_CODE,
NULL AS GROUP_DESC
        
FROM (SELECT ENCOUNTER_ID, MAX(DiagnosisGroupKey) AS MaxDiagKey /*Making sure we only ever get one and we want the one with data where possible*/
        FROM &{DWSKYGEN}.DBO.FactServices_VW
        GROUP BY ENCOUNTER_ID
    ) AS FactServicesAgg
    JOIN &{DWSKYGEN}.DBO.BridgeDiagnosisGroup_VW
        ON (FactServicesAgg.MaxDiagKey = BridgeDiagnosisGroup_VW.DiagnosisGroupKey)
    JOIN &{DWSKYGEN}.DBO.DimDiagnosisCode_VW
        ON (BridgeDiagnosisGroup_VW.DiagnosisCodeKey = DimDiagnosisCode_VW.DiagnosisCodeKey
        AND RecordIsCurrent = 1)
    JOIN &{DWSKYGEN}.DBO.DimDiagnosisGroup_VW
        ON (FactServicesAgg.MaxDiagKey = DimDiagnosisGroup_VW.DiagnosisGroupKey
        )
WHERE FactServicesAgg.ENCOUNTER_ID IN (SELECT CLAIM_NBR FROM RAWDATA.DWSKYGEN_CLAIM_HEADER) --filter out anything we filter is base table
;

!set variable_substitution=false;