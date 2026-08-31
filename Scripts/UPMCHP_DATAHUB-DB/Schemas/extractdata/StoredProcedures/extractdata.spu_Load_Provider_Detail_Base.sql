CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_PROVIDER_DETAIL_BASE(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.PROVIDER_DETAIL_BASE`;

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
MERGE INTO EXTRACTDATA.PROVIDER_DETAIL_BASE tgt
USING (
    SELECT
		 TPA_CLIENT_ID
		,TPA_ID
		,TPA_DIV_ID
		,DATA_SOURCE_NAME
		,PROVIDER_ID
		,PROVIDER_TYPE_NAME
		,FULL_NAME
		,FIRST_NAME
		,LAST_NAME
		,MIDDLE_NAME
		,MIDDLE_INITIAL_NAME
		,SUFFIX_NAME
		,GENDER_NAME
		,GENDER_CODE
		,SOCIAL_SECURITY_NBR
		,TAX_ID_NBR
		,EMAIL_ADDRESS
		,DEGREE_TEXT
		,LOCUM_TENENS_IND
		,INVISIBLE_PROVIDER_IND
		,TEMPORARY_PROVIDER_IND
		,NATIONAL_PROVIDER_ID
		,DATE_OF_BIRTH
		,UPIN_NBR
		,WEBSITE_URL
		,PRIMARY_SPECIALTY_NAME
		,PRIMARY_PHO_CODE
		,PRIMARY_PHO_NAME
		,PRIMARY_PHO_TERMINATION_DATE
		,SECONDARY_PHO_CODE
		,SECONDARY_PHO_NAME
		,SECONDARY_PHO_TERMINATION_DATE
		,TERTIARY_PHO_CODE
		,TERTIARY_PHO_NAME
		,TERTIARY_PHO_TERMINATION_DATE
		,PROVIDER_START_DATE
		,ACTIVE_IND
		,PA_MEDICAID_IND
		,PP_ACA_ENHANCED_PAY_IND
		,MALPRACTICE_COVERAGE_IND
		,OWNERSHIP_STATUS_CODE
		,OWNERSHIP_STATUS_DESC
		,URI
		,HKEY

    FROM HUBDATA.PROVIDER_DETAIL_BASE_VW
    ${mergeWhereClause}

    MINUS

    SELECT
        TPA_CLIENT_ID
       ,TPA_ID
       ,TPA_DIV_ID
       ,DATA_SOURCE_NAME
       ,PROVIDER_ID
       ,PROVIDER_TYPE_NAME
       ,FULL_NAME
       ,FIRST_NAME
       ,LAST_NAME
       ,MIDDLE_NAME
       ,MIDDLE_INITIAL_NAME
       ,SUFFIX_NAME
       ,GENDER_NAME
       ,GENDER_CODE
       ,SOCIAL_SECURITY_NBR
       ,TAX_ID_NBR
       ,EMAIL_ADDRESS
       ,DEGREE_TEXT
       ,LOCUM_TENENS_IND
       ,INVISIBLE_PROVIDER_IND
       ,TEMPORARY_PROVIDER_IND
       ,NATIONAL_PROVIDER_ID
       ,DATE_OF_BIRTH
       ,UPIN_NBR
       ,WEBSITE_URL
       ,PRIMARY_SPECIALTY_NAME
       ,PRIMARY_PHO_CODE
       ,PRIMARY_PHO_NAME
       ,PRIMARY_PHO_TERMINATION_DATE
       ,SECONDARY_PHO_CODE
       ,SECONDARY_PHO_NAME
       ,SECONDARY_PHO_TERMINATION_DATE
       ,TERTIARY_PHO_CODE
       ,TERTIARY_PHO_NAME
       ,TERTIARY_PHO_TERMINATION_DATE
       ,PROVIDER_START_DATE
       ,ACTIVE_IND
       ,PA_MEDICAID_IND
       ,PP_ACA_ENHANCED_PAY_IND
       ,MALPRACTICE_COVERAGE_IND
       ,OWNERSHIP_STATUS_CODE
       ,OWNERSHIP_STATUS_DESC
       ,URI
       ,HKEY


    FROM EXTRACTDATA.PROVIDER_DETAIL_BASE
    ${mergeWhereClause}

) src

ON 
    (
    tgt.HKEY = src.HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
        tgt.LAST_UPDATED_DATETIME = :1
        ,tgt.PROVIDER_TYPE_NAME = src.PROVIDER_TYPE_NAME
        ,tgt.FULL_NAME = src.FULL_NAME
        ,tgt.FIRST_NAME = src.FIRST_NAME
        ,tgt.LAST_NAME = src.LAST_NAME
        ,tgt.MIDDLE_NAME = src.MIDDLE_NAME
        ,tgt.MIDDLE_INITIAL_NAME = src.MIDDLE_INITIAL_NAME
        ,tgt.SUFFIX_NAME = src.SUFFIX_NAME
        ,tgt.GENDER_NAME = src.GENDER_NAME
        ,tgt.GENDER_CODE = src.GENDER_CODE
        ,tgt.SOCIAL_SECURITY_NBR = src.SOCIAL_SECURITY_NBR
        ,tgt.TAX_ID_NBR = src.TAX_ID_NBR
        ,tgt.EMAIL_ADDRESS = src.EMAIL_ADDRESS
        ,tgt.DEGREE_TEXT = src.DEGREE_TEXT
        ,tgt.LOCUM_TENENS_IND = src.LOCUM_TENENS_IND
        ,tgt.INVISIBLE_PROVIDER_IND = src.INVISIBLE_PROVIDER_IND
        ,tgt.TEMPORARY_PROVIDER_IND = src.TEMPORARY_PROVIDER_IND
        ,tgt.NATIONAL_PROVIDER_ID = src.NATIONAL_PROVIDER_ID
        ,tgt.DATE_OF_BIRTH = src.DATE_OF_BIRTH
        ,tgt.UPIN_NBR = src.UPIN_NBR
        ,tgt.WEBSITE_URL = src.WEBSITE_URL
        ,tgt.PRIMARY_SPECIALTY_NAME = src.PRIMARY_SPECIALTY_NAME
        ,tgt.PRIMARY_PHO_CODE = src.PRIMARY_PHO_CODE
        ,tgt.PRIMARY_PHO_NAME = src.PRIMARY_PHO_NAME
        ,tgt.PRIMARY_PHO_TERMINATION_DATE = src.PRIMARY_PHO_TERMINATION_DATE
        ,tgt.SECONDARY_PHO_CODE = src.SECONDARY_PHO_CODE
        ,tgt.SECONDARY_PHO_NAME = src.SECONDARY_PHO_NAME
        ,tgt.SECONDARY_PHO_TERMINATION_DATE = src.SECONDARY_PHO_TERMINATION_DATE
        ,tgt.TERTIARY_PHO_CODE = src.TERTIARY_PHO_CODE
        ,tgt.TERTIARY_PHO_NAME = src.TERTIARY_PHO_NAME
        ,tgt.TERTIARY_PHO_TERMINATION_DATE = src.TERTIARY_PHO_TERMINATION_DATE
        ,tgt.PROVIDER_START_DATE = src.PROVIDER_START_DATE
        ,tgt.ACTIVE_IND = src.ACTIVE_IND
        ,tgt.PA_MEDICAID_IND = src.PA_MEDICAID_IND
        ,tgt.PP_ACA_ENHANCED_PAY_IND = src.PP_ACA_ENHANCED_PAY_IND
        ,tgt.MALPRACTICE_COVERAGE_IND = src.MALPRACTICE_COVERAGE_IND
        ,tgt.OWNERSHIP_STATUS_CODE = src.OWNERSHIP_STATUS_CODE
        ,tgt.OWNERSHIP_STATUS_DESC = src.OWNERSHIP_STATUS_DESC
        ,tgt.URI = src.URI

WHEN NOT MATCHED

THEN INSERT 
    (
        INSERT_DATETIME,
        LAST_UPDATED_DATETIME,
		TPA_CLIENT_ID
		,TPA_ID
		,TPA_DIV_ID
		,DATA_SOURCE_NAME
		,PROVIDER_ID
		,PROVIDER_TYPE_NAME
		,FULL_NAME
		,FIRST_NAME
		,LAST_NAME
		,MIDDLE_NAME
		,MIDDLE_INITIAL_NAME
		,SUFFIX_NAME
		,GENDER_NAME
		,GENDER_CODE
		,SOCIAL_SECURITY_NBR
		,TAX_ID_NBR
		,EMAIL_ADDRESS
		,DEGREE_TEXT
		,LOCUM_TENENS_IND
		,INVISIBLE_PROVIDER_IND
		,TEMPORARY_PROVIDER_IND
		,NATIONAL_PROVIDER_ID
		,DATE_OF_BIRTH
		,UPIN_NBR
		,WEBSITE_URL
		,PRIMARY_SPECIALTY_NAME
		,PRIMARY_PHO_CODE
		,PRIMARY_PHO_NAME
		,PRIMARY_PHO_TERMINATION_DATE
		,SECONDARY_PHO_CODE
		,SECONDARY_PHO_NAME
		,SECONDARY_PHO_TERMINATION_DATE
		,TERTIARY_PHO_CODE
		,TERTIARY_PHO_NAME
		,TERTIARY_PHO_TERMINATION_DATE
		,PROVIDER_START_DATE
		,ACTIVE_IND
		,PA_MEDICAID_IND
		,PP_ACA_ENHANCED_PAY_IND
		,MALPRACTICE_COVERAGE_IND
		,OWNERSHIP_STATUS_CODE
		,OWNERSHIP_STATUS_DESC
		,URI
		,HKEY
    )
 VALUES 
    (
         :1
       , :1
	   , src.TPA_CLIENT_ID
	   ,src.TPA_ID
	   ,src.TPA_DIV_ID
	   ,src.DATA_SOURCE_NAME
	   ,src.PROVIDER_ID
	   ,src.PROVIDER_TYPE_NAME
	   ,src.FULL_NAME
	   ,src.FIRST_NAME
	   ,src.LAST_NAME
	   ,src.MIDDLE_NAME
	   ,src.MIDDLE_INITIAL_NAME
	   ,src.SUFFIX_NAME
	   ,src.GENDER_NAME
	   ,src.GENDER_CODE
	   ,src.SOCIAL_SECURITY_NBR
	   ,src.TAX_ID_NBR
	   ,src.EMAIL_ADDRESS
	   ,src.DEGREE_TEXT
	   ,src.LOCUM_TENENS_IND
	   ,src.INVISIBLE_PROVIDER_IND
	   ,src.TEMPORARY_PROVIDER_IND
	   ,src.NATIONAL_PROVIDER_ID
	   ,src.DATE_OF_BIRTH
	   ,src.UPIN_NBR
	   ,src.WEBSITE_URL
	   ,src.PRIMARY_SPECIALTY_NAME
	   ,src.PRIMARY_PHO_CODE
	   ,src.PRIMARY_PHO_NAME
	   ,src.PRIMARY_PHO_TERMINATION_DATE
	   ,src.SECONDARY_PHO_CODE
	   ,src.SECONDARY_PHO_NAME
	   ,src.SECONDARY_PHO_TERMINATION_DATE
	   ,src.TERTIARY_PHO_CODE
	   ,src.TERTIARY_PHO_NAME
	   ,src.TERTIARY_PHO_TERMINATION_DATE
	   ,src.PROVIDER_START_DATE
	   ,src.ACTIVE_IND
	   ,src.PA_MEDICAID_IND
	   ,src.PP_ACA_ENHANCED_PAY_IND
	   ,src.MALPRACTICE_COVERAGE_IND
	   ,src.OWNERSHIP_STATUS_CODE
	   ,src.OWNERSHIP_STATUS_DESC
	   ,src.URI
	   ,src.HKEY
    )
;`;


//set the WHERE clause for the DELETE statement
var deleteWhereClause = '';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause = `WHERE PROVIDER_DETAIL_BASE.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND PROVIDER_DETAIL_BASE_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND PROVIDER_DETAIL_BASE_VW.HKEY IS NULL `;
}
else
{
    deleteWhereClause = `WHERE PROVIDER_DETAIL_BASE_VW.HKEY IS NULL `;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.PROVIDER_DETAIL_BASE
    USING
        (
        SELECT
        PROVIDER_DETAIL_BASE.HKEY
        FROM EXTRACTDATA.PROVIDER_DETAIL_BASE
            LEFT OUTER JOIN HUBDATA.PROVIDER_DETAIL_BASE_VW
                ON (PROVIDER_DETAIL_BASE_VW.HKEY = PROVIDER_DETAIL_BASE.HKEY)
        ${deleteWhereClause}
        ) deletes
    WHERE PROVIDER_DETAIL_BASE.HKEY = deletes.HKEY
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