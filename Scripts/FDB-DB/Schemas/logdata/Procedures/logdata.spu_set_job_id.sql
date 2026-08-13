CREATE OR REPLACE PROCEDURE LOGDATA.SPU_SET_JOB_ID(JOB_ID VARCHAR, PROCEDURE_NAME VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
COMMENT = 'Inserted a record into LOGDATA.JOB_LOG, it is intended to be called from ADF'
EXECUTE AS OWNER
AS
$$

var sqlCommand = `INSERT INTO LOGDATA.JOB_LOG (JOB_ID, PROCEDURE_NAME) VALUES (:1, :2);`;

var sfStatement = snowflake.createStatement(
    {
    sqlText: sqlCommand,
    binds: [JOB_ID, PROCEDURE_NAME]
    });

sfStatement.execute();

return "Succeeded";
$$
;