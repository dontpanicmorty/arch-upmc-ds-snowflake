CREATE OR REPLACE TABLE FDBDATA.RMEDIS0_MEDID_STUDY_TABLE (
	MEDID NUMERIC(8, 0) NOT NULL,
	TOTAL_PRODUCTS_CNT NUMERIC(6, 0) NULL,
	PRODUCTS_RESEARCHED_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RMEDIS0_MEDID_STUDY_TABLE PRIMARY KEY (MEDID)
)
COMMENT = 'Provides packaged product counts for the Medication ID. Counts are based on active NDCs. Counts are subject to change as Inactive Ingredient research continues.'
;
