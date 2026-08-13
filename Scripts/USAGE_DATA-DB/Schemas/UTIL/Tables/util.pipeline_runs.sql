CREATE OR REPLACE EXTERNAL TABLE UTIL.PIPELINE_RUNS
(
PIPELINE_NAME VARCHAR AS (value:pipelineName::varchar), 
DATE_PARTITION VARCHAR AS SPLIT_PART(METADATA$FILENAME,'/',2),
ID VARCHAR AS (value:id::varchar),
RUN_ID VARCHAR AS (value:runId::varchar),
DEBUG_RUN_ID VARCHAR AS (value:debugRunId::varchar),
RUN_GROUP_ID VARCHAR AS (value:runGroupId::varchar),
PIPELINE_PARAMETERS VARCHAR AS (value:parameters::varchar),
INVOKED_BY_ID VARCHAR AS (value:invokedBy:id::varchar),
INVOKED_BY_NAME VARCHAR AS (value:invokedBy:name::varchar),
INVOKED_BY_TYPE VARCHAR AS (value:invokedBy:invokedByType::varchar),
RUN_START VARCHAR AS (value:runStart::varchar),
RUN_END VARCHAR AS (value:runEnd::varchar),
DURATION_IN_MS VARCHAR AS (value:durationInMs::varchar),
STATUS VARCHAR AS (value:status::varchar),
MESSAGE VARCHAR AS (value:message::varchar),
PIPELINE_RETURN_VALUE VARCHAR AS (value:pipelineReturnValue::varchar),
LASTUPDATED VARCHAR AS (value:lastUpdated::varchar),
ANNOTATIONS VARCHAR AS (value:annotations::varchar),
RUN_DIMENSION VARCHAR AS (value:runDimension::varchar),
IS_LATEST VARCHAR AS (value:isLatest::varchar)
)
PARTITION BY (DATE_PARTITION)
WITH LOCATION = @UTIL.SNOWFLAKEDATA_USAGE_DATA_DB_EXTRACT/pipelineRuns/
FILE_FORMAT = 'UTIL.PIPELINE_EXTERNAL_TABLE_FILE_FORMAT';