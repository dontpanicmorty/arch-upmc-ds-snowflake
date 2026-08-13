CREATE OR REPLACE TABLE
	INFA.Dim_Sub_Group (
		Dim_Sub_Group_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL,
		TPA_Client_Id VARCHAR NOT NULL,
		TPA_Id VARCHAR NOT NULL,
		TPA_Div_Id VARCHAR NOT NULL,
		Group_Nbr VARCHAR,
		Sub_Group_Nbr VARCHAR,
		Sub_Group_Category_Code VARCHAR,
		Sub_Group_Name VARCHAR,
		Termination_Date DATE,
		Sub_Group_Billing_State_Abbreviation_Name VARCHAR,
		Sub_Group_Billing_Zip_Code_Nbr VARCHAR,
		Sub_Group_Billing_FIPS_County_Code VARCHAR,
		Sub_Group_Billing_FIPS_County_Name VARCHAR,
		Division_Id VARCHAR,
		Sub_Group_Id INTEGER,
		Current_Sub_Group_Effective_Date DATE,
		Pending_Renewal_Date DATE,
		Current_Sub_Group_End_Date DATE,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Sub_Group PRIMARY KEY (Dim_Sub_Group_Key),
		CONSTRAINT UK_Dim_Sub_Group UNIQUE (TPA_Client_Id, TPA_Id, TPA_Div_Id, Group_Nbr, Sub_Group_Nbr)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;