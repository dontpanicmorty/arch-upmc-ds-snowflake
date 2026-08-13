CREATE OR REPLACE TABLE FDBDATA.RMEDNIS0_MED_NAME_STUDY_TABLE (
	MED_NAME_ID NUMERIC(8, 0) NOT NULL,
	TOTAL_PRODUCTS_CNT NUMERIC(6, 0) NULL,
	PRODUCTS_RESEARCHED_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RMEDNIS0_MED_NAME_STUDY_TABLE PRIMARY KEY (MED_NAME_ID)
)
COMMENT = 'Provides packaged product counts for the Medication Name ID. Counts are based on active NDCs. Counts are subject to change as Inactive Ingredient research continues.'
;
