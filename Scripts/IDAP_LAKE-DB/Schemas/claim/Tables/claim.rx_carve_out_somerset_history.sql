CREATE OR REPLACE TABLE CLAIM.RX_CARVE_OUT_SOMERSET_HISTORY
(
    FILENAME                                VARCHAR,
    INSERT_DATETIME                         TIMESTAMP_NTZ,
    GROUP_NUMBER                            VARCHAR,
    CLAIM_NBR                               VARCHAR,
    RECORD_IDENTIFIER                       VARCHAR,
    PHARMACY_NUMBER                         VARCHAR,
    PRESCRIPTION_NUMBER                     VARCHAR,
    CLAIM_NBR_2                             VARCHAR,
    MEMBER_FIRST_NAME                       VARCHAR,
    MEMBER_LAST_NAME                        VARCHAR,
    DATE_OF_BIRTH                           DATE,
    MEMBEREFFECTIVEDATE                     DATE,
    MEMBERTERMDATE                          DATE NULL,
    SOURCEMEMBERNBR                         VARCHAR,
    SOCIALSECURITYNBR                       VARCHAR,
    PRESCRIPTION_FILL_DATE                  DATE,
    DRUG_BRAND_NAME                         VARCHAR,
    PRESCRIBER_NAME                         VARCHAR,
    PAID_DATE                               DATE,
    PRESCRIBER_IDENTIFIER                   VARCHAR,
    AMOUNT_PAID                             FLOAT
);