CREATE OR REPLACE TEMPORARY TABLE
	ODSDATA.TMP_PHYSICIAN_HOSPITAL_ORGANIZATION (
		PHYSICIAN_HOSPITAL_ORGANIZATION_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
		PHYSICIAN_HOSPITAL_ORGANIZATION_NAME VARCHAR NOT NULL,
		LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP NOT NULL,
		CONSTRAINT PK_PHYSICIAN_HOSPITAL_ORGANIZATION PRIMARY KEY (PHYSICIAN_HOSPITAL_ORGANIZATION_KEY),
		CONSTRAINT UK_PHYSICIAN_HOSPITAL_ORGANIZATION UNIQUE (PHYSICIAN_HOSPITAL_ORGANIZATION_NAME)
	)COMMENT='Standardized list of PHOs. A PHO is a legal entity formed by hospitals and physicians that allow them to collaboarte'
;

INSERT INTO ODSDATA.TMP_PHYSICIAN_HOSPITAL_ORGANIZATION (PHYSICIAN_HOSPITAL_ORGANIZATION_KEY,PHYSICIAN_HOSPITAL_ORGANIZATION_NAME) VALUES
	 (1,'Adventist Health'),
	 (10,'Einstein'),
	 (11,'Faywest PHO'),
	 (12,'Health Plan Direct Credential'),
	 (13,'Health Plan PHO'),
	 (14,'Heritage Valley Health System'),
	 (15,'Hershey'),
	 (16,'Horizon PHO'),
	 (17,'Jeannette PHO'),
	 (18,'Luxottica'),
	 (19,'Magee Womens Hospital PHO'),
	 (2,'American Well'),
	 (20,'Magee Womens PHO'),
	 (21,'National Vision'),
	 (22,'Nemours'),
	 (23,'No Value Specified'),
	 (24,'Optum Medicare Screening and Labs'),
	 (25,'OSS Health'),
	 (26,'Physician Services Division'),
	 (27,'Physician Services Division PHO'),
	 (28,'Pinnacle Health System'),
	 (29,'Preferred Health Care'),
	 (3,'Berkshire Health Partners'),
	 (30,'Preferred Primary Care Practice IPA'),
	 (31,'Regional Healthcare Associates'),
	 (32,'Saint Vincent IPA'),
	 (33,'Saint Vincent Medical Group IPA'),
	 (34,'South Hills PHO'),
	 (35,'Summit Health'),
	 (36,'The Washington Hospital PHO'),
	 (37,'Thomas Jefferson University Hospitals'),
	 (38,'UPMC Beaver PHO'),
	 (39,'UPMC Bedford PHO'),
	 (4,'Blair County PHO'),
	 (40,'UPMC Braddock PHO'),
	 (41,'UPMC Horizon PHO'),
	 (42,'UPMC Lee PHO'),
	 (43,'UPMC McKeesport PHO'),
	 (44,'UPMC Passavant PHO'),
	 (45,'UPMC Shadyside PHO'),
	 (46,'UPMC South Side PHO'),
	 (47,'UPMC St Margaret PHO'),
	 (48,'UPPA IPA'),
	 (49,'Vale-U-Health'),
	 (5,'Bradford PHO'),
	 (50,'Vantage PHO'),
	 (51,'Washington PHO'),
	 (52,'Wellspan'),
	 (53,'West Virginia University PHO'),
	 (54,'Cleveland Clinic Foundation'),
	 (55,'Evangelical Medical Services Organization'),
	 (56,'Tower ASO'),
	 (57,'Univ of Colorado'),
	 (58,'Univ of Colorado Med CU Med'),
	 (59,'St Lukes'),
	 (6,'CCBH Provider'),
	 (60,'St Lukes Health System'),
	 (61,'UCHealth'),
	 (62,'PHC Cred/WellspanContract'),
	 (63,'PHC Cred/WellspanCon'),
	 (64,'Skygen'),
	 (65,'Univ of Colorado Med CUMed'),
	 (66,'LVPG'),
	 (67,'Guthrie'),
	 (68,'PHCS'),
	 (69,'Banner Health'),
	 (7,'Childrens PHO'),
	 (70,'WVUIS'),
	 (71,'Arizona State Physician Association'),
	 (72,'Geisinger'),
	 (73,'Cigna'),
	 (74,'MyEyeDr'),
	 (75,'Amplifon'),
	 (8,'Diversified Services, Inc.'),
	 (9,'Drexel Health');

--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO ODSDATA.PHYSICIAN_HOSPITAL_ORGANIZATION AS TGT
USING (SELECT PHYSICIAN_HOSPITAL_ORGANIZATION_KEY, PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	FROM ODSDATA.TMP_PHYSICIAN_HOSPITAL_ORGANIZATION
	MINUS 
	SELECT PHYSICIAN_HOSPITAL_ORGANIZATION_KEY, PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	FROM ODSDATA.PHYSICIAN_HOSPITAL_ORGANIZATION
	) AS SRC
ON TGT.PHYSICIAN_HOSPITAL_ORGANIZATION_KEY = SRC.PHYSICIAN_HOSPITAL_ORGANIZATION_KEY
WHEN MATCHED 
THEN UPDATE
	SET TGT.PHYSICIAN_HOSPITAL_ORGANIZATION_NAME = SRC.PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	,TGT.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
WHEN NOT MATCHED 
THEN INSERT
	(PHYSICIAN_HOSPITAL_ORGANIZATION_KEY
	,PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	)
VALUES
	(
	SRC.PHYSICIAN_HOSPITAL_ORGANIZATION_KEY
	,SRC.PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	);
	
--Flip the minus and delete from the target
DELETE FROM ODSDATA.PHYSICIAN_HOSPITAL_ORGANIZATION TGT
USING
(SELECT PHYSICIAN_HOSPITAL_ORGANIZATION_KEY, PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	FROM ODSDATA.PHYSICIAN_HOSPITAL_ORGANIZATION
	MINUS 
	SELECT PHYSICIAN_HOSPITAL_ORGANIZATION_KEY, PHYSICIAN_HOSPITAL_ORGANIZATION_NAME
	FROM ODSDATA.TMP_PHYSICIAN_HOSPITAL_ORGANIZATION
	) SRC
WHERE TGT.PHYSICIAN_HOSPITAL_ORGANIZATION_KEY = SRC.PHYSICIAN_HOSPITAL_ORGANIZATION_KEY;