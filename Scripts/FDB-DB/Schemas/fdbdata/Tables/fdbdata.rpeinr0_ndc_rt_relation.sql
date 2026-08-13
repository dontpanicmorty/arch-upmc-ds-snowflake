CREATE OR REPLACE TABLE FDBDATA.RPEINR0_NDC_RT_RELATION (
	NDC VARCHAR(11) NOT NULL,
	PARENT_RT_ID NUMERIC(8, 0) NOT NULL,
	CLINICAL_RT_ID NUMERIC(8, 0) NOT NULL,
	RT_LABELED_ID NUMERIC(8, 0) NOT NULL,
	CONSTRAINT PK_RPEINR0_NDC_RT_RELATION PRIMARY KEY (NDC, PARENT_RT_ID, CLINICAL_RT_ID)
)
COMMENT = 'Contains the association of an NDC to its Parent and Clinical Routes and whether the Clinical Route(s) in the relationship are included on product labeling.'
;
