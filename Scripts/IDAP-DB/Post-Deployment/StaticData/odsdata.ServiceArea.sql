CREATE OR REPLACE TEMPORARY TABLE
	ODSDATA.TMP_SERVICE_AREA (
		SERVICE_AREA_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
		STATE_KEY NUMBER(38,0),
		SERVICE_AREA_TEXT VARCHAR NOT NULL,
		COUNTY_NAME VARCHAR,
		LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP NOT NULL,
		CONSTRAINT PK_SERVICE_AREA PRIMARY KEY (SERVICE_AREA_KEY),
		CONSTRAINT UK_SERVICE_AREA UNIQUE (SERVICE_AREA_TEXT)
	)COMMENT='List of standardized servie areas'
	;
	
INSERT INTO ODSDATA.TMP_SERVICE_AREA
(SERVICE_AREA_KEY, STATE_KEY, SERVICE_AREA_TEXT, COUNTY_NAME)
VALUES
(1, 38, 'Adams, PA', 'Adams'),
(2, 38, 'Allegheny, PA', 'Allegheny'),
(3, 38, 'Armstrong, PA', 'Armstrong'),
(4, 38, 'Beaver, PA', 'Beaver'),
(5, 38, 'Bedford, PA', 'Bedford'),
(6, 38, 'Berks, PA', 'Berks'),
(7, 38, 'Blair, PA', 'Blair'),
(8, 38, 'Bradford, PA', 'Bradford'),
(9, 38, 'Bucks, PA', 'Bucks'),
(10, 38, 'Butler, PA', 'Butler'),
(11, 38, 'Cambria, PA', 'Cambria'),
(12, 38, 'Cameron, PA', 'Cameron'),
(13, 38, 'Carbon, PA', 'Carbon'),
(14, 38, 'Centre, PA', 'Centre'),
(15, 38, 'Chester, PA', 'Chester'),
(16, 38, 'Clarion, PA', 'Clarion'),
(17, 38, 'Clearfield, PA', 'Clearfield'),
(18, 38, 'Clinton, PA', 'Clinton'),
(19, 38, 'Columbia, PA', 'Columbia'),
(20, 38, 'Crawford, PA', 'Crawford'),
(21, 38, 'Cumberland, PA', 'Cumberland'),
(22, 38, 'Dauphin, PA', 'Dauphin'),
(23, 38, 'Delaware, PA', 'Delaware'),
(24, 38, 'Elk, PA', 'Elk'),
(25, 38, 'Erie, PA', 'Erie'),
(26, 38, 'Fayette, PA', 'Fayette'),
(27, 38, 'Forest, PA', 'Forest'),
(28, 38, 'Franklin, PA', 'Franklin'),
(29, 38, 'Fulton, PA', 'Fulton'),
(30, 38, 'Greene, PA', 'Greene'),
(31, 38, 'Huntingdon, PA', 'Huntingdon'),
(32, 38, 'Indiana, PA', 'Indiana'),
(33, 38, 'Jefferson, PA', 'Jefferson'),
(34, 38, 'Juniata, PA', 'Juniata'),
(35, 38, 'Lackawanna, PA', 'Lackawanna'),
(36, 38, 'Lancaster, PA', 'Lancaster'),
(37, 38, 'Lawrence, PA', 'Lawrence'),
(38, 38, 'Lebanon, PA', 'Lebanon'),
(39, 38, 'Lehigh, PA', 'Lehigh'),
(40, 38, 'Luzerne, PA', 'Luzerne'),
(41, 38, 'Lycoming, PA', 'Lycoming'),
(42, 38, 'McKean, PA', 'McKean'),
(43, 38, 'Mercer, PA', 'Mercer'),
(44, 38, 'Mifflin, PA', 'Mifflin'),
(45, 38, 'Monroe, PA', 'Monroe'),
(46, 38, 'Montgomery, PA', 'Montgomery'),
(47, 38, 'Montour, PA', 'Montour'),
(48, 38, 'Northampton, PA', 'Northampton'),
(49, 38, 'Northumberland, PA', 'Northumberland'),
(50, 38, 'Perry, PA', 'Perry'),
(51, 38, 'Philadelphia, PA', 'Philadelphia'),
(52, 38, 'Pike, PA', 'Pike'),
(53, 38, 'Potter, PA', 'Potter'),
(54, 38, 'Schuylkill, PA', 'Schuylkill'),
(55, 38, 'Snyder, PA', 'Snyder'),
(56, 38, 'Somerset, PA', 'Somerset'),
(57, 38, 'Sullivan, PA', 'Sullivan'),
(58, 38, 'Susquehanna, PA', 'Susquehanna'),
(59, 38, 'Tioga, PA', 'Tioga'),
(60, 38, 'Union, PA', 'Union'),
(61, 38, 'Venango, PA', 'Venango'),
(62, 38, 'Warren, PA', 'Warren'),
(63, 38, 'Washington, PA', 'Washington'),
(64, 38, 'Wayne, PA', 'Wayne'),
(65, 38, 'Westmoreland, PA', 'Westmoreland'),
(66, 38, 'Wyoming, PA', 'Wyoming'),
(67, 38, 'York, PA', 'York');

--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO ODSDATA.SERVICE_AREA AS TGT
USING (SELECT SERVICE_AREA_KEY, STATE_KEY, SERVICE_AREA_TEXT, COUNTY_NAME
	FROM ODSDATA.TMP_SERVICE_AREA
	MINUS 
	SELECT SERVICE_AREA_KEY, STATE_KEY, SERVICE_AREA_TEXT, COUNTY_NAME
	FROM ODSDATA.SERVICE_AREA
	) AS SRC
ON TGT.SERVICE_AREA_KEY = SRC.SERVICE_AREA_KEY
WHEN MATCHED 
THEN UPDATE
	SET TGT.STATE_KEY = SRC.STATE_KEY
	,TGT.SERVICE_AREA_TEXT = SRC.SERVICE_AREA_TEXT
	,TGT.COUNTY_NAME = SRC.COUNTY_NAME
	,TGT.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
WHEN NOT MATCHED 
THEN INSERT
	(SERVICE_AREA_KEY
	,STATE_KEY
	,SERVICE_AREA_TEXT
	,COUNTY_NAME	
	)
VALUES
	(
	SRC.SERVICE_AREA_KEY
	,SRC.STATE_KEY
	,SRC.SERVICE_AREA_TEXT
	,SRC.COUNTY_NAME
	);
	
--Flip the minus and delete from the target
DELETE FROM ODSDATA.SERVICE_AREA TGT
USING
(SELECT SERVICE_AREA_KEY, STATE_KEY, SERVICE_AREA_TEXT, COUNTY_NAME
	FROM ODSDATA.SERVICE_AREA
	MINUS 
	SELECT SERVICE_AREA_KEY, STATE_KEY, SERVICE_AREA_TEXT, COUNTY_NAME
	FROM ODSDATA.TMP_SERVICE_AREA
	) SRC
WHERE TGT.SERVICE_AREA_KEY = SRC.SERVICE_AREA_KEY;