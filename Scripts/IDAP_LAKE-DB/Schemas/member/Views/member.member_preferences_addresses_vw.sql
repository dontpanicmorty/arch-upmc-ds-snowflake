
CREATE OR REPLACE VIEW MEMBER.MEMBER_PREFERENCES_ADDRESSES_VW
COMMENT = 'Parses Address Array from JSON to expose individual rows along with an index and MEMBER_PREFERENCES_KEY'
AS
SELECT
    MEMBER_PREFERENCES_KEY,
    ADDRESSES.INDEX AS ADDRESS_ARRAY_INDEX,
    CASE WHEN ADDRESSES.value:Type::string = '0' THEN 'Physical'
         WHEN ADDRESSES.value:Type::string = '1' THEN 'Mailing'
         WHEN ADDRESSES.value:Type::string = '2' THEN 'Alternate'
         ELSE ADDRESSES.value:Type::string
         END AS ADDRESS_TYPE,
    ADDRESSES.value:Line1::string as ADDRESS_LINE_1,
    ADDRESSES.value:Line2::string as ADDRESS_LINE_2,
    ADDRESSES.value:Line3::string as ADDRESS_LINE_3,
    ADDRESSES.value:City::string as ADDRESS_CITY,
    ADDRESSES.value:State::string as ADDRESS_STATE,
    ADDRESSES.value:ZipCode::string as ADDRESS_ZIP_CODE,
    ADDRESSES.value:Country::string as ADDRESS_COUNTRY,
    ADDRESSES.value:IsValid::string as ADDRESS_IS_VALID,
    ADDRESSES.value:IsVerified::string as ADDRESS_IS_VERIFIED,
    ADDRESSES.value:VerifiedOn::string as ADDRESS_VERIFIED_ON,
    ADDRESSES.value:VerificationMethod::string as ADDRESS_VERIFICATION_METHOD,
    ADDRESSES.value:DataSource.Name::string as ADDRESS_DATA_SOURCE_NAME,
    ADDRESSES.value:DataSource.UpdatedOn::string as ADDRESS_DATA_SOURCE_UPDATED_ON
FROM MEMBER.MEMBER_PREFERENCES_JSON_VW
    ,TABLE(FLATTEN(JSON_DATA:Addresses)) ADDRESSES
    ;