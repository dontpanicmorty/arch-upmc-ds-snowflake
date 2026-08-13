CREATE OR REPLACE TABLE PEGA.STG_CWS_CLAIMLINE
(
	CLAIMLINE_ID	                    NUMBER(3, 0), 
	PZ_INS_KEY          	            VARCHAR, 
	PX_EXTRACT_IDENTIFIER	            VARCHAR, 
	PX_EXTRACT_DATETIME	                VARCHAR, 
	AR1	                                VARCHAR, 
	AR2	                                VARCHAR, 
	BENEFIT_CATEGORY	                VARCHAR, 
	BENEFIT_LEVEL	                    VARCHAR, 
	BILLED_AMOUNT	                    NUMBER(9, 2), 
	CARRIER_CODE	                    VARCHAR, 
	HSA_AMOUNT	                        VARCHAR, 
	OIC_ALLOWED	                        VARCHAR, 
	OIC_PAID	                        VARCHAR, 
	AR3	                                VARCHAR, 
	HRA_AMOUNT	                        VARCHAR, 
	LINE_RECEIVED_DATE	                VARCHAR, 
	UNIT_OR_BASIS_FOR_MEASUREMENT_CODE	NUMBER(7, 0), 
	FILENAME	                        VARCHAR,
    INSERT_DATETIME                     TIMESTAMP_TZ(9) NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    CLAIMLINE_KEY		                NUMBER(38,0) NULL AUTOINCREMENT ORDER NOT NULL,
CONSTRAINT PK_CLAIMLINE PRIMARY KEY (CLAIMLINE_KEY),
CONSTRAINT UK_CLAIMLINE UNIQUE (CLAIMLINE_KEY)
)
COMMENT='Created for CWS_PEGA Migration'
;
