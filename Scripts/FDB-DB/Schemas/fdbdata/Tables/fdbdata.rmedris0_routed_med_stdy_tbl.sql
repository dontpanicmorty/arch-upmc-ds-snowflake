CREATE OR REPLACE TABLE FDBDATA.RMEDRIS0_ROUTED_MED_STDY_TBL (
	ROUTED_MED_ID NUMERIC(8, 0) NOT NULL,
	TOTAL_PRODUCTS_CNT NUMERIC(6, 0) NULL,
	PRODUCTS_RESEARCHED_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RMEDRIS0_ROUTED_MED_STDY_TBL PRIMARY KEY (ROUTED_MED_ID)
)
COMMENT = 'Provides packaged product counts for the Routed Medication ID. Counts are based on active NDCs. Counts are subject to change as Inactive Ingredient research continues.'
;
