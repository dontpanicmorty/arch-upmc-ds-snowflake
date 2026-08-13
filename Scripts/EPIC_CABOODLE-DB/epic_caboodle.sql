-- This should be ran manually by whoever is initially creating the database structure.

USE ROLE DBA_PROD_ROLE; 

CREATE DATABASE IF NOT EXISTS EPIC_CABOODLE
COMMENT = 'production database'
;

USE ROLE DBA_DEV_ROLE; 

CREATE DATABASE IF NOT EXISTS EPIC_CABOODLE_TST
COMMENT = 'test database'
;

CREATE DATABASE IF NOT EXISTS EPIC_CABOODLE_DEV
COMMENT = 'dev database'
;
