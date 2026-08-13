CREATE OR REPLACE TABLE rawdata.ReferenceData_ProvDir_Level2_Product_Exclusion
(
	LPEKey varchar(1) NOT NULL,
	ClientId varchar(6) NOT NULL,
	TPAId varchar(6) NOT NULL,
	TPADivId varchar(4) NOT NULL,
	SourceProviderNbr varchar(6) NOT NULL,
	ProductKey varchar(2) NOT NULL,
	ProductName varchar(32) NOT NULL
)COMMENT='Replicated from ReferenceData SQL database';