CREATE OR REPLACE TABLE FDBDATA.RDFIMMA0_MSTR (
	FDCDE NUMERIC(3, 0) NOT NULL,
	DNAME VARCHAR(21) NULL,
	FD_SL VARCHAR(1) NULL,
	RESULT VARCHAR(45) NULL,
	FDMSG1 VARCHAR(27) NULL,
	FDMSG2 VARCHAR(27) NULL,
	CONSTRAINT PK_RDFIMMA0_MSTR PRIMARY KEY (FDCDE)
)
COMMENT = 'Provides attributes of the drug-food interaction, including a professional message describing the result of the interaction.'
;
