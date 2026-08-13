-- This should be ran manually by whoever is initially creating the database structure.

USE ROLE DBA_PROD_ROLE; 

CREATE DATABASE IF NOT EXISTS EPIC_CLARITY
COMMENT = 'production database'
;

USE ROLE DBA_DEV_ROLE; 

CREATE DATABASE IF NOT EXISTS EPIC_CLARITY_TST
COMMENT = 'test database'
;

CREATE DATABASE IF NOT EXISTS EPIC_CLARITY_DEV
COMMENT = 'dev database'
;
