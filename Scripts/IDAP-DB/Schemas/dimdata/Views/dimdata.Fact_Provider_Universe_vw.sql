CREATE OR REPLACE VIEW DIMDATA.FACT_PROVIDER_UNIVERSE_VW
AS
SELECT
FACT_PROVIDER_UNIVERSE_KEY
,MD5_VALUE_TEXT
,INSERT_DATETIME
,LAST_UPDATED_DATETIME
,IS_LOGICAL_DELETE_FLAG
,DIM_TPA_HIERARCHY_KEY
,DIM_PROVIDER_KEY
,DIM_MEDICAL_GROUP_KEY
,DIM_PROVIDER_ADDRESS_KEY
,DIM_STANDARD_ADDRESS_KEY
,DIM_PROVIDER_OWNERSHIP_KEY
,CARE_TYPE_NAME
,RELATIONSHIP_START_DATE
,RELATIONSHIP_START_DATE_KEY
,RELATIONSHIP_TERM_DATE
,RELATIONSHIP_TERM_DATE_KEY
FROM DIMDATA.FACT_PROVIDER_UNIVERSE;
--REVIEWER: this is a straight pass-through of every column on DIMDATA.FACT_PROVIDER_UNIVERSE, matching
--dimdata.Fact_Provider_Contract_vw. Note that dimdata.Fact_Provider_Contract_vw also passes through
--IS_LOGICAL_DELETE_FLAG rather than filtering on it, so logically deleted rows ARE visible through these
--views and consumers are expected to filter. dimdata.Fact_Claim_Authorization_Detail_vw takes a different
--line and drops MD5_VALUE_TEXT and IS_LOGICAL_DELETE_FLAG from its projection entirely. The
--Fact_Provider_Contract convention is followed here since that is the nearer analogue, but if downstream
--consumers should never see deleted rows this view needs a WHERE IS_LOGICAL_DELETE_FLAG = FALSE.
