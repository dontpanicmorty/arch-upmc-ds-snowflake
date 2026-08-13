CREATE OR REPLACE PROCEDURE EXTRACTDATA.SPU_LOAD_EXTRACTDATA(DATA_SOURCE_NAME VARCHAR, DATA_DOMAIN_NAME VARCHAR) 
RETURNS VARCHAR NOT NULL
LANGUAGE JAVASCRIPT
COMMENT = 'This a developer procedure to test load the hub for a given data source'
EXECUTE AS CALLER
AS
$$
var startTime = new Date().toISOString();

try
{
    if (!DATA_DOMAIN_NAME)
    {
        throw {code: "-1", message: "Data Domain is Required.", state: "", Trace: null};
    }


    //Check the data domain
    if (DATA_DOMAIN_NAME)
    {
        sqlCommand = `SELECT 1 FROM UTIL.EXTRACTDATA_LOAD_CONTROL WHERE DATA_DOMAIN_NAME = :1;`;
        sfStatement = snowflake.createStatement({sqlText: sqlCommand, binds: [DATA_DOMAIN_NAME]});
        resultSet = sfStatement.execute();
        if (!resultSet.next())
        {
            throw {code: "-2", message: "Data Domain: "+DATA_DOMAIN_NAME+"  ,Not Found In Control Table", state: "", Trace: null};
        }
    }

    //Get the current user
    sqlCommand=`SELECT SUBSTRING(CURRENT_USER(), 1, POSITION('@' IN CURRENT_USER())-1);`;
    sfStatement = snowflake.createStatement({sqlText: sqlCommand});
    resultSet = sfStatement.execute();

    resultSet.next();
    var jobId = resultSet.getColumnValue(1)+"_"+startTime;

    //Create Job Record
    sqlCommand = `CALL LOGDATA.SPU_SET_JOB_ID(:1,'HUBDATA.SPU_LOAD_HUBDATA');`;
    sfStatement = snowflake.createStatement({sqlText: sqlCommand, binds: [jobId]});     
    sfStatement.execute();

    //get list of procs to call
    sqlCommand = 
    `SELECT PROCEDURE_NAME
    FROM UTIL.EXTRACTDATA_LOAD_CONTROL
    WHERE IS_ACTIVE = TRUE
    AND DATA_DOMAIN_NAME = :1
    ORDER BY RUN_ORDER_NBR
    ;`;
    sfStatement = snowflake.createStatement({sqlText: sqlCommand, binds: [DATA_DOMAIN_NAME]});
    resultSet = sfStatement.execute();

    var dataSourceName = ``;
    if (DATA_SOURCE_NAME)
    {
        dataSourceName = `'${DATA_SOURCE_NAME}'`;
    }
    else
    {
        dataSourceName = `null`;
    };

    //loop over results and call procs
    while (resultSet.next())
        {
            sqlCommand = `CALL `+resultSet.PROCEDURE_NAME+`('${jobId}',${dataSourceName});`;
            sfStatement = snowflake.createStatement({sqlText: sqlCommand});
            sfStatement.execute();
        }

    //End Job Record
    sqlCommand = `CALL LOGDATA.SPU_SET_JOB_ID_ENDTIME('${jobId}');`;
    sfStatement = snowflake.createStatement({sqlText: sqlCommand});     
    sfStatement.execute();    

    return 'Done!'
}
catch (err)
{
    var result =  "Failed: Code: " + err.code + "\n  State: " + err.state;
    result += "\n  Message: " + err.message;
    result += "\nStack Trace:\n" + err.stackTraceTxt;
    throw result;
}
$$
;