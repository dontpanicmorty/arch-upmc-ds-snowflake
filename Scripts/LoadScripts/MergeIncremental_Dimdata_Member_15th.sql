SET MY_QUERY_TAG = CONCAT(IFNULL(current_database(),''),'.',IFNULL(current_schema(),''),'  -- MergeIncremental_Dimdata_Member_15th.sql');
ALTER SESSION SET QUERY_TAG = $MY_QUERY_TAG;

CALL INFA.SPU_MERGE_FACT_ENROLLMENT_SNAPSHOT_FROM_STAGE();