CREATE OR REPLACE TABLE FDBDATA.RTMMID1_TM_MED (
	MEDID NUMERIC(8, 0) NOT NULL,
	TM_SOURCE_ID NUMERIC(5, 0) NULL,
	TM_IND NUMERIC(1, 0) NULL,
	TM_ALT_MEDID_DESC VARCHAR(70) NULL,
	CONSTRAINT PK_RTMMID1_TM_MED PRIMARY KEY (MEDID)
)
COMMENT = 'When appropriate, provides Tall Man lettering of a Medication Concept as well as the sources of the recommendations for inclusion. '
;
