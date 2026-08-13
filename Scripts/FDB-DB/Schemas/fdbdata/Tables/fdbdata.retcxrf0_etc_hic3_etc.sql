CREATE OR REPLACE TABLE FDBDATA.RETCXRF0_ETC_HIC3_ETC (
	ETC_ID NUMERIC(8, 0) NOT NULL,
	HIC3_SEQN NUMERIC(6, 0) NOT NULL,
	CONSTRAINT PK_RETCXRF0_ETC_HIC3_ETC PRIMARY KEY (ETC_ID, HIC3_SEQN)
)
COMMENT = 'Provides a link to all ETCs that are equal to or narrower than a given Hierarchical Ingredient Code 3 Specific Therapeutic Classification (HIC3).'
;
