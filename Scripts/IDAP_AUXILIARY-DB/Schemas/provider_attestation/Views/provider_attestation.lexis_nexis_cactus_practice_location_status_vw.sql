!set variable_substitution=true;
CREATE OR REPLACE VIEW PROVIDER_ATTESTATION.LEXIS_NEXIS_CACTUS_PRACTICE_LOCATION_STATUS_VW
 (PAYER_PROVIDER_ID
, PROVIDER_NAME
, ANCILLARY_PROVIDER_IND
, ADDRESS_ID
, PAYER_ADDRESS_ID
, PRACTICE_NAME
, PROVIDER_CATEGORY
, PHYSICIAN_HOSPITAL_ORGANIZATION
, TAX_ID_NBR
, UPMC_OWNERSHIP_DESC
, CHANGE_TYPE
, AREA_AFFECTED
, CHENGE_REQUIRED
, OLD_VALUE
, NEW_VALUE
, PRACTICE_NAME_CACTUS
, ADDRESS_LINE1_CACTUS
, ADDRESS_LINE2_CACTUS
, CITY_NAME_CACTUS
, STATE_ABBREVIATION_CACTUS
, ZIP_CODE_CACTUS
, PRIMARY_PHONE_NBR_CACTUS
, ALTERNATE_PHONE_NBR_CACTUS
, ATTESTED_USER
, ATTESTED_DATE
, ATTESTED_PHN_NBR
, ATTESTED_EMAIL
, PHYSICIAN_ACCOUNT_EXECUTIVE
, PCP_OFFICE_IND
, DUAL_CREDENTIALED_IND
, CREATED_ON
, SPECIALTY_NAME
, SOURCE_FILE_NAME
, OLD_NEW_PERCENT_MATCH
, CHANGE_TYPE_CLASSIFICATION
, MULTIPLE_RECORDS_IND) AS 
    (SELECT MR.PAYER_PROVIDER_ID
          , MR.PROVIDER_NAME
          , MR.ANCILLARY_PROVIDER_IND
          , MR.ADDRESS_ID
          , MR.PAYER_ADDRESSID
          , MR.PRACTICE_NAME
          , MR.USER_DEF_01
          , MR.USER_DEF_02
          , MR.TAX_ID
          , MR.PROVIDER_OWNERSHIP_STATUS_SOURCE_DESC
          , MR.CHANGE_TYPE
          , MR.AREA_AFFECTED
          , MR.CHANGE_REQUIRED
          , MR.OLD_VALUE
          , MR.NEW_VALUE
          , MR.OFFICE_NAME
          , MR.ADDRESS_LINE1
          , MR.ADDRESS_LINE2
          , MR.CITY_NAME
          , MR.STATE_ABBREVIATION
          , MR.ZIP_CODE
          , MR.PRIMARY_PHONE_NBR
          , MR.ALTERNATE_PHONE_NBR
          , MR.ATTESTED_USER
          , MR.ATTESTED_DATE
          , MR.CONTACT_PHONE
          , MR.CONTACT_EMAIL 
          , MR.PHYSICIAN_ACCOUNT_EXECUTIVE
          , MR.PCP_OFFICE_IND
          , MR.DUALCREDENTIALEDIND
          , MR.LOAD_TIME
          , MR.SPECIALTY_NAME
          , MR.FILENAME
          , MR.OLD_NEW_PERCENT_MATCH 
          , MR.CHANGE_TYPE_CLASSIFICATION
          , CASE WHEN COUNT(*) OVER (PARTITION BY MR.PAYER_PROVIDER_ID) > 1 THEN 'Y'
                 ELSE 'N' END AS MULTIPLE_RECORDS_IND 
            from (
                  SELECT *,  
                         ROW_NUMBER() OVER (PARTITION BY LOC.PAYER_PROVIDER_ID ORDER BY LOC.PAYER_PROVIDER_ID) AS PAYER_PROVIDER_ID_COUNT FROM 
                        (SELECT DISTINCT A.PAYER_PROVIDER_ID
                                , COALESCE(NAME_PREFIX,'') || ' ' || COALESCE(FIRST_NAME,'') || ' ' || COALESCE(MIDDLE_NAME,'') || ' ' || COALESCE(LAST_NAME,'') || ' ' || COALESCE(NAME_SUFFIX,'') || ' ' || COALESCE(PROF_SUFFIX,'') AS PROVIDER_NAME
                                , PA.ANCILLARY_PROVIDER_IND
                                , C.USER_DEF_06 AS ADDRESS_ID
                                , C.PAYER_ADDRESSID
                                , CASE WHEN C.PRACTICE_NAME = '' THEN C.PRACTICE_NAME_VERIFIED 
                                       ELSE C.PRACTICE_NAME END AS PRACTICE_NAME
                                , A.USER_DEF_01
                                , A.USER_DEF_02
                                , CASE WHEN D.TAX_ID = '' OR D.Tax_ID IS NULL THEN D.TAX_ID_VERIFIED ELSE D.TAX_ID END AS TAX_ID
                                , PA.PROVIDER_OWNERSHIP_STATUS_SOURCE_DESC
                                , CASE WHEN C.status = 'DL' THEN 'DL - Delete Location' 
                                       WHEN C.STATUS = 'DG' THEN 'DG - Delete Group' END AS CHANGE_TYPE
                                , 'Practice Location Status' as AREA_AFFECTED
                                , CASE WHEN C.STATUS = 'DL' THEN 'Remove Provider from Location'  
                                       WHEN C.STATUS = 'DG' THEN 'Remove Provider from Group' END AS CHANGE_REQUIRED
                                , 'GROUP NAME: '|| COALESCE(D.GROUP_NAME,'') ||' NPI: '|| COALESCE(D.ORG_NPI_ID,'') || ' TAX ID: '|| COALESCE(D.TAX_ID,'') || ' ADDRESS: ' || COALESCE(C.Primary_Address,'')|| ' ' ||COALESCE(C.Secondary_Address,'')|| ' ' ||C.City|| ' ' ||C.State|| ' ' ||C.Zip|| ' Phone: ' ||COALESCE(C.PHONE,'')|| ' Fax: ' ||COALESCE(C.FAX,'') as OLD_VALUE
                                , NULL AS NEW_VALUE
                                , PA.OFFICE_NAME
                                , PA.ADDRESS_LINE1
                                , PA.ADDRESS_LINE2
                                , PA.CITY_NAME
                                , PA.STATE_ABBREVIATION
                                , PA.ZIP_CODE
                                , PA.PRIMARY_PHONE_NBR
                                , PA.ALTERNATE_PHONE_NBR
                                , B.CONTACT_NAME AS ATTESTED_USER
                                , DATE(B.ATTESTED_DATE) AS ATTESTED_DATE
                                , B.CONTACT_PHONE
                                , B.CONTACT_EMAIL 
                                , SA.PAE as PHYSICIAN_ACCOUNT_EXECUTIVE
                                , CASE WHEN PA.MA_SUPER_PCP_IND = 'Y' THEN 'Y' else 'N' END AS PCP_OFFICE_IND
                                , CASE WHEN PA.MA_SUPER_PCP_IND = 'Y' THEN 'Y' else 'N' END AS DUALCREDENTIALEDIND
                                , C.LOAD_TIME
                                , CASE WHEN PA.PRIMARY_SPECIALTY_IND = 'Y' THEN  PA.SPECIALTY_NAME ELSE 'No Primary' END AS SPECIALTY_NAME
                                , C.FILENAME
                                , NULL as OLD_NEW_PERCENT_MATCH 
                                , CASE WHEN C.STATUS= 'DG' THEN 'Needs Reviewed'
                                       WHEN C.STATUS in ('DL','DR') and UPPER(A.USER_DEF_01) = 'PRIMARY CARE PHYSICIAN' THEN 'Needs Reviewed'
                                       ELSE 'Accepted' END AS CHANGE_TYPE_CLASSIFICATION
                  FROM &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PROVIDERINFO_VW A
                  INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PRACTICELOCATIONS_VW C
                    ON A.ATTESTED_ENTITY_UNIQUE_ID = C.ATTESTED_ENTITY_UNIQUE_ID
                  JOIN PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_DETAIL_SELECT_VW PD
                    ON C.PAYER_PROVIDER_ID = PD.SOURCE_PROVIDER_NBR
                  LEFT JOIN (SELECT * , ROW_NUMBER() OVER(PARTITION BY UNIVERSAL_PROVIDER_ID, OFFICE_ID ORDER BY ANCILLARY_PROVIDER_IND DESC, PROVIDER_ADDRESS_START_DATE DESC) AS ROW_NBR FROM PROVIDER_ATTESTATION.LKP_LEXIS_NEXIS_CACTUS_PROVIDER_ADDRESS_SELECT_VW) PA 
                    ON PD.UNIVERSAL_PROVIDER_ID = PA.UNIVERSAL_PROVIDER_ID AND PA.OFFICE_ID = C.USER_DEF_06
                  INNER JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_ATTESTATIONLOCATIONSUMMARY_VW  B
                    ON C.ATTESTED_ENTITY_UNIQUE_ID = B.ENTITY_UNIQUE_ID
                    AND C.ATTESTED_DATE = B.ATTESTED_DATE
                    AND C.TOTAL_PRACTICE_ENTITY_ID = B.TOTAL_PRACTICE_ENTITY_ID
                  LEFT JOIN &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PAYERPROVIDERLOCATIONGROUPS_VW D
                    ON C.ATTESTED_ENTITY_UNIQUE_ID = D.ATTESTED_ENTITY_UNIQUE_ID
                    AND C.TOTAL_PRACTICE_ENTITY_ID = D.APL_TOTAL_PRACTICE_ENTITY_ID
                    AND C.ATTESTED_DATE = D.ATTESTED_DATE
                    AND ((D.STATUS <> 'A' AND C.USER_DEF_06 = D.USER_DEF_06)       
                        OR (D.STATUS = 'A' AND NVL(C.USER_DEF_06,'9999999') = NVL(D.USER_DEF_06,'9999999')))
                  LEFT JOIN &{IDW}.SACA.STAFF_ASSIGN_VW SA ON SA.OFFICEID = C.USER_DEF_06
                  WHERE SUBSTR(B.FILENAME, LENGTH(B.FILENAME) - 11, 8) = (
                        SELECT MAX(SUBSTR(FILENAME, LENGTH(FILENAME) - 11, 8)) FROM &{IDAP_LAKE}.PROVIDER.LEXISNEXIS_PRACTICELOCATIONS_VW) and  
                        (UPPER(C.USER_DEF_02) IN ('HEALTH PLAN DIRECT CREDENTIAL', 'SKYGEN') OR C.USER_DEF_02 IS NULL) 
                         AND PA.ROW_NBR = 1 AND  C.STATUS IN ('DL','DG', 'DR')) LOC) MR ORDER BY MR.PAYER_PROVIDER_ID, MR.PAYER_PROVIDER_ID_COUNT);
!set variable_substitution=false;