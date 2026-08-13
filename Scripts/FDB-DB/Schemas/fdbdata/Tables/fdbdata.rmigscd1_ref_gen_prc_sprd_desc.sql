CREATE OR REPLACE TABLE FDBDATA.RMIGSCD1_REF_GEN_PRC_SPRD_DESC (
	MED_REF_GEN_SPREAD_CD VARCHAR(1) NOT NULL,
	MED_REF_GEN_SPREAD_CD_DESC VARCHAR(90) NOT NULL,
	CONSTRAINT PK_RMIGSCD1_REF_GEN_PRC_SPRD_DESC PRIMARY KEY (MED_REF_GEN_SPREAD_CD)
)
COMMENT = 'Relates the Reference Generic Price Spread Code to its text description.Please note that this table is no longer supported within MedKnowledge. All records contain a 9 (no value) price code value and a description value of “This column is not supported.”'
;
