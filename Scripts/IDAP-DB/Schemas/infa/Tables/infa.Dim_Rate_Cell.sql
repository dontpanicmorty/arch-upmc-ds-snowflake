CREATE OR REPLACE TABLE
	INFA.Dim_Rate_Cell
	(
		Dim_Rate_Cell_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		Rate_Cell_Code VARCHAR,
		Rate_Cell_Desc VARCHAR,
		Assistance_Category_Group_Codes VARCHAR,
		Program_Status_Codes VARCHAR,
		Promise_Code VARCHAR,
		FRR_Report_Number_Desc VARCHAR,
		Rate_Cell_Effective_Date DATE,
		Rate_Cell_Term_Date DATE,
		Rate_Cell_Physical_Health_Desc VARCHAR,
		Rate_Cell_Behavioral_Health_Desc VARCHAR,
		Assistance_Category_Group_Parent_Code VARCHAR,
		Program_Status_Parent_Code VARCHAR,
		Rate_Cell_Gender_Classification_Code VARCHAR,
		Rate_Cell_Age_Range_Text VARCHAR,
		Medicare_Part_Code VARCHAR,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Rate_Cell PRIMARY KEY (Dim_Rate_Cell_Key),
		CONSTRAINT UK_Dim_Rate_Cell UNIQUE (TPA_Client_Id , TPA_Id , TPA_Div_Id , Rate_Cell_Code , Assistance_Category_Group_Codes , Program_Status_Codes , Promise_Code , FRR_Report_Number_Desc , Rate_Cell_Effective_Date , Rate_Cell_Physical_Health_Desc , Rate_Cell_Behavioral_Health_Desc , Assistance_Category_Group_Parent_Code , Program_Status_Parent_Code , Rate_Cell_Gender_Classification_Code , Rate_Cell_Age_Range_Text , Medicare_Part_Code )
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;