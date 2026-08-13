CREATE OR REPLACE TABLE FDBDATA.RNDCINH0_NDC_INACTV_LINK (
	NDC VARCHAR(11) NOT NULL,
	HIC_SEQN NUMERIC(6, 0) NOT NULL,
	CONSTRAINT PK_RNDCINH0_NDC_INACTV_LINK PRIMARY KEY (NDC, HIC_SEQN)
)
COMMENT = 'Links each reviewed packaged product to one or more Inactive Ingredient HIC_SEQN. Packaged products without Inactive Ingredients are not listed in this table.'
;
