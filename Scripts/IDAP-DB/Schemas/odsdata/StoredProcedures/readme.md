Delete this file once you start building sprocs

# notes

1. When setting up the ProviderODS sprocs, generate a jobId with the top level procedure then pass that into everything else

//generate a JOB_ID for tracing validations and failures
sqlText = `CALL LOGDATA.SPU_SET_JOB_ID('${procName}')`;
resultSet = snowflake.execute({sqlText});
resultSet.next();
var jobId = resultSet.getColumnValue(1);

2. We should probably? be checking dupes / pks / fks after each individual table and stopping if anything goes wrong
   - in CMS_PRICING everything gets checked at the end in here
     Scripts\CMS_PRICING-DB\Schemas\extractdata\StoredProcedures\extractdata.spu_Run_Extract.sqlproc

# 3 sprocs to get called

sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_PRIMARY_KEY_CHECK(${jobId}, 'schema.tablename');`;
resultSet = snowflake.execute({sqlText});

sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_DUPE_CHECK(${jobId}, 'schema.tablename');`;
resultSet = snowflake.execute({sqlText});

sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_FOREIGN_KEY_CHECK(${jobId}, 'schema.tablename');`;
resultSet = snowflake.execute({sqlText});

3. Other things to verify

- data_source.data_source_key has to match stagedata.provider_ods_data_source.data_source_key because it's baked into providerId in the dims (gross)
  - i didn't hard-code the key values because i want snowflake to autoincrement the table. as long as we run the inserts in the correct order it's ok
    - if we hard-code the keys then try an autoincrement insert later, we'll have duplicate PKs

4. ToDos

- come back and take out STAGEDATA.PROVIDER_ODS_DATA_SOURCE, related static data, & adjust both consuming views once this is deployed
