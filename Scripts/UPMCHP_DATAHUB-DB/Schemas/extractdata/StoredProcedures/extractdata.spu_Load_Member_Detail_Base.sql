CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_MEMBER_DETAIL_BASE(JOB_ID VARCHAR, DATA_SOURCE_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
// get procedure start time and set variables
var startTime = new Date().toISOString();
var loadDatetime = null;
var procedureName = Object.keys(this)[0];
var targetTableName = `EXTRACTDATA.MEMBER_DETAIL_BASE`;

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
MERGE INTO EXTRACTDATA.MEMBER_DETAIL_BASE tgt
USING (
    SELECT
    HUB_MEMBER_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,MEMBER_NBR
    ,SUBSCRIBER_NBR
    ,PERSON_NBR
    ,MASTER_MEMBER_ID
    ,MEMBER_TYPE_CODE
    ,FULL_NAME
    ,LAST_NAME
    ,FIRST_NAME
    ,MIDDLE_NAME
    ,MIDDLE_INITIAL_NAME
    ,NAME_SUFFIX
    ,SALUTORY_NAME
    ,GENDER_CODE
    ,GENDER_DESC
    ,RACE_CODE
    ,BIRTH_DATE
    ,DEATH_DATE
    ,ADDED_DATE
    ,SUBSCRIBER_RELATIONSHIP_CODE
    ,SUBSCRIBER_RELATIONSHIP_DESC
    ,SUBSCRIBER_RELATIONSHIP_TYPE_CODE
    ,MARITAL_STATUS_CODE
    ,MARITAL_STATUS_EFF_DATE
    ,RESTRICTED_MEMBER_FLAG
    ,DPW_COUNTY_CODE
    ,PRIVACY_RESTRICTION_FLAG
    ,PRIVACY_ALERT_FLAG
    ,SOCIAL_SECURITY_NBR
    ,EMPI_NBR
    ,RESPONSIBLE_PARTY_NAME
    ,MA_RECIPIENT_ID
    ,MEDICAID_ID
    ,EPIC_MR_NBR
    ,EPIC_ENT_ID
    ,MEDIPAC_MR_NBR
    ,HFCA_NBR
    ,EMPLOYEE_NBR
    ,SECONDARY_MEMBER_IDENTIFIER_TEXT
    ,TERTIARY_MEMBER_IDENTIFIER_TEXT
    ,CURRENT_ELIG_STATUS_CODE01
    ,CURRENT_ELIG_STATUS_DESC01
    ,CURRENT_ELIG_STATUS_CODE02
    ,CURRENT_ELIG_STATUS_DESC02
    ,PART_D_RISK_FACTOR
    ,CHRONIC_CONDITION_CNT
    ,PREGNANCY_DUE_DATE
    ,ADDRESS_ARRAY

    FROM HUBDATA.MEMBER_DETAIL_BASE_VW
    ${mergeWhereClause}

    MINUS

    SELECT
    HUB_MEMBER_HKEY
    ,TPA_CLIENT_ID
    ,TPA_ID
    ,TPA_DIV_ID
    ,DATA_SOURCE_NAME
    ,MEMBER_NBR
    ,SUBSCRIBER_NBR
    ,PERSON_NBR
    ,MASTER_MEMBER_ID
    ,MEMBER_TYPE_CODE
    ,FULL_NAME
    ,LAST_NAME
    ,FIRST_NAME
    ,MIDDLE_NAME
    ,MIDDLE_INITIAL_NAME
    ,NAME_SUFFIX
    ,SALUTORY_NAME
    ,GENDER_CODE
    ,GENDER_DESC
    ,RACE_CODE
    ,BIRTH_DATE
    ,DEATH_DATE
    ,ADDED_DATE
    ,SUBSCRIBER_RELATIONSHIP_CODE
    ,SUBSCRIBER_RELATIONSHIP_DESC
    ,SUBSCRIBER_RELATIONSHIP_TYPE_CODE
    ,MARITAL_STATUS_CODE
    ,MARITAL_STATUS_EFF_DATE
    ,RESTRICTED_MEMBER_FLAG
    ,DPW_COUNTY_CODE
    ,PRIVACY_RESTRICTION_FLAG
    ,PRIVACY_ALERT_FLAG
    ,SOCIAL_SECURITY_NBR
    ,EMPI_NBR
    ,RESPONSIBLE_PARTY_NAME
    ,MA_RECIPIENT_ID
    ,MEDICAID_ID
    ,EPIC_MR_NBR
    ,EPIC_ENT_ID
    ,MEDIPAC_MR_NBR
    ,HFCA_NBR
    ,EMPLOYEE_NBR
    ,SECONDARY_MEMBER_IDENTIFIER_TEXT
    ,TERTIARY_MEMBER_IDENTIFIER_TEXT
    ,CURRENT_ELIG_STATUS_CODE01
    ,CURRENT_ELIG_STATUS_DESC01
    ,CURRENT_ELIG_STATUS_CODE02
    ,CURRENT_ELIG_STATUS_DESC02
    ,PART_D_RISK_FACTOR
    ,CHRONIC_CONDITION_CNT
    ,PREGNANCY_DUE_DATE
    ,ADDRESS_ARRAY

    FROM EXTRACTDATA.MEMBER_DETAIL_BASE
    ${mergeWhereClause}

) src

ON 
    (
    tgt.HUB_MEMBER_HKEY = src.HUB_MEMBER_HKEY
    )

WHEN MATCHED
THEN UPDATE
SET 
    tgt.LAST_UPDATED_DATETIME = :1
    ,tgt.SUBSCRIBER_NBR = src.SUBSCRIBER_NBR
    ,tgt.PERSON_NBR = src.PERSON_NBR
    ,tgt.MASTER_MEMBER_ID = src.MASTER_MEMBER_ID
    ,tgt.MEMBER_TYPE_CODE = src.MEMBER_TYPE_CODE
    ,tgt.FULL_NAME = src.FULL_NAME
    ,tgt.LAST_NAME = src.LAST_NAME
    ,tgt.FIRST_NAME = src.FIRST_NAME
    ,tgt.MIDDLE_NAME = src.MIDDLE_NAME
    ,tgt.MIDDLE_INITIAL_NAME = src.MIDDLE_INITIAL_NAME
    ,tgt.NAME_SUFFIX = src.NAME_SUFFIX
    ,tgt.SALUTORY_NAME = src.SALUTORY_NAME
    ,tgt.GENDER_CODE = src.GENDER_CODE
    ,tgt.GENDER_DESC = src.GENDER_DESC
    ,tgt.RACE_CODE = src.RACE_CODE
    ,tgt.BIRTH_DATE = src.BIRTH_DATE
    ,tgt.DEATH_DATE = src.DEATH_DATE
    ,tgt.ADDED_DATE = src.ADDED_DATE
    ,tgt.SUBSCRIBER_RELATIONSHIP_CODE = src.SUBSCRIBER_RELATIONSHIP_CODE
    ,tgt.SUBSCRIBER_RELATIONSHIP_DESC = src.SUBSCRIBER_RELATIONSHIP_DESC
    ,tgt.SUBSCRIBER_RELATIONSHIP_TYPE_CODE = src.SUBSCRIBER_RELATIONSHIP_TYPE_CODE
    ,tgt.MARITAL_STATUS_CODE = src.MARITAL_STATUS_CODE
    ,tgt.MARITAL_STATUS_EFF_DATE = src.MARITAL_STATUS_EFF_DATE
    ,tgt.RESTRICTED_MEMBER_FLAG = src.RESTRICTED_MEMBER_FLAG
    ,tgt.DPW_COUNTY_CODE = src.DPW_COUNTY_CODE
    ,tgt.PRIVACY_RESTRICTION_FLAG = src.PRIVACY_RESTRICTION_FLAG
    ,tgt.PRIVACY_ALERT_FLAG = src.PRIVACY_ALERT_FLAG
    ,tgt.SOCIAL_SECURITY_NBR = src.SOCIAL_SECURITY_NBR
    ,tgt.EMPI_NBR = src.EMPI_NBR
    ,tgt.RESPONSIBLE_PARTY_NAME = src.RESPONSIBLE_PARTY_NAME
    ,tgt.MA_RECIPIENT_ID = src.MA_RECIPIENT_ID
    ,tgt.MEDICAID_ID = src.MEDICAID_ID
    ,tgt.EPIC_MR_NBR = src.EPIC_MR_NBR
    ,tgt.EPIC_ENT_ID = src.EPIC_ENT_ID
    ,tgt.MEDIPAC_MR_NBR = src.MEDIPAC_MR_NBR
    ,tgt.HFCA_NBR = src.HFCA_NBR
    ,tgt.EMPLOYEE_NBR = src.EMPLOYEE_NBR
    ,tgt.SECONDARY_MEMBER_IDENTIFIER_TEXT = src.SECONDARY_MEMBER_IDENTIFIER_TEXT
    ,tgt.TERTIARY_MEMBER_IDENTIFIER_TEXT = src.TERTIARY_MEMBER_IDENTIFIER_TEXT
    ,tgt.CURRENT_ELIG_STATUS_CODE01 = src.CURRENT_ELIG_STATUS_CODE01
    ,tgt.CURRENT_ELIG_STATUS_DESC01 = src.CURRENT_ELIG_STATUS_DESC01
    ,tgt.CURRENT_ELIG_STATUS_CODE02 = src.CURRENT_ELIG_STATUS_CODE02
    ,tgt.CURRENT_ELIG_STATUS_DESC02 = src.CURRENT_ELIG_STATUS_DESC02
    ,tgt.PART_D_RISK_FACTOR = src.PART_D_RISK_FACTOR
    ,tgt.CHRONIC_CONDITION_CNT = src.CHRONIC_CONDITION_CNT
    ,tgt.PREGNANCY_DUE_DATE = src.PREGNANCY_DUE_DATE
    ,tgt.ADDRESS_ARRAY = src.ADDRESS_ARRAY

WHEN NOT MATCHED

THEN INSERT 
    (
        HUB_MEMBER_HKEY
        ,INSERT_DATETIME
        ,LAST_UPDATED_DATETIME
        ,TPA_CLIENT_ID
        ,TPA_ID
        ,TPA_DIV_ID
        ,DATA_SOURCE_NAME
        ,MEMBER_NBR
        ,SUBSCRIBER_NBR
        ,PERSON_NBR
        ,MASTER_MEMBER_ID
        ,MEMBER_TYPE_CODE
        ,FULL_NAME
        ,LAST_NAME
        ,FIRST_NAME
        ,MIDDLE_NAME
        ,MIDDLE_INITIAL_NAME
        ,NAME_SUFFIX
        ,SALUTORY_NAME
        ,GENDER_CODE
        ,GENDER_DESC
        ,RACE_CODE
        ,BIRTH_DATE
        ,DEATH_DATE
        ,ADDED_DATE
        ,SUBSCRIBER_RELATIONSHIP_CODE
        ,SUBSCRIBER_RELATIONSHIP_DESC
        ,SUBSCRIBER_RELATIONSHIP_TYPE_CODE
        ,MARITAL_STATUS_CODE
        ,MARITAL_STATUS_EFF_DATE
        ,RESTRICTED_MEMBER_FLAG
        ,DPW_COUNTY_CODE
        ,PRIVACY_RESTRICTION_FLAG
        ,PRIVACY_ALERT_FLAG
        ,SOCIAL_SECURITY_NBR
        ,EMPI_NBR
        ,RESPONSIBLE_PARTY_NAME
        ,MA_RECIPIENT_ID
        ,MEDICAID_ID
        ,EPIC_MR_NBR
        ,EPIC_ENT_ID
        ,MEDIPAC_MR_NBR
        ,HFCA_NBR
        ,EMPLOYEE_NBR
        ,SECONDARY_MEMBER_IDENTIFIER_TEXT
        ,TERTIARY_MEMBER_IDENTIFIER_TEXT
        ,CURRENT_ELIG_STATUS_CODE01
        ,CURRENT_ELIG_STATUS_DESC01
        ,CURRENT_ELIG_STATUS_CODE02
        ,CURRENT_ELIG_STATUS_DESC02
        ,PART_D_RISK_FACTOR
        ,CHRONIC_CONDITION_CNT
        ,PREGNANCY_DUE_DATE
        ,ADDRESS_ARRAY
    )
 VALUES 
    (
        src.HUB_MEMBER_HKEY
        ,:1
        ,:1
        ,src.TPA_CLIENT_ID
        ,src.TPA_ID
        ,src.TPA_DIV_ID
        ,src.DATA_SOURCE_NAME
        ,src.MEMBER_NBR
        ,src.SUBSCRIBER_NBR
        ,src.PERSON_NBR
        ,src.MASTER_MEMBER_ID
        ,src.MEMBER_TYPE_CODE
        ,src.FULL_NAME
        ,src.LAST_NAME
        ,src.FIRST_NAME
        ,src.MIDDLE_NAME
        ,src.MIDDLE_INITIAL_NAME
        ,src.NAME_SUFFIX
        ,src.SALUTORY_NAME
        ,src.GENDER_CODE
        ,src.GENDER_DESC
        ,src.RACE_CODE
        ,src.BIRTH_DATE
        ,src.DEATH_DATE
        ,src.ADDED_DATE
        ,src.SUBSCRIBER_RELATIONSHIP_CODE
        ,src.SUBSCRIBER_RELATIONSHIP_DESC
        ,src.SUBSCRIBER_RELATIONSHIP_TYPE_CODE
        ,src.MARITAL_STATUS_CODE
        ,src.MARITAL_STATUS_EFF_DATE
        ,src.RESTRICTED_MEMBER_FLAG
        ,src.DPW_COUNTY_CODE
        ,src.PRIVACY_RESTRICTION_FLAG
        ,src.PRIVACY_ALERT_FLAG
        ,src.SOCIAL_SECURITY_NBR
        ,src.EMPI_NBR
        ,src.RESPONSIBLE_PARTY_NAME
        ,src.MA_RECIPIENT_ID
        ,src.MEDICAID_ID
        ,src.EPIC_MR_NBR
        ,src.EPIC_ENT_ID
        ,src.MEDIPAC_MR_NBR
        ,src.HFCA_NBR
        ,src.EMPLOYEE_NBR
        ,src.SECONDARY_MEMBER_IDENTIFIER_TEXT
        ,src.TERTIARY_MEMBER_IDENTIFIER_TEXT
        ,src.CURRENT_ELIG_STATUS_CODE01
        ,src.CURRENT_ELIG_STATUS_DESC01
        ,src.CURRENT_ELIG_STATUS_CODE02
        ,src.CURRENT_ELIG_STATUS_DESC02
        ,src.PART_D_RISK_FACTOR
        ,src.CHRONIC_CONDITION_CNT
        ,src.PREGNANCY_DUE_DATE
        ,src.ADDRESS_ARRAY
    )
;`;


//set the WHERE clause for the DELETE statement
var deleteWhereClause = '';
if (DATA_SOURCE_NAME)
{
    deleteWhereClause = `WHERE MEMBER_DETAIL_BASE.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND MEMBER_DETAIL_BASE_VW.DATA_SOURCE_NAME = '${DATA_SOURCE_NAME}'
        AND MEMBER_DETAIL_BASE_VW.HUB_MEMBER_HKEY IS NULL `;
}
else
{
    deleteWhereClause = `WHERE MEMBER_DETAIL_BASE_VW.HUB_MEMBER_HKEY IS NULL `;
}

// Create delete statement to be executed.
var sqlDeleteCommand =
`DELETE FROM EXTRACTDATA.MEMBER_DETAIL_BASE
    USING
        (
        SELECT
        MEMBER_DETAIL_BASE.HUB_MEMBER_HKEY
        FROM EXTRACTDATA.MEMBER_DETAIL_BASE
            LEFT OUTER JOIN HUBDATA.MEMBER_DETAIL_BASE_VW
                ON (MEMBER_DETAIL_BASE_VW.HUB_MEMBER_HKEY = MEMBER_DETAIL_BASE.HUB_MEMBER_HKEY)
        ${deleteWhereClause}
        ) deletes
    WHERE MEMBER_DETAIL_BASE.HUB_MEMBER_HKEY = deletes.HUB_MEMBER_HKEY
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