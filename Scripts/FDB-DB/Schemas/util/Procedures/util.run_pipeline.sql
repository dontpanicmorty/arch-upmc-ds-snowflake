CREATE OR REPLACE PROCEDURE UTIL.RUN_PIPELINE(FDB_FOLDER_DATE DATE)
RETURNS STRING
LANGUAGE JAVASCRIPT
AS
$$

/* ------------------------------------------------------------
   1. CREATE JOB_ID INTERNALLY
------------------------------------------------------------ */

var runIdStmt = snowflake.createStatement({
    sqlText: "SELECT UUID_STRING()"
}).execute();

runIdStmt.next();
var jobId = runIdStmt.getColumnValue(1);


/* ------------------------------------------------------------
   2. HELPERS
------------------------------------------------------------ */

function logTableSuccess(binds){
    snowflake.createStatement({
        sqlText: `INSERT INTO LOGDATA.TABLE_LOAD_HISTORY
            (JOB_ID, NAME, TYPE, START_TIME, END_TIME, INSERT_COUNT, RESULT_TEXT, SQL_STATEMENT)
            VALUES (?, ?, ?, ?, ?, ?, 'Succeeded', ?)`,
        binds: binds
    }).execute();
}

function logTableError(binds){
    snowflake.createStatement({
        sqlText: `INSERT INTO LOGDATA.TABLE_LOAD_HISTORY 
            (JOB_ID, NAME, TYPE, START_TIME, END_TIME, RESULT_TEXT, SQL_STATEMENT, ERROR_CODE, ERROR_STATE, 
            ERROR_MESSAGE, ERROR_STACK_TRACE_TEXT)
            VALUES(?,?,?,?,?,'Failed',?,?,?,?,?)`,
        binds: binds
    }).execute();
}

/* ------------------------------------------------------------
   3. PIPELINE STATE
------------------------------------------------------------ */

var allSuccess = true;

/* ------------------------------------------------------------
   4. LOAD PHASE
------------------------------------------------------------ */

