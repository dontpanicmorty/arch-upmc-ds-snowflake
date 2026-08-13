CREATE OR REPLACE TABLE FDBDATA.RDDIMIN0_NDC_INACTV_DDIM_LINK (
	DDI_NDC VARCHAR(11) NOT NULL,
	DDI_CODEX NUMERIC(5, 0) NOT NULL,
	DDI_NDC_HICSEQN NUMERIC(6, 0) NOT NULL,
	CONSTRAINT PK_RDDIMIN0_NDC_INACTV_DDIM_LINK PRIMARY KEY (DDI_NDC, DDI_CODEX, DDI_NDC_HICSEQN)
)
COMMENT = 'Links a packaged product to each of its inactive ingredient interaction codes. Each Drug-Drug Expanded Interaction Code (DDI_CODEX) in this table results from a drug-drug interaction that involves the specified Inactive Ingredient (DDI_NDC_HICSEQN).'
;
