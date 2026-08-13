CREATE OR REPLACE TABLE
	EXTRACTDATA.REPORTING_ENTITY (
		REPORTING_ENTITY_KEY NUMBER(38,0) AUTOINCREMENT ORDER START 1 INCREMENT 1 NOT NULL UNIQUE,
		INSERT_DATETIME TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP NOT NULL,
		REPORTING_ENTITY_NAME VARCHAR NOT NULL,
		REPORTING_ENTITY_TYPE VARCHAR NOT NULL,
		BASE_URL VARCHAR NOT NULL COMMENT 'Folder under which we expect to find TOC or the plan files. Entered manually by someone who wants to see data. All files under this folder will result in entries in the PLAN_FILE table',
		URL_DOMAIN_NAME VARCHAR NOT NULL COMMENT 'URL domain name, no sub-domain',
		UPMC_REPORTING_ENTITY_NAME VARCHAR COMMENT 'The reporting entity name as known by UPMC which may or may not be the same as how the given entity defines their name in the json files.',
		CONSTRAINT PK_REPORTING_ENTITY PRIMARY KEY (REPORTING_ENTITY_KEY),
		CONSTRAINT UK_REPORTING_ENTITY UNIQUE (REPORTING_ENTITY_NAME, REPORTING_ENTITY_TYPE, BASE_URL, URL_DOMAIN_NAME)
	)
	 COMMENT='Holds the top level entity posting their prices publicly. Manually maintained as we add more competitors to the list of those we want to analyze.';
