create or replace view LOGDATA.STORAGE_MOVER_SUMMARY_VW(
 TIMESTAMP,
 SOURCE_DIRECTORY,
 FILE_NAME,
 READ_SUCCESS,
 WRITE_SUCCESS,
 SIZE_MB,
 MESSAGE
) as
WITH parsed AS (
SELECT
    EVENT_TS::TIMESTAMP_NTZ AS EVENT_TS,
    OPERATION_NAME,
    OPERATION_ITEM,
    MESSAGE,
    METADATA_FILENAME,
 
    TRY_PARSE_JSON(REGEXP_SUBSTR(MESSAGE, '\\{.*\\}')) AS MESSAGE_JSON,
    MESSAGE_JSON:"Size"::NUMBER AS FILE_SIZE,
 
    /* dept_arch */
    REGEXP_SUBSTR(
        METADATA_FILENAME,
        'file_mover/([^/]+)/',
        1, 1, 'e', 1
    ) AS SOURCE_DIRECTORY,
 
    /* optional foreach item folder */
    REGEXP_SUBSTR(
        METADATA_FILENAME,
        '/\\d{4}/\\d{2}/\\d{2}/([^/]+)/copyactivity-logs/',
        1, 1, 'e', 1
    ) AS ITEM_FOLDER,
 
    /* authoritative file name */
    COALESCE(
        IFF(
            ITEM_FOLDER IS NOT NULL AND MESSAGE_JSON:"Path" IS NOT NULL,
            ITEM_FOLDER || '/' || MESSAGE_JSON:"Path"::STRING,
            MESSAGE_JSON:"Path"::STRING
        ),
        IFF(
            ITEM_FOLDER IS NOT NULL,
            ITEM_FOLDER || '/' || OPERATION_ITEM,
            OPERATION_ITEM
        )
    ) AS FILE_NAME
    FROM LOGDATA.STORAGE_MOVER_RAW_LOGS
),
 
normalized AS (
    SELECT
        EVENT_TS,
        SOURCE_DIRECTORY,
        OPERATION_NAME,
        FILE_NAME,
        FILE_SIZE,
        METADATA_FILENAME,
        MESSAGE
    FROM parsed
)
SELECT
    MAX(EVENT_TS) AS TIMESTAMP,
    SOURCE_DIRECTORY,
    FILE_NAME,
 
    -- Read success flag
    MAX(
        CASE 
            WHEN OPERATION_NAME = 'FileRead' 
             AND MESSAGE ILIKE '%Complete reading file successfully%' 
            THEN 1 ELSE 0 
        END
    ) = 1 AS READ_SUCCESS,
 
    -- Write success flag
    MAX(
        CASE 
            WHEN OPERATION_NAME = 'FileWrite' 
             AND MESSAGE ILIKE '%File is successfully copied%' 
            THEN 1 ELSE 0 
        END
    ) = 1 AS WRITE_SUCCESS,
 
    -- Size in MB
    ROUND(MAX(FILE_SIZE) / 1048576, 2) AS SIZE_MB,
 
    -- Message logic: log failure if present, otherwise write success message
    COALESCE(
        MAX(
            CASE 
                WHEN MESSAGE ILIKE '%fail%' 
                  OR MESSAGE ILIKE '%error%' 
                  OR MESSAGE ILIKE '%exception%' 
                THEN MESSAGE 
            END
        ),
        MAX(
            CASE
                WHEN OPERATION_NAME = 'FileWrite' 
                 AND MESSAGE ILIKE '%File is successfully copied%' 
                THEN MESSAGE
            END
        )
    ) AS MESSAGE
 
FROM normalized
GROUP BY METADATA_FILENAME, SOURCE_DIRECTORY, FILE_NAME
ORDER BY TIMESTAMP;
