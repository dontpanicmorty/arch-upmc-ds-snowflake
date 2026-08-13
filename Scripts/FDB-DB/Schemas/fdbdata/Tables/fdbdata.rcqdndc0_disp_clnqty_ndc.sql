CREATE OR REPLACE TABLE FDBDATA.RCQDNDC0_DISP_CLNQTY_NDC (
	NDC VARCHAR(11) NOT NULL,
	CLNQTY_SUBUNIT_QTY NUMERIC(34, 17) NULL,
	CLNQTY_SUBUOM_DESC VARCHAR(70) NOT NULL,
	CLNQTY_PKG_DESC VARCHAR(50) NULL,
	CLNQTY_DESC VARCHAR(255) NOT NULL,
	ERX_QTY NUMERIC(34, 17) NOT NULL,
	ERX_SCRIPT_UOM_DESC VARCHAR(50) NOT NULL,
	ERX_SCRIPT_POTUNIT_CD VARCHAR(10) NOT NULL,
	CONSTRAINT PK_RCQDNDC0_DISP_CLNQTY_NDC PRIMARY KEY (NDC)
)
COMMENT = 'Provides attributes used to assist in the selection of variables (such as the number of inhalations per package when the Min-Max screening unit of measure requires “inhalation”) and provides a consistent path to retrieve the Potency Unit Code for pharmacy refill requests via the SCRIPT 10.6 standard.'
;
