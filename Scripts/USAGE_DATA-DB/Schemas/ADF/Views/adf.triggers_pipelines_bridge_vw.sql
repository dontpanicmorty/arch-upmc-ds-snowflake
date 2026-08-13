CREATE OR REPLACE VIEW ADF.TRIGGERS_PIPELINES_BRIDGE_VW AS
SELECT
    v.value:"id"::string AS trigger_id,
    v.value:"name"::string AS trigger_name,
    v.value:"properties":"runtimeState"::string AS runtime_state,
    p.value:"pipelineReference":"referenceName"::string AS pipeline_name,
    p.value:"parameters"::variant AS parameters
FROM ADF.TRIGGERS_RAW t,
LATERAL FLATTEN(input => t.raw:"value") v,
LATERAL FLATTEN(input => v.value:"properties":"pipelines") p;