CREATE OR REPLACE TEMPORARY TABLE
	ODSDATA.TMP_EMR_SYSTEM_DATA_SOURCE_REL (
		EMR_SYSTEM_DATA_SOURCE_REL_KEY NUMBER(38,0) AUTOINCREMENT START 1 INCREMENT 1 NOT NULL,
		DATA_SOURCE_KEY NUMBER(38,0) NOT NULL,
		EMR_SYSTEM_KEY NUMBER(38,0) NOT NULL,
		EMR_SYSTEM_SOURCE_NAME VARCHAR NOT NULL,
		LAST_UPDATED_DATETIME TIMESTAMP_TZ(9) DEFAULT CURRENT_TIMESTAMP NOT NULL,
		CONSTRAINT FK_EMR_SYSTEM_DATA_SOURCE_REL_DATA_SOURCE FOREIGN KEY (DATA_SOURCE_KEY) REFERENCES ODSDATA.DATA_SOURCE (DATA_SOURCE_KEY),
		CONSTRAINT FK_EMR_SYSTEM_DATA_SOURCE_REL_EMR_SYSTEM FOREIGN KEY (EMR_SYSTEM_KEY) REFERENCES ODSDATA.EMR_SYSTEM (EMR_SYSTEM_KEY),
		CONSTRAINT PK_EMR_SYSTEM_DATA_SOURCE_REL PRIMARY KEY (EMR_SYSTEM_DATA_SOURCE_REL_KEY),
		CONSTRAINT UK_EMR_SYSTEM_DATA_SOURCE_REL UNIQUE (DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME)
	)COMMENT='Relates source EMR System values to standard values in EMRSytem'
;

