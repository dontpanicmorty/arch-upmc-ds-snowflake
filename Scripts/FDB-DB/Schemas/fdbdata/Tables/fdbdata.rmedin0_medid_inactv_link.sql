CREATE OR REPLACE TABLE FDBDATA.RMEDIN0_MEDID_INACTV_LINK (
	MEDID NUMERIC(8, 0) NOT NULL,
	HIC_SEQN NUMERIC(6, 0) NOT NULL,
	INACTV_NOT_PRES_CNT NUMERIC(6, 0) NULL,
	INACTV_PRES_CNT NUMERIC(6, 0) NULL,
	CONSTRAINT PK_RMEDIN0_MEDID_INACTV_LINK PRIMARY KEY (MEDID, HIC_SEQN)
)
COMMENT = 'Links an inactive ingredient and packaged product counts to the Medication ID. The counts represent the number of currently active products that either have or do not have the specified inactive HIC_SEQN in their formula. Packaged products are only considered if they have been checked for Inactive Ingredients. Counts change as Inactive Ingredient research continues.'
;
