CREATE OR REPLACE TABLE LOGDATA.JOB_LOG (
   	 JOB_ID VARCHAR(16777216) NOT NULL COMMENT 'ADF Pipeline Group Id'
    ,START_TIME TIMESTAMP_TZ(9) NOT NULL
    ,END_TIME TIMESTAMP_TZ(9) NULL
	,PROCEDURE_NAME VARCHAR NOT NULL
    ,CONSTRAINT PK_JOB_LOG PRIMARY KEY (JOB_ID)
	)COMMENT='One row per top level stored procedure to generate and track a JOB_ID which can be used to link together various logging and validaiton tables'
;