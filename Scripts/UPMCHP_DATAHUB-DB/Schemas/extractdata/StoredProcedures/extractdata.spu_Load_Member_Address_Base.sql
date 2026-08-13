CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_MEMBER_ADDRESS_BASE(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.MEMBER_ADDRESS_BASE`;

//set the WHERE clause for the MERGE statement
var mergeWhereClause = '';
if (DATA_SOURCE_NAME)
{
    mergeWhereClause = `WHERE DATA_SOURCE_NAME ='${DATA_SOURCE_NAME}' `;
}

// Create merge statement to be executed.
// The UPDATE section ONLY includes columns that are not part of the HASH keys because if they changed, it would be a new HASH ;-)
var sqlMergeCommand =
`
MERGE INTO EXTRACTDATA.MEMBER_ADDRESS_BASE tgt
USING (
    SELECT
    HUB_MEMBER_ADDRESS_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,MEMBER_NBR
    ,ADDRESS_TYPE_CODE
    ,ADDRESS_LINE_1_TEXT
    ,ADDRESS_LINE_2_TEXT
    ,CITY_NAME
    ,STATE_ABBREV_NAME
    ,ZIP_CODE_NBR
    ,COUNTY_NAME
    ,FIPS_CODE
    ,FIPS_STATE_CODE
    ,FIPS_COUNTY_CODE
    ,LATITUDE_NBR
    ,LONGITUDE_NBR
    ,CONGRESSIONAL_DISTRICT_NAME

    FROM HUBDATA.MEMBER_ADDRESS_BASE_VW
    ${mergeWhereClause}

    MINUS

    SELECT
    HUB_MEMBER_ADDRESS_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,MEMBER_NBR
    ,ADDRESS_TYPE_CODE
    ,ADDRESS_LINE_1_TEXT
    ,ADDRESS_LINE_2_TEXT
    ,CITY_NAME
    ,STATE_ABBREV_NAME
    ,ZIP_CODE_NBR
    ,COUNTY_NAME
    ,FIPS_CODE
    ,FIPS_STATE_CODE
    ,FIPS_COUNTY_CODE
    ,LATITUDE_NBR
    ,LONGITUDE_NBR
    ,CONGRESSIONAL_DISTRICT_NAME

    FROM EXTRACTDATA.MEMBER_ADDRESS_BASE
    ${mergeWhereClause}

) src

ON 
    (
    tgt.HUB_MEMBER_ADDRESS_HKEY = src.HUB_MEMBER_ADDRESS_HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
    tgt.LAST_UPDATED_DATETIME = :1
    ,tgt.ADDRESS_TYPE_CODE = src.ADDRESS_TYPE_CODE
    ,tgt.ADDRESS_LINE_1_TEXT = src.ADDRESS_LINE_1_TEXT
    ,tgt.ADDRESS_LINE_2_TEXT = src.ADDRESS_LINE_2_TEXT
    ,tgt.CITY_NAME = src.CITY_NAME
    ,tgt.STATE_ABBREV_NAME = src.STATE_ABBREV_NAME
    ,tgt.ZIP_CODE_NBR = src.ZIP_CODE_NBR
    ,tgt.COUNTY_NAME = src.COUNTY_NAME
    ,tgt.FIPS_CODE = src.FIPS_CODE
    ,tgt.FIPS_STATE_CODE = src.FIPS_STATE_CODE
    ,tgt.FIPS_COUNTY_CODE = src.FIPS_COUNTY_CODE
    ,tgt.LATITUDE_NBR = src.LATITUDE_NBR
    ,tgt.LONGITUDE_NBR = src.LONGITUDE_NBR
    ,tgt.CONGRESSIONAL_DISTRICT_NAME = src.CONGRESSIONAL_DISTRICT_NAME

WHEN NOT MATCHED

THEN INSERT 
    (
        HUB_MEMBER_ADDRESS_HKEY
        ,INSERT_DATETIME
        ,LAST_UPDATED_DATETIME
        ,TPA_CLIENT_ID
        ,TPA_ID
        ,TPA_DIV_ID
        ,DATA_SOURCE_NAME
        ,MEMBER_NBR
        ,ADDRESS_TYPE_CODE
        ,ADDRESS_LINE_1_TEXT
        ,ADDRESS_LINE_2_TEXT
        ,CITY_NAME
        ,STATE_ABBREV_NAME
        ,ZIP_CODE_NBR
        ,COUNTY_NAME
        ,FIPS_CODE
        ,FIPS_STATE_CODE
        ,FIPS_COUNTY_CODE
        ,LATITUDE_NBR
        ,LONGITUDE_NBR
        ,CONGRESSIONAL_DISTRICT_NAME
    )
 VALUES 
    (
        src.HUB_MEMBER_ADDRESS_HKEY
        ,:1
        ,:1
        ,src.TPA_CLIENT_ID
        ,src.TPA_ID
        ,src.TPA_DIV_ID
        ,src.DATA_SOURCE_NAME
        ,src.MEMBER_NBR
        ,src.ADDRESS_TYPE_CODE
        ,src.ADDRESS_LINE_1_TEXT
        ,src.ADDRESS_LINE_2_TEXT
        ,src.CITY_NAME
        ,src.STATE_ABBREV_NAME
        ,src.ZIP_CODE_NBR
        ,src.COUNTY_NAME
        ,src.FIPS_CODE
        ,src.FIPS_STATE_CODE
        ,src.FIPS_COUNTY_CODE
        ,src.LATITUDE_NBR
        ,src.LONGITUDE_NBR
        ,src.CONGRESSIONAL_DISTRICT_NAME
    )
;`;


//set the WHERE clause for the DELETE statement
var deleteWhereClause = '';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause = `WHERE MEMBER_ADDRESS_BASE.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND MEMBER_ADDRESS_BASE_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND MEMBER_ADDRESS_BASE_VW.HUB_MEMBER_ADDRESS_HKEY IS NULL `;
}
else
{
    deleteWhereClause = `WHERE MEMBER_ADDRESS_BASE_VW.HUB_MEMBER_ADDRESS_HKEY IS NULL `;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.MEMBER_ADDRESS_BASE
    USING
        (
        SELECT
        MEMBER_ADDRESS_BASE.HUB_MEMBER_ADDRESS_HKEY
        FROM EXTRACTDATA.MEMBER_ADDRESS_BASE
            LEFT OUTER JOIN HUBDATA.MEMBER_ADDRESS_BASE_VW
                ON (MEMBER_ADDRESS_BASE_VW.HUB_MEMBER_ADDRESS_HKEY = MEMBER_ADDRESS_BASE.HUB_MEMBER_ADDRESS_HKEY)
        ${deleteWhereClause}
        ) deletes
    WHERE MEMBER_ADDRESS_BASE.HUB_MEMBER_ADDRESS_HKEY = deletes.HUB_MEMBER_ADDRESS_HKEY
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