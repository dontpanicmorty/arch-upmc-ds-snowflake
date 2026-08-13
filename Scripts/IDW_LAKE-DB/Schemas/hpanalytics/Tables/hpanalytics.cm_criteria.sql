CREATE OR REPLACE TABLE HPANALYTICS.CM_CRITERIA
(
CORPORATION_ID                  VARCHAR,
CORPORATION_NAME                VARCHAR,
GROUP_ID                        VARCHAR,
GROUP_DESC                      VARCHAR,
BUSINESS_INSURED_TYPE           VARCHAR,
ASSC_IND                        VARCHAR,
TOTAL_CONTRACTS                  NUMBER,
TOTAL_MEMBERS                    NUMBER,
SALF_IND                        VARCHAR,
AVG_MTHLY_CONTRACTS              NUMBER,
MTH_CNT                          NUMBER,
MTH_START                 TIMESTAMP_NTZ,
MTH_END                   TIMESTAMP_NTZ,
CM_CHECK                        VARCHAR
)
COMMENT='Created for HPANALYTICS Migration'
;
