CREATE OR REPLACE TABLE
	INFA.Dim_Rider (
		Dim_Rider_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		Rider_Code VARCHAR,
		Rider_Effective_Date DATE,
		Rider_Termination_Date DATE,
		Rider_Type_Code VARCHAR,
		Rider_Desc VARCHAR,
		Group_Nbr VARCHAR,
		Sub_Group_Nbr VARCHAR,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Rider PRIMARY KEY (Dim_Rider_Key),
		CONSTRAINT UK_Dim_Rider UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, Rider_Code, Rider_Effective_Date, Rider_Type_Code, Group_Nbr, Sub_Group_Nbr)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;