CREATE OR REPLACE TABLE FDBDATA.RDPTRTM0_ROUTED_MED_LINK (
	ROUTED_MED_ID NUMERIC(8, 0) NOT NULL,
	DPT_CLASS_ID NUMERIC(8, 0) NOT NULL,
	CONSTRAINT PK_RDPTRTM0_ROUTED_MED_LINK PRIMARY KEY (ROUTED_MED_ID, DPT_CLASS_ID)
)
COMMENT = 'Links a routed medication to its duplicate therapy class(es). The routed medication relationships are programmatically generated from the clinical formulation.'
;
