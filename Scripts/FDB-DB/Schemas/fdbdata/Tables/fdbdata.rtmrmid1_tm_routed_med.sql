CREATE OR REPLACE TABLE FDBDATA.RTMRMID1_TM_ROUTED_MED (
	ROUTED_MED_ID NUMERIC(8, 0) NOT NULL,
	TM_SOURCE_ID NUMERIC(5, 0) NULL,
	TM_IND NUMERIC(1, 0) NULL,
	TM_ALT_ROUTED_MED_ID_DESC VARCHAR(70) NULL,
	CONSTRAINT PK_RTMRMID1_TM_ROUTED_MED PRIMARY KEY (ROUTED_MED_ID)
)
COMMENT = 'When appropriate, provides Tall Man lettering of a Routed Medication Concept as well as the sources of the recommendations for inclusion. '
;
