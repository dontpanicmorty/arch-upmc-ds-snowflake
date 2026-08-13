CREATE OR REPLACE TABLE FDBDATA.RPEIST0_STR_CONC_TYPE (
	STR_CONC_TYPE_ID NUMERIC(8, 0) NOT NULL,
	STR_CONC_TYPE_DESC VARCHAR(100) NOT NULL,
	CONSTRAINT PK_RPEIST0_STR_CONC_TYPE PRIMARY KEY (STR_CONC_TYPE_ID)
)
COMMENT = 'Denotes the strength type of an alternative strength assigned to an NDC or rolled up (see Roll-up in the MAPs Enhancements Concepts section) to the Clinical Formulation Identifier (GCN_SEQNO) or Medication Identifier (MEDID).'
;
