/***************************************
***   Static data management script  ***
***************************************/

-- This script will manage the static data from for stagedata.DIM_MEMBER_ADDRESS

SELECT 'Updating static data table DIMDATA.DIM_MEMBER_ADDRESS';

-- 1: Define table variable
CREATE OR REPLACE TEMPORARY table DIMDATA.tmp_DIM_MEMBER_ADDRESS
(
    Dim_Member_Address_Key NUMBER(38,0) NOT NULL,
    MD5_Value_Text VARCHAR NOT NULL,
    Dim_Member_Key NUMBER(38,0) NOT NULL,
    Member_Address_Type VARCHAR NOT NULL,
    Member_AddressLine1_Text VARCHAR NOT NULL,
    Member_AddressLine2_Text VARCHAR NOT NULL,
    Member_City_Name VARCHAR NOT NULL,
    Member_State_Abbreviation_Name VARCHAR NOT NULL,
    Member_Zip_Code_Nbr VARCHAR NOT NULL,
    Member_FIPS_Code VARCHAR,
	Member_FIPS_State_Code VARCHAR,
	Member_FIPS_County_Code VARCHAR,
	Member_CMS_County_Code VARCHAR,
    Member_County_Desc VARCHAR,
    Member_Latitude_Nbr NUMBER(9,6),
    Member_Longitude_Nbr NUMBER(9,6),
    Effective_Start_Date DATE NOT NULL,
    Effective_End_Date DATE,
    Active_Ind VARCHAR NOT NULL,
    Valid_Ind VARCHAR,
    Congressional_District VARCHAR,
	Verified_AddressLine1_Text VARCHAR,
	Verified_AddressLine2_Text VARCHAR,
    Verified_County_Description VARCHAR,
    Verified_Primary_Number VARCHAR,
    Verified_Street_Name VARCHAR,
    Verified_Street_Predirection VARCHAR,
    Verified_Street_Postdirection VARCHAR,
    Verified_Street_Suffix VARCHAR,
    Verified_Secondary_Number VARCHAR,
    Verified_Extra_Secondary_Number VARCHAR,
	Verified_City_Name VARCHAR,
	Verified_State VARCHAR,
	Verified_ZipCode5_Nbr VARCHAR,
	Verified_ZipCode9_Nbr VARCHAR,
    Verified_Precision VARCHAR,
    Insert_Datetime TIMESTAMP_TZ(9) NOT NULL,
    Last_Updated_Datetime TIMESTAMP_TZ(9) NOT NULL
)
;
-- 2: Populate the table variable with data
-- This is where you manage your data in source control. You
-- can add and modify entries, but because of potential foreign
-- key contraint violations this script will not delete any
-- removed entries. If you remove an entry then it will no longer
-- be added to new databases based on your schema, but the entry
-- will not be deleted from databases in which the value already exists.
INSERT INTO DIMDATA.TMP_DIM_MEMBER_ADDRESS (Dim_Member_Address_Key, MD5_Value_Text, Dim_Member_Key,Member_Address_Type,Member_AddressLine1_Text,Member_AddressLine2_Text,Member_City_Name,Member_State_Abbreviation_Name,Member_Zip_Code_Nbr,Member_FIPS_Code,Member_FIPS_State_Code,Member_FIPS_County_Code,Member_CMS_County_Code,Member_County_Desc,Member_Latitude_Nbr,Member_Longitude_Nbr,Effective_Start_Date,Effective_End_Date,Active_Ind,Valid_Ind,Congressional_District,Verified_AddressLine1_Text,Verified_AddressLine2_Text,Verified_County_Description,Verified_Primary_Number ,Verified_Street_Name ,Verified_Street_Predirection,Verified_Street_Postdirection,Verified_Street_Suffix ,Verified_Secondary_Number,Verified_City_Name,Verified_State,Verified_ZipCode5_Nbr,Verified_ZipCode9_Nbr,Verified_Precision, Insert_Datetime,Last_Updated_Datetime)
	VALUES(1, 'Unknown', 1, 'Unknown', 'Unknown','Unknown','Unknown','Unknown','Unknown',NULL,NULL,NULL,NULL,'Unknown',NULL,NULL,'1900-01-01','9999-12-31','Y','Y',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());


-- 3: Insert any new items into the table from the table variable
INSERT INTO DIMDATA.DIM_MEMBER_ADDRESS (Dim_Member_Address_Key, MD5_Value_Text, Dim_Member_Key,Member_Address_Type,Member_AddressLine1_Text,Member_AddressLine2_Text,Member_City_Name,Member_State_Abbreviation_Name,Member_Zip_Code_Nbr,Member_FIPS_Code,Member_FIPS_State_Code,Member_FIPS_County_Code,Member_CMS_County_Code,Member_County_Desc,Member_Latitude_Nbr,Member_Longitude_Nbr,Effective_Start_Date,Effective_End_Date,Active_Ind,Valid_Ind,Congressional_District,Verified_AddressLine1_Text,Verified_AddressLine2_Text,Verified_County_Description,Verified_Primary_Number ,Verified_Street_Name ,Verified_Street_Predirection,Verified_Street_Postdirection,Verified_Street_Suffix ,Verified_Secondary_Number,Verified_City_Name,Verified_State,Verified_ZipCode5_Nbr,Verified_ZipCode9_Nbr,Verified_Precision,Insert_Datetime,Last_Updated_Datetime)
SELECT tmp.Dim_Member_Address_Key, tmp.MD5_Value_Text, tmp.Dim_Member_Key, tmp.Member_Address_Type, tmp.Member_AddressLine1_Text, tmp.Member_AddressLine2_Text, tmp.Member_City_Name, tmp.Member_State_Abbreviation_Name, tmp.Member_Zip_Code_Nbr, tmp.Member_FIPS_Code,tmp.Member_FIPS_State_Code,tmp.Member_FIPS_County_Code,tmp.Member_CMS_County_Code, tmp.Member_County_Desc, tmp.Member_Latitude_Nbr, tmp.Member_Longitude_Nbr, tmp.Effective_Start_Date, tmp.Effective_End_Date, tmp.Active_Ind, tmp.Valid_Ind, tmp.Congressional_District,tmp.Verified_AddressLine1_Text,tmp.Verified_AddressLine2_Text,tmp.Verified_County_Description,tmp.Verified_Primary_Number ,tmp.Verified_Street_Name ,tmp.Verified_Street_Predirection,tmp.Verified_Street_Postdirection,tmp.Verified_Street_Suffix ,tmp.Verified_Secondary_Number,tmp.Verified_City_Name,tmp.Verified_State,tmp.Verified_ZipCode5_Nbr,tmp.Verified_ZipCode9_Nbr,tmp.Verified_Precision, tmp.Insert_Datetime, tmp.Last_Updated_Datetime
FROM DIMDATA.tmp_DIM_MEMBER_ADDRESS tmp
    LEFT JOIN DIMDATA.DIM_MEMBER_ADDRESS LIVE_TABLE ON (LIVE_TABLE.DIM_MEMBER_ADDRESS_KEY = tmp.DIM_MEMBER_ADDRESS_KEY)
WHERE LIVE_TABLE.DIM_MEMBER_ADDRESS_KEY IS NULL
;
-- 4: Update any modified values with the values from the table variable
--left out for now since this is  strictly for default records

SELECT 'Finished updating static data table DIMDATA.DIM_MEMBER_ADDRESS';