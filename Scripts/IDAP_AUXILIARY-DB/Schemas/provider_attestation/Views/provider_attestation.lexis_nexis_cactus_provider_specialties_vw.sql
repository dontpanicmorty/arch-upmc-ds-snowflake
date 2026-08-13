!set variable_substitution=true;
CREATE OR REPLACE VIEW PROVIDER_ATTESTATION.LEXIS_NEXIS_CACTUS_PROVIDER_SPECIALTIES_VW
(
 PAYER_PROVIDER_ID
, PROVIDER_NAME
, ANCILARY_PROVIDER_IND
, PROVIDER_CATEGORY
, PHYSICIAN_HOSPITAL_ORGANIZATION
, OLD_VALUE
, NEW_VALUE
, ATTESTED_USER
, ATTESTED_DATE
, ATTESTED_PHONE_NBR
, ATTESTED_EMAIL
, CREATED_ON
, SOURCE_FILE_NAME
, CHANGE_TYPE
, AREA_AFFECTED
, CHANGE_REQUIRED
, CHANGE_TYPE_CASSIFICATION
, PHYSICIAN_ACCOUNT_EXECUTIVE
, MULTIPLE_RECORDS_IND
)
COMMENT = 'LEXIS NEXIS CACTUS PROVIDER LEVEL SPECIALTIES VIEW' AS
(SELECT PAYER_PROVIDER_ID
, HA.PROVIDERNAME
, HA.ANCILLARY_PROVIDER_IND
, HA.USER_DEF_01
, HA.USER_DEF_02
, HA.OLD_VALUE
, HA.NEW_VALUE
, HA.CONTACT_NAME
, DATE (HA.ATTESTED_DATE) AS ATTESTED_DATE
, HA.CONTACT_PHONE
, HA.CONTACT_EMAIL
, HA.LOAD_TIME
, HA.FILENAME
, CHANGE_TYPE
, AREA_AFFECTED
, CHANGE_REQUIRED
, CHANGE_TYPE_CLASSIFICATION
, PHYSICIAN_ACCOUNT_EXECUTIVE
, CASE WHEN COUNT(*) OVER (PARTITION BY HA.PAYER_PROVIDER_ID) > 1 THEN 'Y'
	   ELSE 'N' END AS MULTIPLE_RECORDS_IND 
	   FROM 
			(SELECT AFF.*
				    , ROW_NUMBER() OVER (PARTITION BY AFF.PAYER_PROVIDER_ID ORDER BY AFF.PAYER_PROVIDER_ID) AS PAYER_PROVIDER_ID_COUNT 
					 FROM (SELECT DISTINCT PROV.PAYER_PROVIDER_ID
							, COALESCE(NAME_PREFIX,'') || ' ' || COALESCE(FIRST_NAME,'') || ' ' || COALESCE(MIDDLE_NAME,'') || ' ' || COALESCE(LAST_NAME,'') || ' ' || COALESCE(NAME_SUFFIX,'') || ' ' || COALESCE(PROF_SUFFIX,'') AS PROVIDERNAME
							, PA.ANCILLARY_PROVIDER_IND
							, PROV.USER_DEF_01
							, PROV.USER_DEF_02 
						    , C.TAXONOMY_CODE AS OLD_VALUE
						    , CASE
								  WHEN (CASE
												WHEN SUBSTR (TAXONOMY_CODE_VERIFIED,
													1, 1) IN
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
                            WHEN C.STATUS = 'D' THEN NULL
                            ELSE
                                CASE
                                    WHEN SUBSTR (TAXONOMY_CODE_VERIFIED,
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
                                    WHEN C.STATUS = 'D' THEN NULL
                                    ELSE
                                        C.TAXONOMY_CODE_VERIFIED
                                END
                        END AS NEW_VALUE
							, B.CONTACT_NAME
							, DATE(B.ATTESTED_DATE) AS ATTESTED_DATE
							, B.CONTACT_PHONE
							, B.CONTACT_EMAIL
							, PROV.LOAD_TIME
							, PROV.FILENAME
							, CASE
                              WHEN C.STATUS = 'A' THEN 'A - Add Specialty'
                              WHEN c.STATUS = 'U' THEN 'U - Update Specialty'
                              WHEN c.STATUS = 'D' THEN 'D - Delete Specialty'
							END AS CHANGE_TYPE,
							CASE
                              WHEN IS_PRIMARY = 'Y'
                              THEN
                                  'Primary Specialty'
                              WHEN IS_PRIMARY = 'N'
                              THEN
                                  'Secondary Specialty'
                              WHEN     IS_PRIMARY IS NULL
                                   AND Is_Primary_Verified = 'Y'
                              THEN
                                  'Primary Specialty'
                              WHEN     IS_PRIMARY IS NULL
                                   AND IS_PRIMARY_VERIFIED = 'N'
                              THEN
                                  'Secondary Specialty'
                              ELSE
                                  'Specialty'
							END AS AREA_AFFECTED,
							CASE
                              WHEN     c.STATUS = 'A'
                                   AND c.IS_PRIMARY_VERIFIED = 'Y'
                              THEN
                                  'Add Primary Specialty'
                              WHEN     c.STATUS = 'A'
                                   AND c.IS_PRIMARY_VERIFIED = 'N'
                              THEN
                                  'Add Secondary Specialty'
                              WHEN     C.STATUS = 'U'
                                   AND IS_PRIMARY <> IS_PRIMARY_VERIFIED
                                   AND IS_PRIMARY = 'Y'
                              THEN
                                  'Update Primary Specialty to Secondary'
                              WHEN     C.STATUS = 'U'
                                   AND IS_PRIMARY <> IS_PRIMARY_VERIFIED
                                   AND IS_PRIMARY = 'N'
                              THEN
                                  'Update Secondary Specialty to Primary'
                              WHEN C.STATUS = 'D' AND Is_Primary = 'Y'
                              THEN
                                  'Delete Primary Specialty'
                              WHEN C.STATUS = 'D' AND Is_Primary = 'N'
                              THEN
                                  'Delete Secondary Specialty'
                              ELSE
                                  'Investigate Possible Specialty Name Difference'
							END AS CHANGE_REQUIRED
							, CASE WHEN OLD_VALUE = NEW_VALUE THEN 'Rejected'
								   WHEN  NEW_VALUE in ('Internal Medicine', 'Pediatrics', 'Family Practice', 'General Practice') and PROV.USER_DEF_01 = 'Specialist' THEN 'Rejected'
								   ELSE 'Needs Reviewed' END AS CHANGE_TYPE_CLASSIFICATION
							, CASE WHEN COUNT(DISTINCT SA.PAE) =1 THEN MAX(SA.PAE)
								   WHEN COUNT(DISTINCT SA.PAE) > 1 THEN 'multiple'
								   ELSE 'No PAE Listed' END AS PHYSICIAN_ACCOUNT_EXECUTIVE 
                         	FROM  &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PROVIDERINFO_VW PROV
							JOIN PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_DETAIL_SELECT_VW PD ON PROV.PAYER_PROVIDER_ID = PD.SOURCE_PROVIDER_NBR
							LEFT JOIN  (SELECT * , ROW_NUMBER() OVER(PARTITION BY UNIVERSAL_PROVIDER_ID ORDER BY ANCILLARY_PROVIDER_IND DESC,PROVIDER_ADDRESS_START_DATE DESC) AS ROW_NBR FROM PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_ADDRESS_SELECT_VW) PA ON PD.UNIVERSAL_PROVIDER_ID = PA.UNIVERSAL_PROVIDER_ID 
							LEFT JOIN &{IDW}.SACA.STAFF_ASSIGN_VW SA ON SA.OFFICEID = PA.OFFICE_ID
							INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PAYERPROVIDERSPECIALTIES_VW C ON PROV.ATTESTED_ENTITY_UNIQUE_ID = C.ATTESTED_ENTITY_UNIQUE_ID AND PROV.ATTESTED_DATE = C.ATTESTED_DATE
							INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_ATTESTATIONSUMMARY_VW B ON PROV.ATTESTED_ENTITY_UNIQUE_ID = B.ENTITY_UNIQUE_ID AND PROV.ATTESTED_DATE = B.ATTESTED_DATE
							LEFT JOIN &{IDW}.EDW_SHARED.TAXONOMY_LKP TAX ON C.TAXONOMY_CODE_VERIFIED = TAX.TAXONOMY_CODE
							WHERE SUBSTR(PROV.FILENAME, LENGTH(PROV.FILENAME) - 11, 8) = (
            					SELECT MAX(SUBSTR(FILENAME, LENGTH(FILENAME) - 11, 8)) FROM &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PROVIDERINFO_VW) 
            					AND (UPPER(PROV.USER_DEF_02) IN ('HEALTH PLAN DIRECT CREDENTIAL', 'SKYGEN') OR PROV.USER_DEF_02 IS NULL ) 
								AND PA.ROW_NBR = 1 
								AND (C.STATUS IN ('A', 'U')
								AND ( ( TAXONOMY_CODE_VERIFIED <> NVL2 (C.TAXONOMY_CODE, C.TAXONOMY_CODE, ' ')
								    AND TAXONOMY_CODE_VERIFIED IS NOT NULL)
								    OR (IS_PRIMARY_VERIFIED <> NVL2 (IS_PRIMARY, IS_PRIMARY, ' ')
								    AND IS_PRIMARY_VERIFIED IS NOT NULL))
							OR C.STATUS = 'D'
                  )  
				  GROUP BY PROV.PAYER_PROVIDER_ID
					, NAME_PREFIX
					, FIRST_NAME
					, MIDDLE_NAME
					, LAST_NAME
					, NAME_SUFFIX
					, PROF_SUFFIX
					, ANCILLARY_PROVIDER_IND
					, PROV.USER_DEF_01
					, PROV.USER_DEF_02
					, C.TAXONOMY_CODE
					, C.TAXONOMY_CODE_VERIFIED
					, TAX.TAXONOMY_CLASSIFICATION
					, TAX.TAXONOMY_SPECIALIZATION
					, C.STATUS
					, B.CONTACT_NAME
					, B.ATTESTED_DATE
					, B.CONTACT_PHONE
					, B.CONTACT_EMAIL
					, PROV.LOAD_TIME
					, PROV.FILENAME
					, IS_PRIMARY
					, IS_PRIMARY_VERIFIED ) AFF ) HA 
				ORDER BY HA.PAYER_PROVIDER_ID
					, HA.PAYER_PROVIDER_ID_COUNT);
!set variable_substitution=false;