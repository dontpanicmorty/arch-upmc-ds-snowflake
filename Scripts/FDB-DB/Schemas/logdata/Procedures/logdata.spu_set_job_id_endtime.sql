CREATE OR REPLACE PROCEDURE LOGDATA.SPU_SET_JOB_ID_ENDTIME(JOB_ID VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
COMMENT = 'Sets the END_TIME on a LOGDATA.JOB_LOG record.'
EXECUTE AS OWNER
AS
$$

var sqlCommand = `UPDATE LOGDATA.JOB_LOG SET END_TIME = CURRENT_TIMESTAMP() WHERE JOB_ID = :1;`;

var sfStatement = snowflake.createStatement(
    {
    sqlText: sqlCommand,
    binds: [JOB_ID]
    });

sfStatement.execute();

return "Succeeded";
$$
;