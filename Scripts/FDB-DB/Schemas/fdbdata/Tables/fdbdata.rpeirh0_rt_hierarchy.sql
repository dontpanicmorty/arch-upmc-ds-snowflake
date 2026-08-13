CREATE OR REPLACE TABLE FDBDATA.RPEIRH0_RT_HIERARCHY (
	PARENT_RT_ID NUMERIC(8, 0) NOT NULL,
	CLINICAL_RT_ID NUMERIC(8, 0) NOT NULL,
	CONSTRAINT PK_RPEIRH0_RT_HIERARCHY PRIMARY KEY (PARENT_RT_ID, CLINICAL_RT_ID)
)
COMMENT = 'Presents a listing of all potential Parent Routes to Clinical Routes outside of the context of a specific drug product.'
;
