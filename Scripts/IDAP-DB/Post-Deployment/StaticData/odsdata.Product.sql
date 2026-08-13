CREATE OR REPLACE TEMPORARY TABLE
	ODSDATA.TMP_PRODUCT (
		PRODUCT_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
		PRODUCT_NAME VARCHAR NOT NULL,
		LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP NOT NULL,
		TPA_HIERARCHY_KEY NUMBER(38,0) NOT NULL,
		CONSTRAINT FK_PRODUCT_TPA_HIERARCHY FOREIGN KEY (TPA_HIERARCHY_KEY) REFERENCES ODSDATA.TPA_HIERARCHY (TPA_HIERARCHY_KEY),
		CONSTRAINT PK_PRODUCT PRIMARY KEY (PRODUCT_KEY),
		CONSTRAINT UK_PRODUCT UNIQUE (TPA_HIERARCHY_KEY, PRODUCT_NAME)
	)COMMENT='Specific Product Details'
;

INSERT INTO ODSDATA.TMP_PRODUCT (PRODUCT_KEY,PRODUCT_NAME,TPA_HIERARCHY_KEY) VALUES
	 (1,'AdultBasic HMO',1),
	 (31,'Blair Medical Associates',1),
	 (32,'Butler',1),
	 (33,'Butler Advantage Plus',1),
	 (2,'Childrens Health Insurance Program',1),
	 (102,'Cigna PPO',1),
	 (57,'Commercial (Behavioral Health Services)',1),
	 (3,'Community HealthChoices',1),
	 (100,'Community HealthChoices HCBS',1),
	 (72,'County of Beaver',1),
	 (34,'Erie Inside Advantage',1),
	 (81,'ESI Medicaid',1),
	 (80,'ESI Medicare',1),
	 (35,'Excela',1),
	 (99,'Federal Employee Health Benefit',1),
	 (73,'General Electric EPO',1),
	 (4,'HB CM (EAPOS)',1),
	 (97,'HCMS Employees',1),
	 (5,'Healthy PA',1),
	 (71,'Heritage Valley Health System',1),
	 (6,'HMO-R',1),
	 (7,'HMO/Point of Service',1),
	 (8,'HP PP (ASO)',1),
	 (9,'Inside Advantage for Individuals',1),
	 (36,'Jameson',1),
	 (10,'MA Product',1),
	 (58,'Medicare (UPMC for Life)',1),
	 (11,'Medicare HMO Product',1),
	 (12,'Medicare Individual Product',1),
	 (98,'Medicare Pitt Retirees',1),
	 (13,'Medicare PPO Product',1),
	 (14,'Medicare PSP 1',1),
	 (15,'Medicare PSP 2/Tower',1),
	 (67,'Medicare PSP 3/Excela',1),
	 (16,'Medicare Select Product',1),
	 (17,'Medicare SNP Institutional',1),
	 (18,'Medicare SNP SMI',1),
	 (19,'Medicare Specialty Plan',1),
	 (20,'MyCare Advantage HMO',1),
	 (21,'MyCare Advantage PPO/EPO',1),
	 (79,'National Network',1),
	 (22,'Partner Network',1),
	 (69,'Pitt Employees Advantage Network',1),
	 (23,'PPO Product',1),
	 (94,'Preferred Value Network',1),
	 (66,'Premier (Medicare PSP)',1),
	 (24,'Select',1),
	 (37,'St Clair',1),
	 (75,'St Clair Advantage',1),
	 (38,'St Clair and Washington',1),
	 (86,'Total Advantage',1),
	 (77,'Tower Employees Network',1),
	 (25,'Tower Health Commercial',1),
	 (39,'Uniontown Hospital',1),
	 (27,'Unknown',1),
	 (46,'UPMC Advantage',1),
	 (92,'UPMC CHC',1),
	 (82,'UPMC Community HealthChoices',1),
	 (101,'UPMC Dental Advantage Discount',1),
	 (95,'UPMC Employees Advantage CCBH',1),
	 (68,'UPMC Employees Advantage Network',1),
	 (104,'UPMC Essential Pharmacy Network',1),
	 (93,'UPMC FEHB',1),
	 (62,'UPMC for Best Health',1),
	 (26,'UPMC for Community Living SNP60+',1),
	 (88,'UPMC For Kids',1),
	 (83,'UPMC for Kids (CHIP)',1),
	 (91,'UPMC For Life',1),
	 (85,'UPMC for Life (Medicare)',1),
	 (90,'UPMC For Life Options',1),
	 (59,'UPMC for Life Specialty Plan',1),
	 (89,'UPMC For You',1),
	 (84,'UPMC for You (Medicaid)',1),
	 (61,'UPMC for You SNP Options',1),
	 (60,'UPMC for You SNP SMI',1),
	 (40,'UPMC Grove City Enhanced',1),
	 (45,'UPMC Inside Advantage',1),
	 (70,'UPMC Inside Advantage Network',1),
	 (87,'UPMC Life Dual',1),
	 (63,'UPMC Partner Network',1),
	 (65,'UPMC Select Network',1),
	 (76,'UPMC Somerset Custom Home Host',1),
	 (64,'UPMC Standard Network',1),
	 (41,'UPMC Uniontown Enhanced',1),
	 (28,'UPMC Vision Care',1),
	 (78,'UPMC Vision Care Commercial Discount Network',1),
	 (29,'UPMC Vision Care Medicare',1),
	 (30,'UPMC Vision Care Non-U135',1),
	 (96,'UPMC Western Maryland Employees',1),
	 (42,'Warren General Hospital',1),
	 (74,'Washington Hospital Home Host',1),
	 (43,'Westmoreland County',1),
	 (44,'Windber',1);


--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO ODSDATA.PRODUCT AS TGT
USING (SELECT PRODUCT_KEY, PRODUCT_NAME, TPA_HIERARCHY_KEY
	FROM ODSDATA.TMP_PRODUCT
	MINUS 
	SELECT PRODUCT_KEY, PRODUCT_NAME, TPA_HIERARCHY_KEY
	FROM ODSDATA.PRODUCT
	) AS SRC
ON TGT.PRODUCT_KEY = SRC.PRODUCT_KEY
WHEN MATCHED 
THEN UPDATE
	SET TGT.PRODUCT_NAME = SRC.PRODUCT_NAME
	,TGT.TPA_HIERARCHY_KEY = SRC.TPA_HIERARCHY_KEY
	,TGT.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
WHEN NOT MATCHED 
THEN INSERT
	(PRODUCT_KEY
	,PRODUCT_NAME
	,TPA_HIERARCHY_KEY
	)
VALUES
	(
	SRC.PRODUCT_KEY
	,SRC.PRODUCT_NAME
	,SRC.TPA_HIERARCHY_KEY
	);
	
--Flip the minus and delete from the target
DELETE FROM ODSDATA.PRODUCT TGT
USING
(SELECT PRODUCT_KEY, PRODUCT_NAME, TPA_HIERARCHY_KEY
	FROM ODSDATA.PRODUCT
	MINUS 
	SELECT PRODUCT_KEY, PRODUCT_NAME, TPA_HIERARCHY_KEY
	FROM ODSDATA.TMP_PRODUCT
	) SRC
WHERE TGT.PRODUCT_KEY = SRC.PRODUCT_KEY;