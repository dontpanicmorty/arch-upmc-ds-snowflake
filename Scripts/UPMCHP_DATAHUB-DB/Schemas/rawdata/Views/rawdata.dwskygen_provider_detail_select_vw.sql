!set variable_substitution=true;

CREATE OR REPLACE VIEW RAWDATA.DWSKYGEN_PROVIDER_DETAIL_SELECT_VW
COMMENT = 'Unions tables from SkygenDW to return 1 row per provider with a concatenated ID to ensure uniqueness across provider types'
AS
SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0002' AS TPA_DIV_ID,
    CONCAT('PROVIDER_', PROVIDER_ID) AS PROVIDER_ID,
    CONCAT (ProviderFirstName, ' ', ProviderLastName) AS PROVIDER_FULL_NAME,
    ProviderFirstName AS PROVIDER_FIRST_NAME,
    ProviderMiddleName AS PROVIDER_MIDDLE_NAME,
    ProviderLastName AS PROVIDER_LAST_NAME,
    ProviderGender AS PROVIDER_GENDER,
    ProviderDOB AS PROVIDER_DATE_OF_BIRTH,
    Email AS PROVIDER_EMAIL,
    ProviderSSN AS PROVIDER_SSN,
    ElectronicPrescribingFlag AS E_PRESCRIBE_IND,
    CulturalCompetencyCourseFlag AS CULTURAL_COMPETENCY_IND,
    'Practitioner' as PROVIDER_TYPE,
    ProviderNPI AS PROVIDER_NPI,
    NULL AS TAX_ID
FROM &{DWSKYGEN}.DBO.DimProviderSimple_VW
    WHERE RecordIsCurrent = 1
    AND ProviderKey > 0
UNION ALL
SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0001' AS TPA_DIV_ID,
    CONCAT('PROVIDER_', PROVIDER_ID) AS PROVIDER_ID,
    CONCAT (ProviderFirstName, ' ', ProviderLastName) AS PROVIDER_FULL_NAME,
    ProviderFirstName AS PROVIDER_FIRST_NAME,
    ProviderMiddleName AS PROVIDER_MIDDLE_NAME,
    ProviderLastName AS PROVIDER_LAST_NAME,
    ProviderGender AS PROVIDER_GENDER,
    ProviderDOB AS PROVIDER_DATE_OF_BIRTH,
    Email AS PROVIDER_EMAIL,
    ProviderSSN AS PROVIDER_SSN,
    ElectronicPrescribingFlag AS E_PRESCRIBE_IND,
    CulturalCompetencyCourseFlag AS CULTURAL_COMPETENCY_IND,
    'Practitioner' as PROVIDER_TYPE,
    ProviderNPI AS PROVIDER_NPI,
    NULL AS TAX_ID
FROM &{DWSKYGEN}.DBO.DimProviderSimple_VW
    WHERE RecordIsCurrent = 1
    AND ProviderKey > 0

UNION ALL

SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0002' AS TPA_DIV_ID,
    CONCAT('PAYEE_', PAYEE_ID) AS PROVIDER_ID,
    PayeeName AS PROVIDER_FULL_NAME,
    NULL AS PROVIDER_FIRST_NAME,
    NULL AS PROVIDER_MIDDLE_NAME,
    NULL AS PROVIDER_LAST_NAME,
    NULL AS PROVIDER_GENDER,
    NULL AS PROVIDER_DATE_OF_BIRTH,
    PayeeEmail as PROVIDER_EMAIL,
    NULL AS PROVIDER_SSN,
    NULL AS E_PRESCRIBE_IND,
    NULL AS CULTURAL_COMPETENCY_IND,
    'Medical Group' as PROVIDER_TYPE,
    PayeeNPI AS PROVIDER_NPI,
    DimTaxEntity_vw.TAX_ID
FROM &{DWSKYGEN}.DBO.DimPayee_VW
    LEFT OUTER JOIN &{DWSKYGEN}.DBO.BridgePayeeTaxEntity_vw
        ON (BridgePayeeTaxEntity_vw.PAYEEKEY = DimPayee_vw.PayeeKey
        AND BridgePayeeTaxEntity_vw.EffectiveDate <= current_timestamp()
        AND BridgePayeeTaxEntity_vw.TerminationDate >= current_timestamp())
    LEFT OUTER JOIN &{DWSKYGEN}.DBO.DimTaxEntity_vw
        ON (DimTaxEntity_vw.TaxEntityKey = BridgePayeeTaxEntity_vw.TaxEntityKey)
WHERE DimPayee_VW.RecordIsCurrent = 1
AND DimPayee_VW.PayeeKey > 0

UNION ALL

SELECT 
    '000001' AS TPA_CLIENT_ID,
    '000001' AS TPA_ID,
    '0001' AS TPA_DIV_ID,
    CONCAT('PAYEE_', PAYEE_ID) AS PROVIDER_ID,
    PayeeName AS PROVIDER_FULL_NAME,
    NULL AS PROVIDER_FIRST_NAME,
    NULL AS PROVIDER_MIDDLE_NAME,
    NULL AS PROVIDER_LAST_NAME,
    NULL AS PROVIDER_GENDER,
    NULL AS PROVIDER_DATE_OF_BIRTH,
    PayeeEmail as PROVIDER_EMAIL,
    NULL AS PROVIDER_SSN,
    NULL AS E_PRESCRIBE_IND,
    NULL AS CULTURAL_COMPETENCY_IND,
    'Medical Group' as PROVIDER_TYPE,
    PayeeNPI AS PROVIDER_NPI,
    DimTaxEntity_vw.TAX_ID
FROM &{DWSKYGEN}.DBO.DimPayee_VW
    LEFT OUTER JOIN &{DWSKYGEN}.DBO.BridgePayeeTaxEntity_vw
        ON (BridgePayeeTaxEntity_vw.PAYEEKEY = DimPayee_vw.PayeeKey
        AND BridgePayeeTaxEntity_vw.EffectiveDate <= current_timestamp()
        AND BridgePayeeTaxEntity_vw.TerminationDate >= current_timestamp())
    LEFT OUTER JOIN &{DWSKYGEN}.DBO.DimTaxEntity_vw
        ON (DimTaxEntity_vw.TaxEntityKey = BridgePayeeTaxEntity_vw.TaxEntityKey)
WHERE DimPayee_VW.RecordIsCurrent = 1
AND DimPayee_VW.PayeeKey > 0  
;

!set variable_substitution=false;