CREATE OR REPLACE VIEW UTIL.ADF_TRIGGERS_VW
COMMENT='View of current active triggers'
AS
WITH LATEST_FILE AS (
    SELECT
        METADATA$FILENAME AS FILENAME,
        METADATA$FILE_LAST_MODIFIED AS DATE_UPDATED
    FROM
        @UTIL.SNOWFLAKEDATA_USAGE_DATA_DB_EXTRACT/triggers/
    QUALIFY
        ROW_NUMBER() OVER (ORDER BY DATE_UPDATED DESC) = 1
),
DATA AS (
    SELECT
        METADATA$FILENAME AS FILENAME,
        METADATA$FILE_LAST_MODIFIED AS DATE_UPDATED,
        t.value:additional_properties::varchar AS ADDITIONAL_PROPERTIES,
        t.value:id::varchar AS ID,
        t.value:name::varchar AS TRIGGER_NAME,
        t.value:type::varchar AS TRIGGER_TYPE,
        t.value:etag::varchar AS ETAG,
        t.value:properties_additional_properties::varchar AS PROPERTIES_ADDITIONAL_PROPERTIES,
        t.value:properties_type::varchar AS PROPERTIES_TYPE,
        t.value:description::varchar AS DESCRIPTION,
        t.value:runtime_state::varchar AS RUNTIME_STATE,
        t.value:annotations::varchar AS ANNOTATIONS,
        t.value:schedule::varchar AS SCHEDULE,
        t.value:pipelines::varchar AS PIPELINES
    FROM
        @UTIL.SNOWFLAKEDATA_USAGE_DATA_DB_EXTRACT/triggers/
        (FILE_FORMAT => 'UTIL.JSON_FILE_FORMAT') AS S,
        table(flatten(S.$1, 'value')) t
)
SELECT *
FROM (
    SELECT
        ADDITIONAL_PROPERTIES,
        ID,
        TRIGGER_NAME,
        TRIGGER_TYPE,
        ETAG,
        PROPERTIES_ADDITIONAL_PROPERTIES,
        PROPERTIES_TYPE,
        DESCRIPTION,
        RUNTIME_STATE,
        ANNOTATIONS,
        SCHEDULE,
        PIPELINES,
        DATE_UPDATED,
        FILENAME,
        ROW_NUMBER() OVER (PARTITION BY ID ORDER BY DATE_UPDATED DESC) AS RN
    FROM
        DATA
)
WHERE
    RN = 1
;