CREATE OR REPLACE TABLE 
	INFA.Dim_Provider_Contact_Info
	(
		Dim_Provider_Contact_Info_Key INTEGER NOT NULL,
		MD5_Value_Text VARCHAR NOT NULL,
		Insert_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL, 
		Is_Logical_Delete_Flag BOOLEAN NOT NULL DEFAULT FALSE, 
		Provider_Primary_Phone_Nbr VARCHAR NOT NULL, 
		Provider_Primary_Phone_Extension_Nbr VARCHAR NOT NULL, 
		Provider_Primary_Phone_Nbr_Formatted VARCHAR NOT NULL,
		Provider_Alternate_Phone_Nbr VARCHAR NOT NULL,
		Provider_Alternate_Phone_Extension_Nbr VARCHAR NOT NULL,
		Provider_Alternate_Phone_Nbr_Formatted VARCHAR NOT NULL,
		Provider_Fax_Nbr VARCHAR NOT NULL, 
		Provider_Fax_Nbr_Formatted VARCHAR NOT NULL, 
		Provider_International_Phone_Code VARCHAR NOT NULL, 
		Provider_Email_Address_Text VARCHAR NOT NULL,
		Convert_Ind VARCHAR NOT NULL,
		CONSTRAINT PK_Dim_Provider_Contact_Info PRIMARY KEY (Dim_Provider_Contact_Info_Key), 
		CONSTRAINT UK_Dim_Provider_Contact_Info UNIQUE (Provider_Primary_Phone_Nbr, Provider_Primary_Phone_Extension_Nbr, Provider_Alternate_Phone_Nbr, Provider_Alternate_Phone_Extension_Nbr, Provider_Fax_Nbr, Provider_International_Phone_Code, Provider_Email_Address_Text)
	) COMMENT='Landing area for data coming from IDAP SQL Server table of the same name'
	;
