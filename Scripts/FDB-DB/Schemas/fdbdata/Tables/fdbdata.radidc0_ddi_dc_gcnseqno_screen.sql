CREATE OR REPLACE TABLE FDBDATA.RADIDC0_DDI_DC_GCNSEQNO_SCREEN (
	DDI_MONOX NUMERIC(5, 0) NOT NULL,
	GCN_SEQNO NUMERIC(6, 0) NOT NULL,
	DDI_DC_DAYS_SCREEN_AMOUNT NUMERIC(5, 0) NOT NULL,
	CONSTRAINT PK_RADIDC0_DDI_DC_GCNSEQNO_SCREEN PRIMARY KEY (DDI_MONOX, GCN_SEQNO)
)
COMMENT = 'Relates a clinical formulation to a time duration to continue screening the drug after administration has been discontinued for drug-drug interactions. '
;