INSERT INTO ODSDATA.TMP_EMR_SYSTEM_DATA_SOURCE_REL
(DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME)
VALUES
(1, 1, 'Adaptamed'),
(1, 2, 'ADS'),
(1, 3, 'Advanced MD'),
(1, 4, 'Allscripts MyWay, Pro, or EP'),
(1, 5, 'Alteer'),
(1, 6, 'Amazing Charts'),
(1, 7, 'Aprima'),
(1, 8, 'athena health'),
(1, 9, 'Care 360'),
(1, 10, 'Centricity'),
(1, 11, 'Cerner Millenium Plus'),
(1, 12, 'ChartLogic'),
(1, 13, 'Compulink'),
(1, 14, 'Computer Program & System Inc.'),
(1, 15, 'DB Consultants'),
(1, 16, 'Digichart'),
(1, 17, 'Dr. First'),
(1, 18, 'E Natal'),
(1, 19, 'e-MD''s'),
(1, 20, 'Eclinical Works'),
(1, 21, 'EHRYourWay'),
(1, 22, 'EHS'),
(1, 23, 'Emdeon Clinician'),
(1, 24, 'Encite'),
(1, 25, 'Encounter Pro'),
(1, 26, 'Enterprise EHR'),
(1, 27, 'Epic'),
(1, 28, 'Epicare'),
(1, 29, 'Evident'),
(1, 30, 'Eyecare Advantage'),
(1, 31, 'Greenway PrimseSUITE'),
(1, 32, 'Health Fusion MediTouch'),
(1, 33, 'Healthland'),
(1, 34, 'HealthPort'),
(1, 35, 'HPF Folder'),
(1, 36, 'IC Charts'),
(1, 37, 'IDX'),
(1, 38, 'Integreat'),
(1, 39, 'LSS Magic or Client/Server'),
(1, 40, 'Lytec'),
(1, 41, 'MacPractice'),
(1, 42, 'MD Office'),
(1, 43, 'MDIntelleSys'),
(1, 44, 'Med Tech'),
(1, 45, 'Medent'),
(1, 46, 'MedicsElite'),
(1, 47, 'Medinformatix'),
(1, 48, 'MediSoft'),
(1, 49, 'Meditech'),
(1, 50, 'MicroMD'),
(1, 51, 'Misys'),
(1, 52, 'NaviNet'),
(1, 53, 'Next Gen'),
(1, 54, 'NexTech'),
(1, 56, 'None (does not use EMR)'),
(1, 57, 'Office Ally'),
(1, 58, 'Office Mate'),
(1, 59, 'Office Practicum'),
(1, 60, 'Open EMR'),
(1, 61, 'PCC'),
(1, 62, 'PowerChart'),
(1, 63, 'PowerWorks'),
(1, 64, 'Practice Fusion'),
(1, 65, 'Practice Partner'),
(1, 66, 'Praxis'),
(1, 67, 'Prognosis'),
(1, 68, 'Promed'),
(1, 69, 'QD Clinical'),
(1, 70, 'Quest'),
(1, 71, 'RXNT'),
(1, 72, 'Sage/Vitera Intergy'),
(1, 73, 'SequelMed'),
(1, 74, 'SimplifyMD'),
(1, 75, 'SmartClinic'),
(1, 76, 'Soapware'),
(1, 77, 'Soarian (Siemens)'),
(1, 78, 'SpringCharts'),
(1, 79, 'SRSSOFT'),
(1, 80, 'StreamlineMD'),
(1, 81, 'SuiteMed'),
(1, 82, 'TouchChart'),
(1, 83, 'TRAKnet'),
(1, 84, 'Unknown Brand'),
(1, 85, 'XQuest 360'),
(1, 86, 'American Medical Software'),
(1, 87, 'Kareo'),
(1, 88, 'MyVision Express'),
(1, 89, 'RevolutionEHR'),
(1, 90, 'Stratus'),
(1, 91, 'Versaform'),
(1, 92, 'Canvas'),
(1, 93, 'Point & Click Solutions'),
(1, 94, 'Remedy'),
(1, 95, 'Expanse'),
(1, 96, 'Doc-tor'),
(1, 97, 'DrChrono'),
(1, 98, 'Sti Computer'),
(1, 99, 'WRS'),
(1, 100, 'Quanan Care 360'),
(1, 101, 'Compu Group Medical'),
(1, 102, 'Focus MD'),
(1, 103, 'Escript'),
(1, 104, 'Eurocharts'),
(1, 105, 'Caretracker'),
(1, 106, 'Curemd'),
(1, 107, 'Docutap'),
(1, 108, 'Engenics'),
(1, 109, 'MedicsCloud'),
(1, 110, 'Medstream'),
(1, 111, 'ATLAS MD'),
(1, 112, 'Greenway Intergy'),
(1, 113, 'Fuji'),
(1, 114, 'Harris CareTracker'),
(1, 115, 'Modernizing Medicine'),
(1, 116, 'Practice Management'),
(1, 117, 'Urochart'),
(1, 118, 'Office medicine'),
(1, 119, 'Integrity'),
(1, 120, 'Med Star'),
(1, 121, 'ACW'),
(1, 122, 'Azalea Health'),
(1, 123, 'Geri Med'),
(1, 124, 'SHCIS'),
(1, 125, 'Healthie'),
(1, 126, 'Veracity Alligiance'),
(1, 127, 'Blue EHR'),
(1, 128, 'Varian'),
(1, 129, 'Intellechart Pro'),
(1, 130, 'Emedsys/Trimed'),
(1, 131, 'Henry Schein'),
(1, 132, 'Sammy EHR'),
(1, 133, 'Sevocity'),
(1, 134, 'Chartmaker Clinical'),
(1, 135, 'Practice EHR'),
(1, 136, 'Insync'),
(1, 137, 'Care Stream'),
(1, 138, 'IknowMed'),
(1, 139, 'Arete'),
(1, 140, 'Medflow'),
(1, 141, 'Advanced Data Systems'),
(1, 142, 'Carestream Winoms'),
(1, 143, 'Soft Aid'),
(1, 144, 'Cerner Powerchart Ambulatory'),
(1, 145, 'Dentrix'),
(1, 146, 'IFA'),
(1, 147, 'MediTab'),
(1, 148, 'NextGen/Health Fusion'),
(1, 149, 'Health Fusion'),
(1, 150, 'Quest Quantum'),
(1, 151, 'CSN'),
(1, 152, 'OPIE'),
(1, 153, 'Connexin'),
(1, 154, 'Enabledoc'),
(1, 155, 'OneTouch'),
(1, 156, 'Gehrimed'),
(1, 157, 'Claim MD'),
(1, 158, 'Onco'),
(1, 159, 'Crystal Vision'),
(1, 160, 'DSN'),
(1, 161, 'ODLink'),
(1, 162, 'Emed'),
(1, 163, 'Practice Studio'),
(1, 164, 'BlueStep'),
(1, 165, 'Physicians Express'),
(1, 166, 'Medicat'),
(1, 167, 'ExamWriter'),
(1, 168, 'PointClickCare'),
(1, 169, 'MDI'),
(1, 170, 'OMS Vision'),
(1, 171, 'Picasso'),
(1, 172, 'Treznet'),
(1, 173, 'EMA'),
(1, 174, 'Intergy'),
(1, 175, 'Officemd'),
(1, 176, 'STIP'),
(1, 177, 'Symplast'),
(1, 178, 'Exscribe'),
(1, 179, 'IMS'),
(1, 180, 'Imedicware'),
(1, 181, 'Medevolve'),
(1, 182, 'Dosespot'),
(1, 183, 'WinDms'),
(1, 184, 'Quanum'),
(1, 185, 'Prime Suite'),
(1, 186, 'Qaulifacts Carelogic'),
(1, 187, 'Athena Practice'),
(1, 188, 'Winoms'),
(1, 189, 'Eyefinity'),
(1, 190, 'FoxFire'),
(1, 191, 'Experity'),
(1, 192, 'Aria'),
(1, 193, 'ECU');

