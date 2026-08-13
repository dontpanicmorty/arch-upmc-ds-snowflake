CREATE OR REPLACE TABLE FDBDATA.RPEIGD0_GCNSEQNO_DF_LINK (
	GCN_SEQNO NUMERIC(6, 0) NOT NULL,
	DOSAGE_FORM_ID NUMERIC(8, 0) NOT NULL,
	DOSAGE_FORM_TYPE_ID NUMERIC(8, 0) NOT NULL,
	LINK_INACTIVEDATE VARCHAR(8) NULL,
	CONSTRAINT PK_RPEIGD0_GCNSEQNO_DF_LINK PRIMARY KEY (GCN_SEQNO, DOSAGE_FORM_ID, DOSAGE_FORM_TYPE_ID)
)
COMMENT = 'Contains associations between a Clinical Formulation Identifier (GCN_SEQNO) and the Final Dosage Form and Alternative Dosage Forms rolled up (see Roll-up in the MAPs Enhancements Concepts section) from directly associated packaged products (NDCs/UPCs).'
;
