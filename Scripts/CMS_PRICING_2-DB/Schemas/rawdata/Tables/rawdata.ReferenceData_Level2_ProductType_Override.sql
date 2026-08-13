CREATE OR REPLACE TABLE rawdata.ReferenceData_Level2_ProductType_Override
(
	Lev2ProductTypeOverKey int IDENTITY(1,1) NOT NULL,
	ClientID varchar(6) NOT NULL,
	TPAId varchar(6) NOT NULL,
	TPADivID varchar(4) NOT NULL,
	Product varchar(75) NULL,
	SecondLevelProductType varchar(150) NULL,
	ProductTypeOUT varchar(8000) NULL,
	LastUpdatedDatetime datetime NOT NULL,
	LastUpdatedUserName varchar(25) NOT NULL
)COMMENT='Replicated from ReferenceData SQL database';