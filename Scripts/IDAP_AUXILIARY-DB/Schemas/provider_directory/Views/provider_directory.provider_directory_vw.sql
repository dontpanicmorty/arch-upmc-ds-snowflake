--assumes we're receiving a single file from SQL Server called providerDirectory.txt.
--if that turns out to be a bad ASsumption we need to edit the FROM below to match
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW 
COMMENT = 'Parses providerDirectory.txt as is from the storage container so we can build JSON from it'
AS
SELECT 
providerDirectory.$1 AS id
,providerDirectory.$2 AS ClientID
,providerDirectory.$3 AS TPAID
,providerDirectory.$4 AS TPADivID
,providerDirectory.$5 AS DataSourceName
,providerDirectory.$6 AS ProviderKey
,providerDirectory.$7 AS NetworkId
,providerDirectory.$8 AS ODSProviderKey
,providerDirectory.$9 AS ProviderNbr
,providerDirectory.$10 AS ProviderFullName
,providerDirectory.$11 AS ProviderNamePartition
,providerDirectory.$12 AS ProviderSubTypeDesc
,providerDirectory.$13 AS ProviderRoleTypeDesc
,providerDirectory.$14 AS MedicaidIndicator
,providerDirectory.$15 AS EmailAddressText
,providerDirectory.$16 AS PractitionerGenderName
,providerDirectory.$17 AS PractitionerBirthDate
,providerDirectory.$18 AS providerContractId
,providerDirectory.$19 AS VCode
,providerDirectory.$20 AS FacilityType
,providerDirectory.$21 AS OfficeId
,providerDirectory.$22 AS OfficeName
,providerDirectory.$23 AS ServiceAreaStateAbbreviationName
,providerDirectory.$24 AS ServiceAreaCountyName
,providerDirectory.$25 AS AddressLine1Text
,providerDirectory.$26 AS AddressLine2Text
,providerDirectory.$27 AS CityName
,providerDirectory.$28 AS StateAbbreviationName
,providerDirectory.$29 AS CountryName
,providerDirectory.$30 AS ZipCodeNbr
,providerDirectory.$31 AS CountyName
,providerDirectory.$32 AS CoordinateType
,providerDirectory.$33 AS Coordinates
,providerDirectory.$34 AS ProviderAddressRoleTypeDesc
,providerDirectory.$35 AS PrimaryPhoneNbr
,providerDirectory.$36 AS HandicapAccessInd
,providerDirectory.$37 AS OwningMedicalGroupKey
,providerDirectory.$38 AS LocationOwningProviderNbr
,providerDirectory.$39 AS UPMCOwnedLocationIndicator
,providerDirectory.$40 AS TaxIDNbr
,providerDirectory.$41 AS UPMCOwnershipStatusDesc
,providerDirectory.$42 AS WeekendScheduleHoursIndicator
,providerDirectory.$43 AS EveningScheduleHoursIndicator
,providerDirectory.$44 AS WeekDayName
,providerDirectory.$45 AS ScheduledHoursText
,providerDirectory.$46 AS LanguageName
,providerDirectory.$47 AS BoardCertification
,providerDirectory.$48 AS AccreditationAgencyName
,providerDirectory.$49 AS IconFileText
,providerDirectory.$50 AS ProgramDescription
,providerDirectory.$51 AS ProgramLinkText
,providerDirectory.$52 AS Specialty
,providerDirectory.$53 AS CareType
,providerDirectory.$54 AS ReferralInd
,providerDirectory.$55 AS SpecialtyEntity
,providerDirectory.$56 AS PrimarySpecialtyInd
,providerDirectory.$57 AS ProviderType
,providerDirectory.$58 AS LoadDate
,providerDirectory.$59 AS TeleHealthInd
,providerDirectory.$60 AS AccreditationAgencyURL
,providerDirectory.$61 AS ProviderNPI
,providerDirectory.$62 AS OfficeLanguageName
,providerDirectory.$63 AS OfficeLanguageSupportService
,providerDirectory.$64 AS ProviderFirstName
,providerDirectory.$65 AS ProviderLastName
,providerDirectory.$66 AS VirtualCareModelInd
,providerDirectory.$67 AS MASuperPCPInd
,providerDirectory.$68 AS AlternatePhoneNbr
,providerDirectory.$69 AS FaxNbr
,providerDirectory.$70 AS MailOrderFlag
,providerDirectory.$71 AS LGBTQIACulturalCompetencyInd
FROM @PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_INBOUNDDATA/providerDirectory.txt
    (file_format => 'PROVIDER_DIRECTORY.PROV_DIR_FILE_FORMAT_NULLABLE') providerDirectory;