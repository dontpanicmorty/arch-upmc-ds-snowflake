CREATE OR REPLACE VIEW ODSDATA.PRACTITIONER_BOARD_CERTIFICATION_REL_VW
COMMENT = 'Replicated from Azure SQL DB'
AS
SELECT
PractitionerBoardCertificationRel.$1::NUMBER(38,0) AS PRACTITIONER_BOARD_CERTIFICATION_REL_KEY
,PractitionerBoardCertificationRel.$2::NUMBER(38,0) AS PRACTITIONER_KEY
,PractitionerBoardCertificationRel.$3::NUMBER(38,0) AS BOARD_CERTIFICATION_KEY
,PractitionerBoardCertificationRel.$4::NUMBER(38,0) AS BOARD_CERTIFICATION_STATUS_KEY
,PractitionerBoardCertificationRel.$5::DATETIME AS LAST_UPDATED_DATETIME
,PractitionerBoardCertificationRel.$6::DATETIME AS INSERT_DATETIME
,PractitionerBoardCertificationRel.$7::VARCHAR AS BOARD_CERTIFICATION_NBR
,PractitionerBoardCertificationRel.$8::DATE AS CERTIFICATION_DATE
,PractitionerBoardCertificationRel.$9::DATE AS EXPIRATION_DATE
,PractitionerBoardCertificationRel.$10::DATE AS RECERTIFICATION_DATE
,PractitionerBoardCertificationRel.$11::VARCHAR AS LIFETIME_CERTIFICATION_IND
,PractitionerBoardCertificationRel.$12::DATE AS VERIFICATION_DATE
FROM @ODSDATA.HPDSDATALAKE_IDAPSQL/providerods/PractitionerBoardCertificationRel.txt
(FILE_FORMAT => 'ODSDATA.PROVIDER_ODS_FILE_FORMAT')PractitionerBoardCertificationRel
;
