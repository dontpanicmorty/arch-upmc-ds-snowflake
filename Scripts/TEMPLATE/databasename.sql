-- This should be ran manually by whoever is initially creating the database structure.

USE ROLE DBA_PROD_ROLE; 

CREATE DATABASE IF NOT EXISTS <DatabaseName>
COMMENT = 'production database'
;

USE ROLE DBA_DEV_ROLE; 

CREATE DATABASE IF NOT EXISTS <DatabaseName>_TST
COMMENT = 'test database'
;

CREATE DATABASE IF NOT EXISTS <DatabaseName>_DEV
COMMENT = 'dev database'
;
