CREATE OR REPLACE TABLE FDBDATA.RGCNINH0_GCNSEQNO_INACTV_LINK (
	GCN_SEQNO NUMERIC(6, 0) NOT NULL,
	HIC_SEQN NUMERIC(6, 0) NOT NULL,
	INACTV_NOT_PRES_CNT NUMERIC(6, 0) NULL,
	INACTV_PRES_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RGCNINH0_GCNSEQNO_INACTV_LINK PRIMARY KEY (GCN_SEQNO, HIC_SEQN)
)
COMMENT = 'Links packaged product counts to the Clinical Formulation ID (GCN_SEQNO). The counts represent currently active products that either have or do not have the specified HIC_SEQN in their formulation. Packaged products are only considered if they have been checked for inactive Ingredients. Counts change as inactive Ingredient research continues.'
;
