CREATE OR REPLACE TABLE STAGING.HIXMEMBERMASTER
(
EFFDT                            NUMBER,
PERNO                           VARCHAR,
RECID                           VARCHAR,
SUBNO                           VARCHAR,
TRNDT                           VARCHAR,
DATAVALUE                       VARCHAR,
DESCRIPTION                     VARCHAR,
INSERTID                        VARCHAR,
INSERTTIMESTAMP                 VARCHAR,
LASTUPDATED               TIMESTAMP_NTZ,
LASTAPPLIED               TIMESTAMP_NTZ,
DELETEDFLAG               TIMESTAMP_NTZ,
HIXMEMBERMASTERSEQNBR            NUMBER,
TERMDT                           NUMBER
)
COMMENT='Created for STAGING Migration'
;
