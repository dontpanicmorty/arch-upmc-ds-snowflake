CREATE OR REPLACE TABLE FDBDATA.RGCNINS0_STUDY_TABLE (
	GCN_SEQNO NUMERIC(6, 0) NOT NULL,
	TOTAL_PRODUCTS_CNT NUMERIC(6, 0) NULL,
	PRODUCTS_RESEARCHED_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RGCNINS0_STUDY_TABLE PRIMARY KEY (GCN_SEQNO)
)
COMMENT = 'Provides packaged product counts for the Clinical Formulation ID (GCN_SEQNO). Counts are based on active NDCs. Counts change as Inactive Ingredient research continues.'
;
