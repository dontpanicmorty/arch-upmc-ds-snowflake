CREATE OR REPLACE TABLE HPANALYTICS.GCS_IP_COUNT
(
MEMBER_NBR                   VARCHAR,
PRIMARY_DX                   VARCHAR,
SERVICE_BEGIN_DATE     TIMESTAMP_NTZ,
BH_IP                         NUMBER,
IP                            NUMBER,
ER                            NUMBER
)
COMMENT='Created for HPANALYTICS Migration'
;
