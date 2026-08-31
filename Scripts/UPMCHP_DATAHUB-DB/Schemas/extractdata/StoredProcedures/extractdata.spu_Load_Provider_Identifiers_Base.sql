CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_PROVIDER_IDENTIFIERS_BASE(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR)
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$

// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.PROVIDER_IDENTIFIERS_BASE`;

//set the WHERE clause for the MERGE statement
var mergeWhereClause = '';
if (DATA_SOURCE_NAME)
{
    mergeWhereClause = `WHERE DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}' `;
}

// Create merge statement to be executed.
var sqlMergeCommand =
`
MERGE INTO EXTRACTDATA.PROVIDER_IDENTIFIERS_BASE TGT
USING (
    SELECT
        HKEY,
        TPA_CLIENT_ID,
        TPA_ID,
        TPA_DIV_ID,
        DATA_SOURCE_NAME,
        PROVIDER_ID,
        PROVIDER_TYPE_NAME,
        IDENTIFIER_NAME,
        IDENTIFIER_SUBTYPE,
        IDENTIFIER_NBR
    FROM HUBDATA.PROVIDER_IDENTIFIERS_VW

    ${mergeWhereClause}

    MINUS

    SELECT
        HKEY,
        TPA_CLIENT_ID,
        TPA_ID,
        TPA_DIV_ID,
        DATA_SOURCE_NAME,
        PROVIDER_ID,
        PROVIDER_TYPE_NAME,
        IDENTIFIER_NAME,
        IDENTIFIER_SUBTYPE,
        IDENTIFIER_NBR
    FROM EXTRACTDATA.PROVIDER_IDENTIFIERS_BASE

    ${mergeWhereClause}

) SRC
ON (
    TGT.HKEY = SRC.HKEY
    AND TGT.PROVIDER_ID = SRC.PROVIDER_ID
    AND TGT.IDENTIFIER_NBR = SRC.IDENTIFIER_NBR
)

WHEN MATCHED

THEN UPDATE

SET
    TGT.LAST_UPDATED_DATETIME = :1,
    TGT.TPA_CLIENT_ID = SRC.TPA_CLIENT_ID,
    TGT.TPA_ID = SRC.TPA_ID,
    TGT.TPA_DIV_ID = SRC.TPA_DIV_ID,
    TGT.DATA_SOURCE_NAME = SRC.DATA_SOURCE_NAME,
    TGT.PROVIDER_TYPE_NAME = SRC.PROVIDER_TYPE_NAME,
    TGT.IDENTIFIER_NAME = SRC.IDENTIFIER_NAME,
    TGT.IDENTIFIER_SUBTYPE = SRC.IDENTIFIER_SUBTYPE

WHEN NOT MATCHED

THEN INSERT
    (
        HKEY,
        INSERT_DATETIME,
        LAST_UPDATED_DATETIME,
        TPA_CLIENT_ID,
        TPA_ID,
        TPA_DIV_ID,
        DATA_SOURCE_NAME,
        PROVIDER_ID,
        PROVIDER_TYPE_NAME,
        IDENTIFIER_NAME,
        IDENTIFIER_SUBTYPE,
        IDENTIFIER_NBR
    )
VALUES
    (
        SRC.HKEY,
        :1,
        :1,
        SRC.TPA_CLIENT_ID,
        SRC.TPA_ID,
        SRC.TPA_DIV_ID,
        SRC.DATA_SOURCE_NAME,
        SRC.PROVIDER_ID,
        SRC.PROVIDER_TYPE_NAME,
        SRC.IDENTIFIER_NAME,
        SRC.IDENTIFIER_SUBTYPE,
        SRC.IDENTIFIER_NBR
    )
;`;

