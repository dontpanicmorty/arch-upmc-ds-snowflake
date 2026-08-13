CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_CLAIM_HEADER_REFERRING_PROVIDER(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.CLAIM_HEADER_REFERRING_PROVIDER`;

// Create merge statement to be executed.
// The UPDATE section ONLY includes columns that are not part of the HASH keys because if they changed, it would be a new HASH ;-)
var sqlMergeCommand =
`
MERGE INTO EXTRACTDATA.CLAIM_HEADER_REFERRING_PROVIDER tgt
USING (
    SELECT
    TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,CLAIM_NBR
    ,REFERRING_PROVIDER_ID
    ,REFERRING_PROVIDER_FULL_NAME
    ,REFERRING_PROVIDER_TIN
    ,REFERRING_PROVIDER_NPI
    ,HUB_CLAIM_HKEY
    ,HUB_PROVIDER_HKEY
    FROM HUBDATA.CLAIM_HEADER_REFERRING_PROVIDER_VW
    WHERE DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'

    MINUS

    SELECT 
    TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,CLAIM_NBR
    ,REFERRING_PROVIDER_ID
    ,REFERRING_PROVIDER_FULL_NAME
    ,REFERRING_PROVIDER_TIN
    ,REFERRING_PROVIDER_NPI
    ,HUB_CLAIM_HKEY
    ,HUB_PROVIDER_HKEY
    FROM EXTRACTDATA.CLAIM_HEADER_REFERRING_PROVIDER
    WHERE DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'

) SRC

ON 
    (
    TGT.HUB_CLAIM_HKEY = SRC.HUB_CLAIM_HKEY AND 
    TGT.HUB_PROVIDER_HKEY = SRC.HUB_PROVIDER_HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
    tgt.LAST_UPDATED_DATETIME = :1
    ,tgt.REFERRING_PROVIDER_FULL_NAME = src.REFERRING_PROVIDER_FULL_NAME
    ,tgt.REFERRING_PROVIDER_TIN = src.REFERRING_PROVIDER_TIN
    ,tgt.REFERRING_PROVIDER_NPI = src.REFERRING_PROVIDER_NPI

WHEN NOT MATCHED

THEN INSERT 
    (
        HUB_CLAIM_HKEY
        ,HUB_PROVIDER_HKEY
        ,INSERT_DATETIME
        ,LAST_UPDATED_DATETIME
        ,TPA_CLIENT_ID
        ,TPA_ID
        ,TPA_DIV_ID
        ,DATA_SOURCE_NAME
        ,CLAIM_NBR
        ,REFERRING_PROVIDER_ID
        ,REFERRING_PROVIDER_FULL_NAME
        ,REFERRING_PROVIDER_TIN
        ,REFERRING_PROVIDER_NPI
    )
 VALUES 
    (
        HUB_CLAIM_HKEY
        ,HUB_PROVIDER_HKEY
        ,:1
        ,:1
        ,TPA_CLIENT_ID
        ,TPA_ID
        ,TPA_DIV_ID
        ,DATA_SOURCE_NAME
        ,CLAIM_NBR
        ,REFERRING_PROVIDER_ID
        ,REFERRING_PROVIDER_FULL_NAME
        ,REFERRING_PROVIDER_TIN
        ,REFERRING_PROVIDER_NPI                 
    )
;`;


// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.CLAIM_HEADER_REFERRING_PROVIDER
    USING
        (
        SELECT
        CLAIM_HEADER_REFERRING_PROVIDER.HUB_CLAIM_HKEY, CLAIM_HEADER_REFERRING_PROVIDER.HUB_PROVIDER_HKEY
        FROM EXTRACTDATA.CLAIM_HEADER_REFERRING_PROVIDER
            LEFT OUTER JOIN HUBDATA.CLAIM_HEADER_REFERRING_PROVIDER_VW
                ON (CLAIM_HEADER_REFERRING_PROVIDER_VW.HUB_CLAIM_HKEY = CLAIM_HEADER_REFERRING_PROVIDER.HUB_CLAIM_HKEY
                AND CLAIM_HEADER_REFERRING_PROVIDER_VW.HUB_PROVIDER_HKEY = CLAIM_HEADER_REFERRING_PROVIDER.HUB_PROVIDER_HKEY
                AND CLAIM_HEADER_REFERRING_PROVIDER_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}')
        WHERE CLAIM_HEADER_REFERRING_PROVIDER.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND CLAIM_HEADER_REFERRING_PROVIDER_VW.HUB_CLAIM_HKEY IS NULL
        ) deletes
    WHERE CLAIM_HEADER_REFERRING_PROVIDER.HUB_CLAIM_HKEY = deletes.HUB_CLAIM_HKEY
    AND CLAIM_HEADER_REFERRING_PROVIDER.HUB_PROVIDER_HKEY = deletes.HUB_PROVIDER_HKEY
;`;

var sqlLogCommand = 
`INSERT INTO LOGDATA.TABLE_LOAD_HISTORY 
(JOB_ID, NAME, TYPE, START_TIME, END_TIME, INSERT_COUNT, UPDATE_COUNT, DELETE_COUNT, RESULT_TEXT, SQL_STATEMENT, QUERY_ID)
VALUES (:1,:2,:3,:4::timestamp_ltz,:5::timestamp_ltz,:6,:7,:8,:9,:10,:11);`;

try 
{
     //Lookup Job
    var sqlCommand = `SELECT START_TIME FROM LOGDATA.JOB_LOG WHERE JOB_ID = :1;`;
    var sfStatement = snowflake.createStatement({sqlText: sqlCommand, binds: [JOB_ID]});     
    var rsJobLog = sfStatement.execute();
    while (rsJobLog.next())
    {
        loadDatetime = rsJobLog.getColumnValue("START_TIME")
    }
   
    if (!loadDatetime)
        {
            throw {
                code: "-1",
                message: "Job Id Not Found!",
                stackTraceTxt: new Error().stack,
                state: "00000"
            }
        }

    //Execute MERGE Command
    var startTime = new Date().toISOString();    
    var sfStatement = snowflake.createStatement({sqlText: sqlMergeCommand, binds:[loadDatetime]});
    sfStatement.execute();
    var endTime = new Date().toISOString();
    var result = "Succeeded";

    //Log results to table
    snowflake.execute
    (
        {
        sqlText: sqlLogCommand,
        binds: [JOB_ID, targetTableName, "TABLE", startTime, endTime, sfStatement.getNumRowsInserted(), sfStatement.getNumRowsUpdated(), sfStatement.getNumRowsDeleted(), result, sfStatement.getSqlText(), sfStatement.getQueryId()]
        }
    );

    //Execute DELETE Command
    var startTime = new Date().toISOString();    
    var sfStatement = snowflake.createStatement({sqlText: sqlDeleteCommand});
    sfStatement.execute();
    var endTime = new Date().toISOString();
    var result = "Succeeded";

    //Log results to table
    snowflake.execute
    (
        {
        sqlText: sqlLogCommand,
        binds: [JOB_ID, targetTableName, "TABLE", startTime, endTime, sfStatement.getNumRowsInserted(), sfStatement.getNumRowsUpdated(), sfStatement.getNumRowsDeleted(), result, sfStatement.getSqlText(), sfStatement.getQueryId()]
        }
    );

}

catch (err)
{
    var endTime = new Date().toISOString();
    var result =  "Failed: Code: " + err.code + "\n  State: " + err.state;
    result += "\n  Message: " + err.message;
    result += "\nStack Trace:\n" + err.stackTraceTxt;

    //Log results to table
    var sqlLogCommand = `INSERT INTO LOGDATA.TABLE_LOAD_HISTORY 
        (JOB_ID, NAME, TYPE, START_TIME, END_TIME, RESULT_TEXT, SQL_STATEMENT, ERROR_CODE, ERROR_STATE, ERROR_MESSAGE, ERROR_STACK_TRACE_TEXT, QUERY_ID)
        VALUES (:1,:2,:3,:4::timestamp_ltz,:5::timestamp_ltz,:6,:7,:8,:9,:10,:11,:12);`;

    snowflake.execute
    (
        {
        sqlText: sqlLogCommand,
        binds:[JOB_ID, targetTableName, "TABLE", startTime, endTime, "Failed", sfStatement.getSqlText(), err.code, err.state, err.message, err.stackTraceTxt, sfStatement.getQueryId()]
        }
    );        
    throw result;
}

//Validate what just loaded
sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_DUPE_CHECK('${JOB_ID}','${targetTableName}');`;
snowflake.execute({sqlText});

sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_PRIMARY_KEY_CHECK('${JOB_ID}','${targetTableName}');`;
snowflake.execute({sqlText});

return result;
$$
;