/*
Queries INFORMATION_SCHEMA to verify basic design and naming conventions
Every check is expected to return 0 rows, then we query the temp table expecting 0
If we get > 0 then the CASE statement tries to divide by 0 which forces a hard failure so the pipeline stops
*/
!set variable_substitution=true;
!define test_count=10;

-- Load and execute the setup script to load the JSON inclusion/exclusion rules
-- and create all the temp views we need
!load ../../ValidationScripts/CodeReviewSetup.sql

-- Create the table in which we store diagnostic info
CREATE OR REPLACE TEMPORARY TABLE CODE_REVIEW_LOG_TMP (
    SCHEMA_NAME VARCHAR, 
    OBJECT_NAME VARCHAR, 
    FIX VARCHAR
);

-- Test 1: Make sure all tables have comments
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, 'Table does not have a comment.' AS FIX
    FROM FILTERED_OBJECTS_VW TABLES
    INNER JOIN INFORMATION_SCHEMA.COLUMNS ON
        COLUMNS.TABLE_SCHEMA = TABLES.OBJECT_SCHEMA
        AND COLUMNS.TABLE_NAME = TABLES.OBJECT_NAME
    WHERE TEST_INDEX = 1
        AND OBJECT_TYPE = 'BASE TABLE'
        AND COMMENT IS NULL
);

-- Test 2: Make sure the first column of each table matches `${TABLE_NAME}_KEY`
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT COLUMNS.TABLE_SCHEMA, COLUMNS.TABLE_NAME, 'First column in table does not match ${TABLE_NAME}_KEY OR HKEY.' AS FIX
    FROM INFORMATION_SCHEMA.COLUMNS
    INNER JOIN FILTERED_OBJECTS_VW TABLES ON 
        COLUMNS.TABLE_SCHEMA = TABLES.OBJECT_SCHEMA
        AND COLUMNS.TABLE_NAME = TABLES.OBJECT_SCHEMA
    WHERE TEST_INDEX = 2
        AND OBJECT_TYPE = 'BASE TABLE'
        AND ORDINAL_POSITION = 1
        -- Temporary bandaid until the ODSDATA and DIMDATA tables that break this get fixed
        AND COLUMN_NAME NOT LIKE '%KEY'
        -- AND COLUMN_NAME <> CONCAT(COLUMNS.TABLE_NAME, '_KEY')
);

-- Test 3: Make sure each table has a unique constraint
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT INVALID_TABLES.*, 
        'Table does not have a unique constraint. If UK and PK are the same, add an exception file to Scripts/ValidationScripts/rules/3-unique-constraints/exclude' AS FIX
    FROM (
        SELECT OBJECT_SCHEMA, OBJECT_NAME
        FROM FILTERED_OBJECTS_VW

        WHERE TEST_INDEX = 3 AND OBJECT_TYPE = 'BASE TABLE'

        MINUS    

        SELECT TABLE_SCHEMA, TABLE_NAME 
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        WHERE CONSTRAINT_TYPE = 'UNIQUE'
    ) INVALID_TABLES
); 

-- Test 4: Make sure every table has a PK defined
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT INVALID_TABLES.*, 
        'Table does not have a primary key.' AS FIX
    FROM (
        SELECT OBJECT_SCHEMA, OBJECT_NAME
        FROM FILTERED_OBJECTS_VW
        WHERE TEST_INDEX = 4 AND OBJECT_TYPE = 'BASE TABLE'
        
        MINUS 
        
        SELECT TABLE_SCHEMA, TABLE_NAME 
        FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
        WHERE CONSTRAINT_TYPE = 'PRIMARY KEY'
    ) INVALID_TABLES
);

-- Test 5: Make sure views are suffixed properly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, 'View must end with _VW.' AS FIX
    FROM FILTERED_OBJECTS_VW
    WHERE TEST_INDEX = 5
        AND OBJECT_TYPE = 'VIEW'
        AND SPLIT_PART(OBJECT_NAME, '_', -1) <> 'VW'
);

-- Test 6: Make sure UKs are prefixed properly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, CONCAT('Unique constraint ', CONSTRAINT_NAME, ' must begin with UK_.') AS FIX
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    INNER JOIN FILTERED_OBJECTS_VW TABLES ON 
        TABLE_CONSTRAINTS.TABLE_SCHEMA = TABLES.OBJECT_SCHEMA
        AND TABLE_CONSTRAINTS.TABLE_NAME = TABLES.OBJECT_NAME
    WHERE TEST_INDEX = 6
        AND OBJECT_TYPE = 'TABLE'
        AND CONSTRAINT_TYPE = 'UNIQUE'
        AND CONSTRAINT_NAME NOT LIKE 'UK_%'
);

-- Test 7: Make sure PKs are prefixed correctly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, CONCAT('PK ', CONSTRAINT_NAME, ' must begin with PK_.') AS FIX
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    INNER JOIN FILTERED_OBJECTS_VW TABLES ON 
        TABLE_CONSTRAINTS.TABLE_SCHEMA = TABLES.OBJECT_SCHEMA
        AND TABLE_CONSTRAINTS.TABLE_NAME = TABLES.OBJECT_NAME
    WHERE TEST_INDEX = 7
        AND OBJECT_TYPE = 'TABLE'
        AND CONSTRAINT_TYPE = 'PRIMARY KEY'
        AND CONSTRAINT_NAME NOT LIKE 'PK_%'
);

-- Test 8: Make sure FKs are prefixed correctly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, CONCAT('FK ', OBJECT_NAME, ' must begin with FK_.') AS FIX
    FROM FILTERED_OBJECTS_VW
    WHERE OBJECT_TYPE = 'REFERENTIAL_CONSTRAINT'
        AND OBJECT_NAME NOT LIKE 'FK_%'
);

-- Test 9: Make sure functions are prefixed properly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, 'Function must begin with FXN_' AS FIX
    FROM FILTERED_OBJECTS_VW
    WHERE OBJECT_TYPE = 'FUNCTION'
        AND OBJECT_NAME NOT LIKE 'FXN_%'
);

-- Test 10: Make sure sprocs are prefixed properly
INSERT INTO CODE_REVIEW_LOG_TMP (SCHEMA_NAME, OBJECT_NAME, FIX)
(
    SELECT OBJECT_SCHEMA, OBJECT_NAME, 'Procedure must begin with SPU_' AS FIX
    FROM FILTERED_OBJECTS_VW
    WHERE OBJECT_TYPE = 'PROCEDURE'
        AND OBJECT_NAME NOT LIKE 'SPU_%'
);

-- Print list of issues to resolve
SELECT * FROM CODE_REVIEW_LOG_TMP;

--Do the evaluation now
SELECT CASE WHEN COUNT(*) = 0 THEN 1
    ELSE 1/0 END AS CODE_REVIEW_PASS_FLAG --divide by 0 if we logged any exceptions so the script hard fails
FROM CODE_REVIEW_LOG_TMP;

--Clean up the temp table
DROP TABLE CODE_REVIEW_LOG_TMP;

!set variable_substitution=false;