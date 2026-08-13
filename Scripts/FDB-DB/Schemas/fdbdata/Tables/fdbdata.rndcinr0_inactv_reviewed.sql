CREATE OR REPLACE TABLE FDBDATA.RNDCINR0_INACTV_REVIEWED (
	NDC VARCHAR(11) NOT NULL,
	CONSTRAINT PK_RNDCINR0_INACTV_REVIEWED PRIMARY KEY (NDC)
)
COMMENT = 'Provides all packaged products that have been checked for Inactive Ingredients, whether or not they actually contain inactive ingredients.'
;