--Use a minus query to find any diffs and update or insert as needed	 
MERGE INTO ODSDATA.EMR_SYSTEM_DATA_SOURCE_REL AS TGT
USING (SELECT DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME
	FROM ODSDATA.TMP_EMR_SYSTEM_DATA_SOURCE_REL
	MINUS 
	SELECT DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME
	FROM ODSDATA.EMR_SYSTEM_DATA_SOURCE_REL
	) AS SRC
ON TGT.DATA_SOURCE_KEY = SRC.DATA_SOURCE_KEY
AND TGT.EMR_SYSTEM_KEY = SRC.EMR_SYSTEM_KEY
WHEN MATCHED 
THEN UPDATE
	SET TGT.EMR_SYSTEM_SOURCE_NAME = SRC.EMR_SYSTEM_SOURCE_NAME
	,TGT.LAST_UPDATED_DATETIME = CURRENT_TIMESTAMP()
WHEN NOT MATCHED 
THEN INSERT
	(DATA_SOURCE_KEY
	,EMR_SYSTEM_KEY
	,EMR_SYSTEM_SOURCE_NAME
	)
VALUES
	(
	SRC.DATA_SOURCE_KEY
	,SRC.EMR_SYSTEM_KEY
	,SRC.EMR_SYSTEM_SOURCE_NAME
	);
	
--Flip the minus and delete from the target
DELETE FROM ODSDATA.EMR_SYSTEM_DATA_SOURCE_REL TGT
USING
(SELECT DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME
	FROM ODSDATA.EMR_SYSTEM_DATA_SOURCE_REL
	MINUS 
	SELECT DATA_SOURCE_KEY, EMR_SYSTEM_KEY, EMR_SYSTEM_SOURCE_NAME
	FROM ODSDATA.TMP_EMR_SYSTEM_DATA_SOURCE_REL
	) SRC
WHERE TGT.DATA_SOURCE_KEY = SRC.DATA_SOURCE_KEY
AND TGT.EMR_SYSTEM_KEY = SRC.EMR_SYSTEM_KEY;