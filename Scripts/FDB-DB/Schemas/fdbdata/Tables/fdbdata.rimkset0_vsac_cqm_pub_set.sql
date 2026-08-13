CREATE OR REPLACE TABLE FDBDATA.RIMKSET0_VSAC_CQM_PUB_SET (
	CQM_SET_ID NUMERIC(8, 0) NOT NULL,
	CQM_PUBLICATION_DESC VARCHAR(255) NOT NULL,
	ADDDATE VARCHAR(8) NOT NULL,
	CMS_REPORTING_YEAR NUMERIC(4, 0) NOT NULL,
	CQM_EXPANSION_VERSION VARCHAR(100) NOT NULL,
	CONSTRAINT PK_RIMKSET0_VSAC_CQM_PUB_SET PRIMARY KEY (CQM_SET_ID)
)
COMMENT = 'Provides publication metadata associated to each Value Set Version provided. Data includes the associated Electronic Clinical Quality Measure (eCQM) publication description, the applicable CMS Reporting Year and the referenced eCQM Expansion Version.'
;
