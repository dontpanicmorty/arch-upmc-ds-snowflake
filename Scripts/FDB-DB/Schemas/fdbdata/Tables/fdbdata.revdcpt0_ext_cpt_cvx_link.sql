CREATE OR REPLACE TABLE FDBDATA.REVDCPT0_EXT_CPT_CVX_LINK (
	EVD_CPT_CD VARCHAR(10) NOT NULL,
	EVD_CVX_CD VARCHAR(10) NOT NULL,
	EVD_CPT_CD_DESC VARCHAR(255) NULL,
	EVD_VACCINE_NAME VARCHAR(100) NULL,
	EVD_CPT_STATUS VARCHAR(30) NULL,
	EVD_CPT_CVX_NOTE VARCHAR(255) NULL,
	EVD_CPT_CVX_LAST_UPDATE_DT VARCHAR(8) NULL,
	CONSTRAINT PK_REVDCPT0_EXT_CPT_CVX_LINK PRIMARY KEY (EVD_CPT_CD, EVD_CVX_CD)
)
COMMENT = 'Provides the CDCs mapping of CPT codes to CVX codes. This table is not intended to be a definitive source for a CPT code, description, or status. The table includes both current and historical CPT-CVX mapping records. Active CPT codes, inactive CPT codes and pre-release CPT codes are also included.'
;
