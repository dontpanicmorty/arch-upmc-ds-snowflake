CREATE OR REPLACE VIEW ADF.ADF_TRIGGERS_VW AS
SELECT
    v.value:"id"::string           AS trigger_id,
    v.value:"name"::string         AS trigger_name,
    v.value:"etag"::string         AS etag,
    v.value:"properties":"type"::string AS trigger_type,
    v.value:"properties":"description"::string AS description,
    v.value:"properties":"pipelines"::variant as pipelines,
    v.value:"properties":"runtimeState"::string AS runtime_state,

    -- Recurrence details
    v.value:"properties":"typeProperties":"recurrence":"timeZone"::string AS time_zone,
    v.value:"properties":"typeProperties":"recurrence":"frequency"::string AS frequency,
    v.value:"properties":"typeProperties":"recurrence":"interval"::number AS interval,
    v.value:"properties":"typeProperties":"recurrence":"startTime"::timestamp_tz AS start_time,
    v.value:"properties":"typeProperties":"recurrence":"endTime"::timestamp_tz AS end_time
FROM ADF.TRIGGERS_RAW t,
LATERAL FLATTEN(input => t.raw:"value") v;