SET MY_QUERY_TAG = CONCAT(IFNULL(current_database(),''),'.',IFNULL(current_schema(),''),'  -- LoadIncremental_Stage_Member.sql');
ALTER SESSION SET QUERY_TAG = $MY_QUERY_TAG;

TRUNCATE TABLE INFA.DIM_TPA_HIERARCHY ;
COPY INTO INFA.DIM_TPA_HIERARCHY 
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimtpahierarchy).*\.txt';

TRUNCATE TABLE INFA.DIM_DATE_DAY ;
COPY INTO INFA.DIM_DATE_DAY
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimdateday).*\.txt';

TRUNCATE TABLE INFA.DIM_MEMBER;
COPY INTO INFA.DIM_MEMBER
FROM @SNOWFLAKEDATA_STAGEDATA
    FILE_FORMAT = IDAP_CSV_FILE_FORMAT_NULLABLE
    PATTERN ='.*(dimmember_).*\.txt';
	
TRUNCATE TABLE INFA.DIM_ELIGIBILITY_TYPE ;
COPY INTO INFA.DIM_ELIGIBILITY_TYPE
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimeligibilitytype).*\.txt';

TRUNCATE TABLE INFA.DIM_ENROLLMENT_SPAN ;
COPY INTO INFA.DIM_ENROLLMENT_SPAN
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimenrollmentspan).*\.txt';

TRUNCATE TABLE INFA.DIM_GL_DISTRIBUTION ;
COPY INTO INFA.DIM_GL_DISTRIBUTION
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimgldistribution).*\.txt';

TRUNCATE TABLE INFA.DIM_GROUP ;
COPY INTO INFA.DIM_GROUP
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimgroup).*\.txt';

TRUNCATE TABLE INFA.DIM_LANGUAGE;
COPY INTO INFA.DIM_LANGUAGE
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NOTNULL
	PATTERN = '.*(dimlanguage).*\.txt';

TRUNCATE TABLE INFA.DIM_MEMBER_ADDRESS;
COPY INTO INFA.DIM_MEMBER_ADDRESS
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
     ,Convert_Ind
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
     ,$39 --Convert_Ind
    FROM @SNOWFLAKEDATA_STAGEDATA
       (FILE_FORMAT => IDAP_CSV_FILE_FORMAT_NOTNULL, PATTERN => '.*(dimmemberaddress).*\.txt')
  );
   
TRUNCATE TABLE INFA.DIM_MEMBER_IDENTIFIER;
COPY INTO INFA.DIM_MEMBER_IDENTIFIER
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimmemberidentifier).*\.txt'; 

TRUNCATE TABLE INFA.DIM_PLAN;
COPY INTO INFA.DIM_PLAN
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimplan_).*\.txt';

	
TRUNCATE TABLE INFA.DIM_RATE_CELL ;
COPY INTO INFA.DIM_RATE_CELL
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE_QUOTED
	PATTERN = '.*(dimratecell).*\.txt';
	
TRUNCATE TABLE INFA.DIM_RIDER ;
COPY INTO INFA.DIM_RIDER
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimrider).*\.txt';

TRUNCATE TABLE INFA.DIM_SALES_CHANNEL ;
COPY INTO INFA.DIM_SALES_CHANNEL
FROM @SNOWFLAKEDATA_STAGEDATA
    file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
    PATTERN = '.*(dimsaleschannel).*\.txt';
        
TRUNCATE TABLE INFA.DIM_SUB_GROUP ;
COPY INTO INFA.DIM_SUB_GROUP 
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimsubgroup).*\.txt';

TRUNCATE TABLE INFA.DIM_PLAN_SEGMENT ;
COPY INTO INFA.DIM_PLAN_SEGMENT 
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(dimplansegment).*\.txt';
	
TRUNCATE TABLE INFA.FACT_ENROLLMENT ;
COPY INTO INFA.FACT_ENROLLMENT 
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(factenrollment_).*\.txt';

TRUNCATE TABLE INFA.FACT_ENROLLMENT_SNAPSHOT ;
COPY INTO INFA.FACT_ENROLLMENT_SNAPSHOT
FROM @SNOWFLAKEDATA_STAGEDATA
	file_format = IDAP_CSV_FILE_FORMAT_NULLABLE
	PATTERN = '.*(factenrollmentsnapshot).*\.txt';