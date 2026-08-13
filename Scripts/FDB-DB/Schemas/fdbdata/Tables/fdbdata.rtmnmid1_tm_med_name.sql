CREATE OR REPLACE TABLE FDBDATA.RTMNMID1_TM_MED_NAME (
	MED_NAME_ID NUMERIC(8, 0) NOT NULL,
	TM_SOURCE_ID NUMERIC(5, 0) NULL,
	TM_IND NUMERIC(1, 0) NULL,
	TM_ALT_MED_NAME_DESC VARCHAR(70) NULL,
	CONSTRAINT PK_RTMNMID1_TM_MED_NAME PRIMARY KEY (MED_NAME_ID)
)
COMMENT = 'When appropriate, provides Tall Man lettering of a Medication Name Concept as well as the sources of the recommendations for inclusion. '
;
