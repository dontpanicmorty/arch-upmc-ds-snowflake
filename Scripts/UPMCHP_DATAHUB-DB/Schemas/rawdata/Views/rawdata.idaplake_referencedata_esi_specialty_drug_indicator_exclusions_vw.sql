CREATE OR REPLACE VIEW RAWDATA.IDAPLAKE_REFERENCEDATA_ESI_SPECIALTY_DRUG_INDICATOR_EXCLUSIONS_VW
COMMENT = 'View to external stage for GCN codes the Pharmacy Team would like to ignore when comparing ESI SPE384 Files to our Specialty Drug Indicator Reference Data Set'
AS
SELECT
$1 AS GCN_CODE
FROM '@RAWDATA.HPDSDATALAKE_IDAPLAKE/referencedata/claim/esi/esi_specialty_drug_indicator_exclusions.txt'
    (FILE_FORMAT => RAWDATA.IDAPLAKE_REFERENCEDATA_FILE_FORMAT)
;