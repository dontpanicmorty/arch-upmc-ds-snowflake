SET MY_QUERY_TAG = CONCAT(IFNULL(current_database(),''),'.',IFNULL(current_schema(),''),'  -- LoadFullExtract.sql');
ALTER SESSION SET QUERY_TAG = $MY_QUERY_TAG;

TRUNCATE TABLE DIMDATA.DIM_DATE_DAY ;
COPY INTO DIMDATA.DIM_DATE_DAY
FROM '@SNOWFLAKEDATA_IDAPDATA/DimDateDay.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_ELIGIBILITY_TYPE ;
COPY INTO DIMDATA.DIM_ELIGIBILITY_TYPE
FROM '@SNOWFLAKEDATA_IDAPDATA/DimEligibilityType.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_ENROLLMENT_SPAN;
COPY INTO DIMDATA.DIM_ENROLLMENT_SPAN
FROM '@SNOWFLAKEDATA_IDAPDATA/DimEnrollmentSpan.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_GL_DISTRIBUTION ;
COPY INTO DIMDATA.DIM_GL_DISTRIBUTION
FROM '@SNOWFLAKEDATA_IDAPDATA/DimGLDistribution.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_GROUP ;
COPY INTO DIMDATA.DIM_GROUP
FROM '@SNOWFLAKEDATA_IDAPDATA/DimGroup.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_MEMBER;
COPY INTO DIMDATA.DIM_MEMBER 
FROM '@SNOWFLAKEDATA_IDAPDATA/DimMember.txt'
    file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;
    	
TRUNCATE TABLE DIMDATA.DIM_MEMBER_ADDRESS;
COPY INTO DIMDATA.DIM_MEMBER_ADDRESS
    (
      Dim_Member_Address_Key
     ,MD5_Value_Text
     ,Dim_Member_Key
     ,Member_Address_Type
     ,Member_AddressLine1_Text
     ,Member_AddressLine2_Text
     ,Member_City_Name
     ,Member_State_Abbreviation_Name
     ,Member_Zip_Code_Nbr
	 ,Member_FIPS_Code
     ,Member_FIPS_State_Code
	 ,Member_FIPS_County_Code
     ,Member_CMS_County_Code
     ,Member_County_Desc
     ,Member_Latitude_Nbr
     ,Member_Longitude_Nbr
     ,Effective_Start_Date
     ,Effective_End_Date
     ,Active_Ind
     ,Valid_Ind
	 ,Congressional_District
	 ,Verified_AddressLine1_Text
	 ,Verified_AddressLine2_Text
	 ,Verified_County_Description
	 ,Verified_Primary_Number
     ,Verified_Street_Name
     ,Verified_Street_Predirection
     ,Verified_Street_Postdirection
     ,Verified_Street_Suffix
     ,Verified_Secondary_Number
     ,Verified_Extra_Secondary_Number
	 ,Verified_City_Name
	 ,Verified_State
	 ,Verified_ZipCode5_Nbr
	 ,Verified_ZipCode9_Nbr
	 ,Verified_Precision
     ,Insert_Datetime
     ,Last_Updated_Datetime
    )

FROM (
    SELECT
      $1 --DimMemberAddressKey
     ,$2 --MD5ValueText
     ,$3 --DimMemberKey
     ,$4 --MemberAddress_Type
     ,$5 --MemberAddressLine1Text
     ,$6 --MemberAddressLine2Text
     ,$7 --MemberCityName
     ,$8 --MemberStateAbbreviationName
     ,$9 --MemberZip_CodeNbr
     ,$10 --MemberFIPSCode
	 ,$11 --MemberFIPSStateCode
	 ,$12 --MemberFIPSCountyCode
	 ,$13 --MemberCMSCountyCode
     ,$14 --MemberCountyDesc
     ,$15 --MemberLatitudeNbr
     ,$16 --MemberLongitudeNbr
     ,$17 --EffectiveStartDate
     ,CASE WHEN $18 = '' THEN NULL ELSE $18 END --EffectiveEndDate
     ,$19 --ActiveInd
     ,$20 --ValidInd
	 ,$21 --CongressionalDistrict
	 ,$22 --VerifiedAddressLine1Text
	 ,$23 --VerifiedAddressLine2Text
	 ,$24 --VerifiedCountyDescription
	 ,$25 --VerifiedPrimaryNumber
     ,$26 --VerifiedStreetName
     ,$27 --VerifiedStreetPredirection
     ,$28 --VerifiedStreetPostdirection
     ,$29 --VerifiedStreetSuffix
     ,$30  --VerifiedSecondaryNumber
     ,$31 --VerifiedExtraSecondaryNumber
	 ,$32 --VerifiedCityName
	 ,$33 --VerifiedState
	 ,$34 --VerifiedZipCode5Nbr
	 ,$35 --VerifiedZipCode9Nbr
	 ,$36 --VerifiedPrecision
     ,$37 --InsertDatetime
     ,$38 --LastUpdatedDatetime
    FROM '@SNOWFLAKEDATA_IDAPDATA/DimMemberAddress.txt'
        (FILE_FORMAT => IDAP_CSV_FILE_FORMAT_NOTNULL)
    );
    
   
