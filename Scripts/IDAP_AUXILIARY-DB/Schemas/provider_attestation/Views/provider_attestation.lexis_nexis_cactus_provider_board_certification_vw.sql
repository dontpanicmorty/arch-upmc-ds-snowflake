!set variable_substitution=true;
CREATE OR REPLACE VIEW PROVIDER_ATTESTATION.LEXIS_NEXIS_CACTUS_PROVIDER_BOARD_CERTIFICATION_VW
(
  PAYER_PROVIDER_ID
, PROVIDER_NAME
, ANCILLARY_PROVIDER_IND
, PROVIDER_CATEGORY
, PHYSICIAN_HOSPITAL_ORGANIZATION
, OLD_VALUE
, NEW_VALUE
, ATTESTED_USER
, ATTESTED_DATE
, ATTESATED_PHONE
, ATTESTED_EMAIL
, CREATED_ON
, SOURCE_FILE_NAME
, CHANGETYPE
, AREAAFFECTED
, CHANGE_REQUIRED
, CHANGE_TYPE_CASSIFICATION
, MULTIPLE_RECORDS_IND
)
COMMENT = 'LEXIS NEXIS CACTUS PROVIDER BOARD CERTIFICATION VIEW' 
AS (
    SELECT PAYER_PROVIDER_ID
    , HA.PROVIDERNAME
    , HA.ANCILLARY_PROVIDER_IND
	, HA.USER_DEF_01
	, HA.USER_DEF_02
	, HA.OLD_VALUE
	, HA.NEW_VALUE
	, HA.CONTACT_NAME
	, DATE(HA.ATTESTED_DATE) AS ATTESTED_DATE 
	, HA.CONTACT_PHONE
	, HA.CONTACT_EMAIL
	, HA.LOAD_TIME
	, HA.FILENAME
	, CHANGE_TYPE
	, AREA_AFFECTED
	, CHANGE_REQUIRED
	, CHANGE_TYPE_CLASSIFICATION
	, CASE WHEN COUNT(*) OVER (PARTITION BY HA.PAYER_PROVIDER_ID) > 1 THEN 'Y' ELSE 'N' END AS MULTIPLE_RECORDS_IND 
FROM 
    (SELECT *,  ROW_NUMBER() OVER (PARTITION BY AFF.PAYER_PROVIDER_ID ORDER BY AFF.PAYER_PROVIDER_ID) AS PAYER_PROVIDER_ID_COUNT 
    FROM 
        (SELECT DISTINCT PROV.PAYER_PROVIDER_ID
            , COALESCE(NAME_PREFIX,'') || ' ' || COALESCE(FIRST_NAME,'') || ' ' || COALESCE(MIDDLE_NAME,'') || ' ' || COALESCE(LAST_NAME,'') || ' ' || COALESCE(NAME_SUFFIX,'') || ' ' || COALESCE(PROF_SUFFIX,'') AS PROVIDERNAME
            , PA.ANCILLARY_PROVIDER_IND
            , PROV.USER_DEF_01
            , PROV.USER_DEF_02
            , CASE
                              WHEN C.STATUS = 'A'
                              THEN
                                  NULL
                              ELSE
                                     C.IS_BOARD_CERTIFIED
                                  || ' - '
                                  || C.TAXONOMY_CODE
                          END                        AS OLD_VALUE,
                          CASE
                              WHEN C.STATUS = 'D'
                              THEN
                                  NULL
                              ELSE
                                     C.IS_BOARD_CERTIFIED_VERIFIED
                                  || ' - '
                                  || CASE
                                         WHEN (CASE
                                                   WHEN SUBSTR (
                                                            TAXONOMY_CODE_VERIFIED,
                                                            1,
                                                            1) IN
                                                            ('1',
                                                             '2',
                                                             '3',
                                                             '4',
                                                             '5',
                                                             '6',
                                                             '7',
                                                             '8',
                                                             '9',
                                                             '0')
                                                   THEN
                                                          TAX.TAXONOMY_CLASSIFICATION
                                                       || CASE
                                                              WHEN TAX.TAXONOMY_SPECIALIZATION
                                                                       IS NOT NULL
                                                              THEN
                                                                     ' - '
                                                                  || TAX.TAXONOMY_SPECIALIZATION
                                                              ELSE
                                                                  ''
                                                          END
                                                   ELSE
                                                       C.TAXONOMY_CODE_VERIFIED
                                               END)
                                                  IS NULL
                                         THEN
                                             C.TAXONOMY_CODE_VERIFIED
                                         ELSE
                                             CASE
                                                 WHEN SUBSTR (
                                                          TAXONOMY_CODE_VERIFIED,
                                                          1,
                                                          1) IN
                                                          ('1',
                                                           '2',
                                                           '3',
                                                           '4',
                                                           '5',
                                                           '6',
                                                           '7',
                                                           '8',
                                                           '9',
                                                           '0')
                                                 THEN
                                                        TAX.TAXONOMY_CLASSIFICATION
                                                     || CASE
                                                            WHEN TAX.TAXONOMY_SPECIALIZATION
                                                                     IS NOT NULL
                                                            THEN
                                                                   ' - '
                                                                || TAX.TAXONOMY_SPECIALIZATION
                                                            ELSE
                                                                ''
                                                        END
                                                 ELSE
                                                     C.TAXONOMY_CODE_VERIFIED
                                             END
                                     END
                          END AS NEW_VALUE
            , B.CONTACT_NAME
            , DATE (B.ATTESTED_DATE)    AS ATTESTED_DATE
            , B.CONTACT_PHONE
            , B.CONTACT_EMAIL
            , PROV.LOAD_TIME
            , PROV.FILENAME
            , CASE
                  WHEN C.STATUS = 'A'
                  THEN
                      'A - Add Board Certified'
                  WHEN C.STATUS = 'U'
                  THEN
                      'U - Update Board Certified'
                  WHEN C.STATUS = 'D'
                  THEN
                      'D - Delete Board Certified'
              END                        AS CHANGE_TYPE,
              'Board Certified'          AS AREA_AFFECTED,
                          CASE
                  WHEN C.STATUS = 'A' THEN 'Add Board Certified'
                  WHEN C.STATUS = 'U' THEN 'Update Board Certified'
                  WHEN C.STATUS = 'D' THEN 'Delete Board Certified'
              END                        AS CHANGE_REQUIRED,
              CASE
                  WHEN UPPER(NEW_VALUE) like '%CHIROPRACTIC MEDICINE%' or UPPER(NEW_VALUE) like '%GENERAL DENTISTRY%' THEN 'Rejected'
                  ELSE 'Needs Reviewed' END AS CHANGE_TYPE_CLASSIFICATION
        FROM &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PROVIDERINFO_VW PROV
        JOIN PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_DETAIL_SELECT_VW PD 
            ON PROV.PAYER_PROVIDER_ID = PD.SOURCE_PROVIDER_NBR
        LEFT JOIN  (SELECT *, ROW_NUMBER() OVER(PARTITION BY UNIVERSAL_PROVIDER_ID ORDER BY ANCILLARY_PROVIDER_IND DESC, PROVIDER_ADDRESS_START_DATE DESC) AS ROW_NBR FROM PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_ADDRESS_SELECT_VW) PA 
            ON PD.UNIVERSAL_PROVIDER_ID = PA.UNIVERSAL_PROVIDER_ID 
        INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PAYERPROVIDERSPECIALTIES_VW C ON PROV.ATTESTED_ENTITY_UNIQUE_ID = C.ATTESTED_ENTITY_UNIQUE_ID  AND PROV.ATTESTED_DATE = C.ATTESTED_DATE
        INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_ATTESTATIONSUMMARY_VW B
            ON PROV.ATTESTED_ENTITY_UNIQUE_ID = B.ENTITY_UNIQUE_ID AND PROV.ATTESTED_DATE = B.ATTESTED_DATE
        LEFT JOIN &{IDW}.EDW_SHARED.TAXONOMY_LKP TAX 
            ON C.TAXONOMY_CODE_VERIFIED = TAX.TAXONOMY_CODE
        WHERE SUBSTR(PROV.FILENAME, LENGTH(PROV.FILENAME) - 11, 8) = (
            SELECT MAX(SUBSTR(FILENAME, LENGTH(FILENAME) - 11, 8)) FROM &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PROVIDERINFO_VW) AND 
            (UPPER(PROV.USER_DEF_02) IN ('HEALTH PLAN DIRECT CREDENTIAL', 'SKYGEN') OR PROV.USER_DEF_02 IS NULL) 
            AND (C.STATUS IN ('A', 'U')
                AND ( (IS_BOARD_CERTIFIED_VERIFIED <> NVL2 (IS_BOARD_CERTIFIED, IS_BOARD_CERTIFIED,' ')
                AND IS_BOARD_CERTIFIED_VERIFIED IS NOT NULL)
                OR (IS_BOARD_CERTIFIED_VERIFIED <> NVL2 (IS_BOARD_CERTIFIED, IS_BOARD_CERTIFIED,' ') 
                AND IS_BOARD_CERTIFIED_VERIFIED IS NOT NULL))
                OR C.STATUS = 'D') AND PA.ROW_NBR = 1 ) AFF) HA ORDER BY HA.PAYER_PROVIDER_ID, HA.PAYER_PROVIDER_ID_COUNT);

!set variable_substitution=false;