try {
    var startTime = null, endTime = null, errorTime = null;

    //Start job tracking
    snowflake.createStatement({
        sqlText: `CALL LOGDATA.SPU_SET_JOB_ID(?,?)`,
        binds : [jobId, Object.keys(this)[0]]
    }).execute();

    var cfg = snowflake.createStatement({
        sqlText: `
            SELECT *
            FROM UTIL.LOAD_CONFIG
            WHERE IS_ACTIVE = TRUE
        `
    }).execute();

    var configs = [];

    while (cfg.next()) {

        var configId   = cfg.getColumnValue("CONFIG_ID");
        var stageTable = cfg.getColumnValue("STAGE_TABLE_NAME");
        var prodTable  = cfg.getColumnValue("PROD_TABLE_NAME");

        var stageName = cfg.getColumnValue("SOURCE_FILE_STAGE_NAME");
        var path      = cfg.getColumnValue("SOURCE_FILE_PATH");
        var pattern   = cfg.getColumnValue("SOURCE_FILE_PATTERN");
        var columns   = cfg.getColumnValue("COLUMN_COUNT");

        var year  = FDB_FOLDER_DATE.getFullYear();
        var month = ('0' + (FDB_FOLDER_DATE.getMonth() + 1)).slice(-2);
        var day   = ('0' + FDB_FOLDER_DATE.getDate()).slice(-2);

        //Path stored on config table contains variables for year, month, and day. Replace with max date from ADLS for FDB files
        var stageLocation =
            stageName + "/" +
            path.replace(/\$y/g, year)
                .replace(/\$m/g, month)
                .replace(/\$d/g, day);

        var finalPattern =
            pattern.replace(/\$y/g, year)
                   .replace(/\$m/g, month)
                   .replace(/\$d/g, day);

        //Create stage tables from fdbdata tables
        try {
            startTime = new Date().toISOString();
            var replaceCommand = snowflake.createStatement({
                sqlText: `CREATE OR REPLACE TABLE ${stageTable} LIKE ${prodTable}`
            })
            replaceCommand.execute();
            endTime = new Date().toISOString();

            logTableSuccess([jobId, stageTable, 'REPLACE', startTime, endTime, 0, replaceCommand.getSqlText()]);


        } catch(err) {
            allSuccess = false;
            errorTime = new Date().toISOString();
            
            logTableError([jobId, stageTable, 'REPLACE', errorTime, errorTime, replaceCommand.getSqlText(),
                        err.code, err.state, err.message, err.stackTraceTxt]);
        }

        //Load stage tables from staged files
        try {
            startTime = new Date().toISOString();

            var selectList = [];
            for (var i = 1; i <= columns; i++) {
                selectList.push("$" + i);
            }

            var copySql = `
                COPY INTO ${stageTable}
                FROM (
                SELECT ${selectList.join(", ")}
                FROM ${stageLocation}
                (
                    FILE_FORMAT => 'STAGEDATA.FDB_FILE_FORMAT',
                    PATTERN => '${finalPattern}'
                    )
                )`;

            var copyCommand = snowflake.createStatement({
                sqlText: copySql
            });
            copyCommand.execute();
            endTime = new Date().toISOString();

            logTableSuccess([jobId, stageTable, 'COPY INTO', startTime, endTime, copyCommand.getNumRowsInserted(), copyCommand.getSqlText().trim()]);


        } catch(err) {
            allSuccess = false;
            errorTime = new Date().toISOString();
            
            logTableError([jobId, stageTable, 'COPY INTO', errorTime, errorTime, copyCommand.getSqlText(),
                        err.code, err.state, err.message, err.stackTraceTxt]);
        }

        //Validate primary key in stage tables
        try {
            startTime = new Date().toISOString();
            var validateCommand = snowflake.createStatement({
                sqlText: `CALL LOGDATA.SPU_VALIDATE_DATA_PRIMARY_KEY_CHECK('${jobId}','${stageTable}')`,
            });
            validateCommand.execute();
            endTime = new Date().toISOString();

            logTableSuccess([jobId, stageTable, 'VALIDATE', startTime, endTime, 0, validateCommand.getSqlText()]);

        } catch(err) {
            allSuccess = false;
            errorTime = new Date().toISOString();
            
            logTableError([jobId, stageTable, 'VALIDATE', errorTime, errorTime, validateCommand.getSqlText(),
                        err.code, err.state, err.message, err.stackTraceTxt]);
        }
            
        configs.push({
            stageTable: stageTable,
            prodTable: prodTable
        });
    }

    /* ------------------------------------------------------------
       5. SWAP PHASE
    ------------------------------------------------------------ */

    if (allSuccess) {

        for (var i = 0; i < configs.length; i++) {

            try {
                startTime = new Date().toISOString();
                var swapCommand = snowflake.createStatement({
                    sqlText: `ALTER TABLE ${configs[i].prodTable} SWAP WITH ${configs[i].stageTable}`
                });
                swapCommand.execute();
                endTime = new Date().toISOString();

                logTableSuccess([jobId, configs[i].prodTable, 'SWAP', startTime, endTime, 0, swapCommand.getSqlText()]);

            } catch(err) {
                allSuccess = false;
                errorTime = new Date().toISOString();
                
                logTableError([jobId, stageTable, 'SWAP', errorTime, errorTime, swapCommand.getSqlText(),
                            err.code, err.state, err.message, err.stackTraceTxt]);

                throw err;
            }
            
        }
    } 

    //Drop all staging tables
    for (var i = 0; i < configs.length; i++) {
        startTime = new Date().toISOString();
        var dropCommand = snowflake.createStatement({
            sqlText: `DROP TABLE ${configs[i].stageTable}`
        })
        dropCommand.execute();
        endTime = new Date().toISOString();

        logTableSuccess([jobId, configs[i].stageTable, 'DROP', startTime, endTime, 0, dropCommand.getSqlText()]);
    }

    //End job tracking
    snowflake.createStatement({
        sqlText: `CALL LOGDATA.SPU_SET_JOB_ID_ENDTIME(?)`,
        binds : [jobId]
    }).execute();
    
    return allSuccess ? "true" : "false";
    
} catch (e) {

    //End job tracking - error
    snowflake.createStatement({
        sqlText: `UPDATE LOGDATA.JOB_LOG 
            SET END_TIME = CURRENT_TIMESTAMP(),
                ERROR_MESSAGE = ?
            WHERE JOB_ID = ?;`,
        binds : [e.message, jobId]
    }).execute();

    return "false";   
}

$$;