TRUNCATE TABLE DIMDATA.DIM_MEMBER_IDENTIFIER;
COPY INTO DIMDATA.DIM_MEMBER_IDENTIFIER
FROM '@SNOWFLAKEDATA_IDAPDATA/DimMemberIdentifier.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE; 

TRUNCATE TABLE DIMDATA.DIM_PLAN;
COPY INTO DIMDATA.DIM_PLAN
FROM '@SNOWFLAKEDATA_IDAPDATA/DimPlan.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;
	
TRUNCATE TABLE DIMDATA.DIM_RATE_CELL ;
COPY INTO DIMDATA.DIM_RATE_CELL
FROM '@SNOWFLAKEDATA_IDAPDATA/DimRateCell.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE_QUOTED;
	
TRUNCATE TABLE DIMDATA.DIM_RIDER ;
COPY INTO DIMDATA.DIM_RIDER
	(
		Dim_Rider_Key,
		MD5_Value_Text,
		Insert_Datetime,
		Last_Updated_Datetime,
		TPA_Client_Id,
		TPA_Id,
		TPA_Div_Id,
		Rider_Code,
		Rider_Effective_Date,
		Rider_Termination_Date,
		Rider_Type_Code,
		Rider_Desc,
		Group_Nbr,
		Sub_Group_Nbr
	)
FROM (SELECT
		$1 --Dim_Rider_Key
		,$2 --MD5_Value_Text
		,$3 --Insert_Datetime,
		,$4 --Last_Updated_Datetime,
		,$5 --TPA_Client_Id,
		,$6 --TPA_Id,
		,$7 --TPA_Div_Id,
		,$8 --Rider_Code,
		,$9 --Rider_Effective_Date,
		,$10 --Rider_Termination_Date,
		,$11 --Rider_Type_Code,
		,$12 --Rider_Desc,
		,$13 --Group_Nbr,
		,$14 --Sub_Group_Nbr
	FROM '@SNOWFLAKEDATA_IDAPDATA/DimRider.txt'
		(file_format => IDAP_CSV_FILE_FORMAT_NULLABLE)
);
	
TRUNCATE TABLE DIMDATA.DIM_SALES_CHANNEL ;
COPY INTO DIMDATA.DIM_SALES_CHANNEL 
FROM '@SNOWFLAKEDATA_IDAPDATA/DimSalesChannel.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;
	
TRUNCATE TABLE DIMDATA.DIM_SUB_GROUP ;
COPY INTO DIMDATA.DIM_SUB_GROUP 
FROM '@SNOWFLAKEDATA_IDAPDATA/DimSubGroup.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;
	
TRUNCATE TABLE DIMDATA.DIM_TPA_HIERARCHY ;
COPY INTO DIMDATA.DIM_TPA_HIERARCHY 
FROM '@SNOWFLAKEDATA_IDAPDATA/DimTPAHierarchy.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.DIM_PLAN_SEGMENT ;
COPY INTO DIMDATA.DIM_PLAN_SEGMENT 
FROM '@SNOWFLAKEDATA_IDAPDATA/DimPlanSegment.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;

TRUNCATE TABLE DIMDATA.FACT_ENROLLMENT ;
COPY INTO DIMDATA.FACT_ENROLLMENT 
FROM '@SNOWFLAKEDATA_IDAPDATA/FactEnrollment.txt'
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE;
