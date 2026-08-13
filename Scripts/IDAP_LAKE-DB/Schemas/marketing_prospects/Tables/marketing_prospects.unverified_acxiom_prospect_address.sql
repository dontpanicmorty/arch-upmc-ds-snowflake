CREATE OR REPLACE TABLE MARKETING_PROSPECTS.UNVERIFIED_ACXIOM_PROSPECT_ADDRESS 
(
	ADDRESS_LINE_1 VARCHAR,
	ADDRESS_LINE_2 VARCHAR,
	CITY VARCHAR,
	STATE VARCHAR,
	ZIP VARCHAR,
	ZIP4 VARCHAR,
	ENTITY_REALID_PLACE_ID VARCHAR
)
COMMENT='A distinct list of Acxiom prospect address before being formatted through call to Smarty Streets.  The Smarty Streets fields have the spaces removed for the input into the Smarty Streets API call.'
;