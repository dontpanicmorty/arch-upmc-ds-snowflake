CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_PROVIDER_OWNERSHIP_BASE("JOB_ID" VARCHAR, "DATA_SOURCE_NAME" VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS '
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.PROVIDER_OWNERSHIP_BASE`;

//set the WHERE clause for the MERGE statement
var mergeWhereClause = '''';
if (DATA_SOURCE_NAME)
{
    mergeWhereClause = `WHERE DATA_SOURCE_NAME =''${DATA_SOURCE_NAME}'' `;
}

// Create merge statement to be executed.
// The UPDATE section ONLY includes columns that are not part of the HASH keys because if they changed, it would be a new HASH ;-)
var sqlMergeCommand =
`
MERGE INTO EXTRACTDATA.PROVIDER_OWNERSHIP_BASE tgt
USING (
    SELECT
    TPA_CLIENT_ID,
	TPA_ID,
	TPA_DIV_ID,
	DATA_SOURCE_NAME,
    HUB_MEDICAL_GROUP_HKEY,
    MEDICAL_GROUP_ID,
    OWNERSHIP_DESCRIPTION,
    OWNERSHIP_START_DATE,
    OWNERSHIP_TERM_DATE
    FROM HUBDATA.PROVIDER_OWNERSHIP_BASE_VW
    ${mergeWhereClause}

    MINUS

    SELECT
         TPA_CLIENT_ID,
	     TPA_ID,
	     TPA_DIV_ID,
	     DATA_SOURCE_NAME,
         HUB_MEDICAL_GROUP_HKEY,
         MEDICAL_GROUP_ID,
         OWNERSHIP_DESCRIPTION,
         OWNERSHIP_START_DATE,
         OWNERSHIP_TERM_DATE

    FROM EXTRACTDATA.PROVIDER_OWNERSHIP_BASE
    ${mergeWhereClause}

) src

ON 
    (
    tgt.HUB_MEDICAL_GROUP_HKEY = src.HUB_MEDICAL_GROUP_HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
    tgt.HUB_MEDICAL_GROUP_HKEY = src.HUB_MEDICAL_GROUP_HKEY,
    tgt.MEDICAL_GROUP_ID = src.MEDICAL_GROUP_ID,
    tgt.OWNERSHIP_DESCRIPTION = src.OWNERSHIP_DESCRIPTION,
    tgt.OWNERSHIP_START_DATE = src.OWNERSHIP_START_DATE,
    tgt.OWNERSHIP_TERM_DATE = src.OWNERSHIP_TERM_DATE

WHEN NOT MATCHED

THEN INSERT 
    (
    INSERT_DATETIME,
    LAST_UPDATED_DATETIME,
    TPA_CLIENT_ID,
	TPA_ID,
	TPA_DIV_ID,
	DATA_SOURCE_NAME,
    HUB_MEDICAL_GROUP_HKEY,
    MEDICAL_GROUP_ID,
    OWNERSHIP_DESCRIPTION,
    OWNERSHIP_START_DATE,
    OWNERSHIP_TERM_DATE
     

    )
 VALUES 
    (
        :1,
        :1,
        src.TPA_CLIENT_ID,
		src.TPA_ID,
		src.TPA_DIV_ID,
		src.DATA_SOURCE_NAME,
        src.HUB_MEDICAL_GROUP_HKEY,
        src.MEDICAL_GROUP_ID,
        src.OWNERSHIP_DESCRIPTION,
        src.OWNERSHIP_START_DATE,
        src.OWNERSHIP_TERM_DATE

    )
;`;


//set the WHERE clause for the DELETE statement
var deleteWhereClause = '''';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause = `WHERE PROVIDER_OWNERSHIP_BASE.DATA_SOURCE_NAME = ''${DATA_SOURCE_NAME}''
        AND PROVIDER_OWNERSHIP_BASE_VW.DATA_SOURCE_NAME = ''${DATA_SOURCE_NAME}''
        AND PROVIDER_OWNERSHIP_BASE_VW.HUB_MEDICAL_GROUP_HKEY IS NULL `;
}
else
{
    deleteWhereClause = `WHERE PROVIDER_OWNERSHIP_BASE.HUB_MEDICAL_GROUP_HKEY IS NULL `;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.PROVIDER_OWNERSHIP_BASE
    USING
        (
        SELECT
        PROVIDER_OWNERSHIP_BASE.HUB_MEDICAL_GROUP_HKEY
        FROM EXTRACTDATA.PROVIDER_OWNERSHIP_BASE
            LEFT OUTER JOIN HUBDATA.PROVIDER_OWNERSHIP_BASE_VW
                ON (PROVIDER_OWNERSHIP_BASE_VW.HUB_MEDICAL_GROUP_HKEY = PROVIDER_OWNERSHIP_BASE.HUB_MEDICAL_GROUP_HKEY)
        ${deleteWhereClause}
        ) deletes
    WHERE PROVIDER_OWNERSHIP_BASE.HUB_MEDICAL_GROUP_HKEY = deletes.HUB_MEDICAL_GROUP_HKEY
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
    var result =  "Failed: Code: " + err.code + "\\n  State: " + err.state;
    result += "\\n  Message: " + err.message;
    result += "\\nStack Trace:\\n" + err.stackTraceTxt;

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
sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_DUPE_CHECK(''${JOB_ID}'',''${targetTableName}'');`;
snowflake.execute({sqlText});

sqlText = `CALL LOGDATA.SPU_VALIDATE_DATA_PRIMARY_KEY_CHECK(''${JOB_ID}'',''${targetTableName}'');`;
snowflake.execute({sqlText});

return result;
';