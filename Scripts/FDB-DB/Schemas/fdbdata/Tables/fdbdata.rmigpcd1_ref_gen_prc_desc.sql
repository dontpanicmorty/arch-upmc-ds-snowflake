CREATE OR REPLACE TABLE FDBDATA.RMIGPCD1_REF_GEN_PRC_DESC (
	MED_REF_GEN_COMP_PRICE_CD VARCHAR(1) NOT NULL,
	MED_REF_GEN_COMP_PRICE_CD_DESC VARCHAR(90) NOT NULL,
	CONSTRAINT PK_RMIGPCD1_REF_GEN_PRC_DESC PRIMARY KEY (MED_REF_GEN_COMP_PRICE_CD)
)
COMMENT = 'Relates the Reference Generic Comparative Price Code to its text description.Please note that this table is no longer supported within MedKnowledge. All records contain a 9 (no value) price code value and a description value of “This column is not supported.”'
;
