CREATE OR REPLACE TABLE rawdata.ReferenceData_Provdir_Level_2_Network_Crosswalk
(
	LevelTwoKey int IDENTITY(1,1) NOT NULL,
	Product varchar(75) NULL,
	ProductKey int NULL,
	ProductType varchar(150) NULL,
	ProductTypeKey int NULL,
	SecondLevelProduct varchar(75) NULL,
	SecondLevelProductKey int NULL,
	SecondLevelProductType varchar(150) NULL,
	SecondLevelProductTypeKey int NULL
)COMMENT='Replicated from ReferenceData SQL database';