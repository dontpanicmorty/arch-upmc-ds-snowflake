CREATE OR REPLACE PROCEDURE UTIL.GET_LATEST_FOLDER(STAGE_NAME STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
try {

    // List files in the stage
    var listStmt = snowflake.createStatement({
        sqlText: `LIST @${STAGE_NAME}`
    });
 
    listStmt.execute();
 
    var queryId = listStmt.getQueryId();
 
    // Find latest YYYY/MM/DD folder
    var sql = `
        WITH files AS (
            SELECT DISTINCT
                REGEXP_SUBSTR(
                    "name",
                    '[0-9]{4}/[0-9]{2}/[0-9]{2}'
                ) AS folder_path
            FROM TABLE(RESULT_SCAN('${queryId}'))
        )
        SELECT
            folder_path,
            TO_CHAR(
                TO_DATE(folder_path, 'YYYY/MM/DD'),
                'YYYY-MM-DD'
            ) AS folder_date,
            TO_DATE(folder_path, 'YYYY/MM/DD')
                < DATEADD(MONTH, -1, CURRENT_DATE()) AS is_old
        FROM files
        WHERE folder_path IS NOT NULL
        QUALIFY ROW_NUMBER() OVER (
            ORDER BY TO_DATE(folder_path, 'YYYY/MM/DD') DESC
        ) = 1
    `;
 
    var rs = snowflake.createStatement({
        sqlText: sql
    }).execute();
 
    if (!rs.next()) {
        throw new Error(
            'No folders matching YYYY/MM/DD found in stage ' + STAGE_NAME
        );
    }
 
    var latestFolder = rs.getColumnValue(1);
    var latestDate   = rs.getColumnValue(2); // YYYY-MM-DD
    var isOld        = rs.getColumnValue(3);
 
    if (isOld) {
        throw new Error(
            'Latest folder "' + latestFolder +
            '" is older than one month. Folder date: ' +
            latestDate
        );
    }

    return latestDate;
 
} catch (err) {
    throw new Error(err.message);
}
$$;