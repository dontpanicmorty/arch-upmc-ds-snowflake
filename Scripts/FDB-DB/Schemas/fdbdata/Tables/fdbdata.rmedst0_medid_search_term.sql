CREATE OR REPLACE TABLE FDBDATA.RMEDST0_MEDID_SEARCH_TERM (
	MEDID NUMERIC(8, 0) NOT NULL,
	SEARCH_TERM_TYPE_CD NUMERIC(4, 0) NOT NULL,
	SEARCH_TERM_TEXT VARCHAR(150) NOT NULL,
	MED_MEDID_DESC VARCHAR(70) NOT NULL,
	MEDICAL_SUPPLY_IND NUMERIC(1, 0) NOT NULL,
	CONSTRAINT PK_RMEDST0_MEDID_SEARCH_TERM PRIMARY KEY (MEDID, SEARCH_TERM_TYPE_CD, SEARCH_TERM_TEXT)
)
COMMENT = 'Provides search terms used to find orders by medication and the associated dispensable drug MED Medication ID (MEDID). MEDID search values will be deleted from the table when the MEDID is no longer deemed a prescribable medication. The data in this table is contained in both OrderKnowledge and MedKnowledge.'
;