//set the WHERE clause for the DELETE statement
var deleteWhereClause = '';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause =
    `
        WHERE
            PROVIDER_IDENTIFIERS_BASE.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
            AND PROVIDER_IDENTIFIERS_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
            AND PROVIDER_IDENTIFIERS_VW.HKEY IS NULL
    `;
}
else
{
    deleteWhereClause = `WHERE PROVIDER_IDENTIFIERS_VW.HKEY IS NULL`;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`
DELETE FROM EXTRACTDATA.PROVIDER_IDENTIFIERS_BASE
    USING
    (
        SELECT
            PROVIDER_IDENTIFIERS_BASE.HKEY,
            PROVIDER_IDENTIFIERS_BASE.PROVIDER_ID,
            PROVIDER_IDENTIFIERS_BASE.IDENTIFIER_NBR
        FROM
            EXTRACTDATA.PROVIDER_IDENTIFIERS_BASE
        LEFT OUTER JOIN
            HUBDATA.PROVIDER_IDENTIFIERS_VW
            ON (
                PROVIDER_IDENTIFIERS_VW.HKEY = PROVIDER_IDENTIFIERS_BASE.HKEY
                AND PROVIDER_IDENTIFIERS_VW.PROVIDER_ID = PROVIDER_IDENTIFIERS_BASE.PROVIDER_ID
                AND PROVIDER_IDENTIFIERS_VW.IDENTIFIER_NBR = PROVIDER_IDENTIFIERS_BASE.IDENTIFIER_NBR
            )

        ${deleteWhereClause}

    ) DELETES
    WHERE
        PROVIDER_IDENTIFIERS_BASE.HKEY = DELETES.HKEY
        AND PROVIDER_IDENTIFIERS_BASE.PROVIDER_ID = DELETES.PROVIDER_ID
        AND PROVIDER_IDENTIFIERS_BASE.IDENTIFIER_NBR = DELETES.IDENTIFIER_NBR
;`;

var sqlLogCommand =
`
INSERT INTO LOGDATA.TABLE_LOAD_HISTORY (JOB_ID, NAME, TYPE, START_TIME, END_TIME, INSERT_COUNT, UPDATE_COUNT, DELETE_COUNT, RESULT_TEXT, SQL_STATEMENT, QUERY_ID)
    VALUES
        (:1,:2,:3,:4::TIMESTAMP_LTZ,:5::TIMESTAMP_LTZ,:6,:7,:8,:9,:10,:11)
;`;

try
{
    //Lookup Job
    var sqlCommand = `SELECT START_TIME FROM LOGDATA.JOB_LOG WHERE JOB_ID = :1;`;
    var sfStatement = snowflake.createStatement({sqlText: sqlCommand, binds: [JOB_ID]});
    var rsJobLog = sfStatement.execute();

    while (rsJobLog.next())
    {
        loadDatetime = rsJobLog.getColumnValue("START_TIME");
    }

    if (!loadDatetime)
    {
        throw {
            code: "-1",
            message: "Job Id Not Found!",
            stackTraceTxt: new Error().stack,
            state: "00000"
        };
    }

    //Execute MERGE Command
    var startTime = new Date().toISOString();
    var sfStatement = snowflake.createStatement({sqlText: sqlMergeCommand, binds:[loadDatetime]});
    sfStatement.execute();
    var endTime = new Date().toISOString();
    var result = "Succeeded";

    //Log results to table
    snowflake.execute(
    {
        sqlText: sqlLogCommand,
        binds: [
            JOB_ID,
            targetTableName,
            "TABLE",
            startTime,
            endTime,
            sfStatement.getNumRowsInserted(),
            sfStatement.getNumRowsUpdated(),
            sfStatement.getNumRowsDeleted(),
            result,
            sfStatement.getSqlText(),
            sfStatement.getQueryId()
        ]
    });

    //Execute DELETE Command
    var startTime = new Date().toISOString();
    var sfStatement = snowflake.createStatement({sqlText: sqlDeleteCommand});
    sfStatement.execute();
    var endTime = new Date().toISOString();
    var result = "Succeeded";

    //Log results to table
    snowflake.execute(
    {
        sqlText: sqlLogCommand,
        binds: [
            JOB_ID,
            targetTableName,
            "TABLE",
            startTime,
            endTime,
            sfStatement.getNumRowsInserted(),
            sfStatement.getNumRowsUpdated(),
            sfStatement.getNumRowsDeleted(),
            result,
            sfStatement.getSqlText(),
            sfStatement.getQueryId()
        ]
    });
}
catch (err)
{
    var endTime = new Date().toISOString();
    var result = "Failed: Code: " + err.code + "\n  State: " + err.state;
    result += "\n  Message: " + err.message;
    result += "\nStack Trace:\n" + err.stackTraceTxt;

    var sqlLogCommand =
    `
    INSERT INTO LOGDATA.TABLE_LOAD_HISTORY (JOB_ID, NAME, TYPE, START_TIME, END_TIME, RESULT_TEXT, SQL_STATEMENT, ERROR_CODE, ERROR_STATE, ERROR_MESSAGE, ERROR_STACK_TRACE_TEXT, QUERY_ID)
        VALUES
            (:1,:2,:3,:4::TIMESTAMP_LTZ,:5::TIMESTAMP_LTZ,:6,:7,:8,:9,:10,:11,:12)
    ;`;

    snowflake.execute(
    {
        sqlText: sqlLogCommand,
        binds: [
            JOB_ID,
            targetTableName,
            "TABLE",
            startTime,
            endTime,
            "Failed",
            sfStatement.getSqlText(),
            err.code,
            err.state,
            err.message,
            err.stackTraceTxt,
            sfStatement.getQueryId()
        ]
    });

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