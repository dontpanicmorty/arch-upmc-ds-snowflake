
CREATE OR REPLACE TABLE RAWDATA.FDB_RLBLRID3_LBLR_DESC (
	FILENAME VARCHAR NOT NULL,
	FILE_ROW_NUMBER NUMBER(18,0) NOT NULL,
	FILE_LOAD_DATETIME TIMESTAMP_LTZ(9) NOT NULL,
	LBLRID VARCHAR, --Labeler Identifier
    MFG VARCHAR, --Manufacturer Name
    LBLRIND VARCHAR, --Labeler Indicator Code
	CONSTRAINT PK_FDB_RLBLRID3_LBLR_DESC PRIMARY KEY (FILENAME, FILE_ROW_NUMBER),
    CONSTRAINT UK_FDB_RLBLRID3_LBLR_DESC UNIQUE (FILENAME, FILE_ROW_NUMBER)
)COMMENT='First data bank drug that relates the labeler identifier to its text description and provides attributes of that association (most importantly, manufacturer name)'
;