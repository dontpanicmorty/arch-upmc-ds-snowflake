CREATE OR REPLACE TABLE FDBDATA.RDPTRG0_ROUTED_GEN_LINK (
	ROUTED_GEN_ID NUMERIC(8, 0) NOT NULL,
	DPT_CLASS_ID NUMERIC(8, 0) NOT NULL,
	CONSTRAINT PK_RDPTRG0_ROUTED_GEN_LINK PRIMARY KEY (ROUTED_GEN_ID, DPT_CLASS_ID)
)
COMMENT = 'Links a routed generic to a duplicate therapy class. The routed generic relationships are programmatically generated from the clinical formulation.'
;
