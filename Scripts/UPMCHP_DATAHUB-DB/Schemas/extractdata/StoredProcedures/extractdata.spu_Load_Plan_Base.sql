CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_PLAN_BASE(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.PLAN_BASE`;

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
MERGE INTO EXTRACTDATA.PLAN_BASE tgt
USING (
    SELECT
    HUB_PLAN_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,PLAN_CODE
    ,ACA_HIOS_ID
    ,ACA_MIN_BENEFIT_YEAR
    ,ACA_MARKET_SEGMENT_NAME
    ,ACA_PLAN_TYPE_NAME
    ,ACA_PRODUCT_CODE
    ,ACA_MARKETING_PLAN_NAME
    ,ACA_METAL_LEVEL_CODE
    ,ACA_ON_EXCHANGE_IND
    ,ACA_NETWORK_NAME
    ,ACA_COST_SHARE_TYPE_NAME
    ,PLAN_DESC
    ,PLAN_TYPE_CODE
    ,LOB_CODE
    ,LOB_DESC
    ,LOB_PRODUCT_CODE
    ,LOB_PRODUCT_DESC
    ,LOB_PLAN_TYPE_DESC
    ,PLAN_CATEGORY_NAME
    ,HEALTHY_U_IND
    ,WELLNESS_IND
    ,COMPANY_CODE
    ,FUNDING_TYPE_DESC
    ,BUSINESS_UNIT_DESC
    ,GRANDFATHERED_ACA_PLAN_IND
    ,PLAN_SEGMENT_ARRAY

    FROM HUBDATA.PLAN_BASE_VW
    ${mergeWhereClause}

    MINUS

    SELECT
    HUB_PLAN_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,PLAN_CODE
    ,ACA_HIOS_ID
    ,ACA_MIN_BENEFIT_YEAR
    ,ACA_MARKET_SEGMENT_NAME
    ,ACA_PLAN_TYPE_NAME
    ,ACA_PRODUCT_CODE
    ,ACA_MARKETING_PLAN_NAME
    ,ACA_METAL_LEVEL_CODE
    ,ACA_ON_EXCHANGE_IND
    ,ACA_NETWORK_NAME
    ,ACA_COST_SHARE_TYPE_NAME
    ,PLAN_DESC
    ,PLAN_TYPE_CODE
    ,LOB_CODE
    ,LOB_DESC
    ,LOB_PRODUCT_CODE
    ,LOB_PRODUCT_DESC
    ,LOB_PLAN_TYPE_DESC
    ,PLAN_CATEGORY_NAME
    ,HEALTHY_U_IND
    ,WELLNESS_IND
    ,COMPANY_CODE
    ,FUNDING_TYPE_DESC
    ,BUSINESS_UNIT_DESC
    ,GRANDFATHERED_ACA_PLAN_IND
    ,PLAN_SEGMENT_ARRAY

    FROM EXTRACTDATA.PLAN_BASE
    ${mergeWhereClause}

) src

ON 
    (
    tgt.HUB_PLAN_HKEY = src.HUB_PLAN_HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
    tgt.LAST_UPDATED_DATETIME = :1
    ,tgt.ACA_HIOS_ID = src.ACA_HIOS_ID
    ,tgt.ACA_MIN_BENEFIT_YEAR = src.ACA_MIN_BENEFIT_YEAR
    ,tgt.ACA_MARKET_SEGMENT_NAME = src.ACA_MARKET_SEGMENT_NAME
    ,tgt.ACA_PLAN_TYPE_NAME = src.ACA_PLAN_TYPE_NAME
    ,tgt.ACA_PRODUCT_CODE = src.ACA_PRODUCT_CODE
    ,tgt.ACA_MARKETING_PLAN_NAME = src.ACA_MARKETING_PLAN_NAME
    ,tgt.ACA_METAL_LEVEL_CODE = src.ACA_METAL_LEVEL_CODE
    ,tgt.ACA_ON_EXCHANGE_IND = src.ACA_ON_EXCHANGE_IND 
    ,tgt.ACA_NETWORK_NAME = src.ACA_NETWORK_NAME
    ,tgt.ACA_COST_SHARE_TYPE_NAME = src.ACA_COST_SHARE_TYPE_NAME
    ,tgt.PLAN_DESC = src.PLAN_DESC
    ,tgt.PLAN_TYPE_CODE = src.PLAN_TYPE_CODE
    ,tgt.LOB_CODE = src.LOB_CODE
    ,tgt.LOB_DESC = src.LOB_DESC
    ,tgt.LOB_PRODUCT_CODE = src.LOB_PRODUCT_CODE
    ,tgt.LOB_PRODUCT_DESC = src.LOB_PRODUCT_DESC
    ,tgt.LOB_PLAN_TYPE_DESC = src.LOB_PLAN_TYPE_DESC
    ,tgt.PLAN_CATEGORY_NAME = src.PLAN_CATEGORY_NAME
    ,tgt.WELLNESS_IND = src.WELLNESS_IND
    ,tgt.COMPANY_CODE = src.COMPANY_CODE
    ,tgt.FUNDING_TYPE_DESC = src.FUNDING_TYPE_DESC
    ,tgt.BUSINESS_UNIT_DESC = src.BUSINESS_UNIT_DESC
    ,tgt.GRANDFATHERED_ACA_PLAN_IND = src.GRANDFATHERED_ACA_PLAN_IND
    ,tgt.PLAN_SEGMENT_ARRAY = src.PLAN_SEGMENT_ARRAY

WHEN NOT MATCHED

THEN INSERT 
    (
        HUB_PLAN_HKEY
        ,INSERT_DATETIME
        ,LAST_UPDATED_DATETIME
        ,TPA_CLIENT_ID
        ,TPA_ID
        ,TPA_DIV_ID
        ,DATA_SOURCE_NAME
        ,PLAN_CODE
        ,ACA_HIOS_ID
        ,ACA_MIN_BENEFIT_YEAR
        ,ACA_MARKET_SEGMENT_NAME
        ,ACA_PLAN_TYPE_NAME
        ,ACA_PRODUCT_CODE
        ,ACA_MARKETING_PLAN_NAME
        ,ACA_METAL_LEVEL_CODE
        ,ACA_ON_EXCHANGE_IND
        ,ACA_NETWORK_NAME
        ,ACA_COST_SHARE_TYPE_NAME
        ,PLAN_DESC
        ,PLAN_TYPE_CODE
        ,LOB_CODE
        ,LOB_DESC
        ,LOB_PRODUCT_CODE
        ,LOB_PRODUCT_DESC
        ,LOB_PLAN_TYPE_DESC
        ,PLAN_CATEGORY_NAME
        ,HEALTHY_U_IND
        ,WELLNESS_IND
        ,COMPANY_CODE
        ,FUNDING_TYPE_DESC
        ,BUSINESS_UNIT_DESC
        ,GRANDFATHERED_ACA_PLAN_IND
        ,PLAN_SEGMENT_ARRAY
    )
 VALUES 
    (
        src.HUB_PLAN_HKEY
        ,:1
        ,:1
        ,src.TPA_CLIENT_ID
        ,src.TPA_ID
        ,src.TPA_DIV_ID
        ,src.DATA_SOURCE_NAME
        ,src.PLAN_CODE
        ,src.ACA_HIOS_ID
        ,src.ACA_MIN_BENEFIT_YEAR
        ,src.ACA_MARKET_SEGMENT_NAME
        ,src.ACA_PLAN_TYPE_NAME
        ,src.ACA_PRODUCT_CODE
        ,src.ACA_MARKETING_PLAN_NAME
        ,src.ACA_METAL_LEVEL_CODE
        ,src.ACA_ON_EXCHANGE_IND
        ,src.ACA_NETWORK_NAME
        ,src.ACA_COST_SHARE_TYPE_NAME
        ,src.PLAN_DESC
        ,src.PLAN_TYPE_CODE
        ,src.LOB_CODE
        ,src.LOB_DESC
        ,src.LOB_PRODUCT_CODE
        ,src.LOB_PRODUCT_DESC
        ,src.LOB_PLAN_TYPE_DESC
        ,src.PLAN_CATEGORY_NAME
        ,src.HEALTHY_U_IND
        ,src.WELLNESS_IND
        ,src.COMPANY_CODE
        ,src.FUNDING_TYPE_DESC
        ,src.BUSINESS_UNIT_DESC
        ,src.GRANDFATHERED_ACA_PLAN_IND
        ,src.PLAN_SEGMENT_ARRAY
    )
;`;


//set the WHERE clause for the DELETE statement
var deleteWhereClause = '';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause = `WHERE PLAN_BASE.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND PLAN_BASE_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND PLAN_BASE_VW.HUB_PLAN_HKEY IS NULL `;
}
else
{
    deleteWhereClause = `WHERE PLAN_BASE_VW.HUB_PLAN_HKEY IS NULL `;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.PLAN_BASE
    USING
        (
        SELECT
        PLAN_BASE.HUB_PLAN_HKEY
        FROM EXTRACTDATA.PLAN_BASE
            LEFT OUTER JOIN HUBDATA.PLAN_BASE_VW
                ON (PLAN_BASE_VW.HUB_PLAN_HKEY = PLAN_BASE.HUB_PLAN_HKEY)
        ${deleteWhereClause}
        ) deletes
    WHERE PLAN_BASE.HUB_PLAN_HKEY = deletes.HUB_PLAN_HKEY
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