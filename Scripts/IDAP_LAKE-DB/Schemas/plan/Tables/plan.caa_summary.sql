CREATE OR REPLACE TABLE PLAN.CAA_SUMMARY
(
FILENAME                             VARCHAR,
INSERT_DATETIME                      TIMESTAMP_NTZ,
LOADED_FILE_ROW_NUMBER	   			 NUMBER,
CLIENT_ORG_ID                        VARCHAR,
CLIENT_ORG_NME                       VARCHAR,
CLIENT_CARRIER_ID                    VARCHAR,
CLIENT_CARRIER_NME                   VARCHAR,
CLIENT_CONTRACT_ID                   VARCHAR,
CLIENT_CONTRACT_NME                  VARCHAR,
CLIENT_BENEFIT_ID                    VARCHAR,
CLIENT_BENEFIT_NME                   VARCHAR,
CLIENT_GROUP_ID                      VARCHAR,
CLIENT_GROUP_NME                     VARCHAR,
REFERENCE_YEAR                       VARCHAR,
RXDC_THERAPEUTIC_CLASS_CDE           VARCHAR,
RXDC_THERAPEUTIC_CLASS_NME           VARCHAR,
UTILIZING_MEMBER_CNT                  NUMBER,
CLIENT_ID                            VARCHAR,
TPA_ID                               VARCHAR,
TPA_DIV                              VARCHAR,
CONSTRAINT PK_CAA_SUMMARY PRIMARY KEY (FILENAME, LOADED_FILE_ROW_NUMBER), 
CONSTRAINT UK_CAA_SUMMARY UNIQUE (FILENAME, LOADED_FILE_ROW_NUMBER)
)
COMMENT='Annual Report to CMS for Consolidated Appropriations (No Suprises) Act'
;