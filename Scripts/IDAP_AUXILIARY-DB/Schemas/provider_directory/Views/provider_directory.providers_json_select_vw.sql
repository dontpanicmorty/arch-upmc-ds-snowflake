--Lots of order by statements in here but they are necessary to ensure consistent formatting of the output
CREATE OR REPLACE VIEW PROVIDER_DIRECTORY.PROVIDERS_JSON_SELECT_VW 
COMMENT = 'Assembles the JSON structures required by FindCare providers collection'
AS
with 
SERVICEAREAS as
(--providerAddresses.serviceAreas array construction
	select 
		id,
		networkid,
		providerkey,
		officeid,
		array_agg(distinct object_construct('area', SERVICEAREACOUNTYNAME, 'state', SERVICEAREASTATEABBREVIATIONNAME)) 
			within group (order by object_construct('area', SERVICEAREACOUNTYNAME, 'state', SERVICEAREASTATEABBREVIATIONNAME)) as serviceareasJSON
	from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
	where SERVICEAREACOUNTYNAME is not null
	group by 
		id,
		networkid,
		providerkey,
		officeid
	order by 
		id,
		networkid, 
		providerkey,
		officeid,
		serviceareasJSON
),
PROVIDERSCHEDULES as
(--providerAddresses.providerSchedules array construction
    select 
        id,
        networkid,
        providerkey,
        officeid,
        array_agg(distinct object_construct('weekDay', weekDayname,'scheduledHoursText', scheduledHoursText)) 
            within group (order by object_construct('weekDay', weekDayname,'scheduledHoursText', scheduledHoursText)) as providerSchedulesJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    where weekDayname is not null
    group by 
        id,
        networkid,
        providerkey,
        officeid
    order by 
        id,
        networkid,
        providerkey,
        officeid,
        providerSchedulesJSON
),
OFFICELANGUAGES as
(--providerAddresses.officeLanguages array construction
    select 
        id,
        networkid,
        providerkey,
        officeid,
        array_agg(distinct object_construct('officeLanguageName', officeLanguageName, 'officeLanguageSupportServices', OFFICELANGUAGESUPPORTSERVICE))
            within group (order by object_construct('officeLanguageName', officeLanguageName, 'officeLanguageSupportServices', OFFICELANGUAGESUPPORTSERVICE)) as officeLanguagesJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW 
    where officeLanguageName is not null
    group by
        id,
        networkid,
        providerkey,
        officeid
    order by
        id,
        networkid,
        providerkey,
        officeid,
        officeLanguagesJSON
),
PROVIDERSPECIALTIES as
(--providerAddresses.providerSpecialties array construction
    select
        id,
        networkid,
        providerkey,
        officeid,
        array_agg(distinct object_construct('specialtyName', specialty, 'specialtyReferralIndicator', ReferralInd, 'primarySpecialtyIndicator', primarySpecialtyInd, 'providerType', providerType))
            within group (order by object_construct('specialtyName', specialty, 'specialtyReferralIndicator', ReferralInd, 'primarySpecialtyIndicator', primarySpecialtyInd, 'providerType', providerType)) as providerSpecialtiesJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    group by
        id,
        networkid,
        providerkey,
        officeid
    order by
        id,
        networkid,
        providerkey,
        officeid,
        providerSpecialtiesJSON
),
COORDINATES as
(--providerAddresses.address.location.coordinates array construction
    select
        id,
        officeid,
        zipcodenbr,
        COORDINATES,
        array_agg(distinct COORDINATES) AS coordinatesjson
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    group by
        id,
        officeid,
        zipcodenbr,
        COORDINATES
    order by
        id,
        officeid,
        zipcodenbr,
        COORDINATES,
        coordinatesjson
),
LOCATION as
(--providerAddresses.address.location array construction
    select
        PROVIDERDIRECTORY.id,
        PROVIDERDIRECTORY.officeid,
        PROVIDERDIRECTORY.zipcodenbr,
        PROVIDERDIRECTORY.COORDINATES,
        object_construct('type', COORDINATETYPE, 'coordinates', c.coordinatesjson) AS locationjson
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW as PROVIDERDIRECTORY
    left join COORDINATES c 
        on c.id = PROVIDERDIRECTORY.id 
        and c.officeid = PROVIDERDIRECTORY.officeid 
        and PROVIDERDIRECTORY.zipcodenbr = c.zipcodenbr 
        and c.COORDINATES = PROVIDERDIRECTORY.COORDINATES
    group by 
        PROVIDERDIRECTORY.id,
        PROVIDERDIRECTORY.officeid,
        PROVIDERDIRECTORY.zipcodenbr,
        PROVIDERDIRECTORY.COORDINATES,
        COORDINATETYPE,
        c.coordinatesjson
    order by
        PROVIDERDIRECTORY.id,
        PROVIDERDIRECTORY.officeid,
        PROVIDERDIRECTORY.zipcodenbr,
        COORDINATETYPE,
        c.coordinatesjson
),
ADDRESS as
(--providerAddresses.address array construction
    select distinct
        PROVIDERDIRECTORY.id,
        networkid,
        providerkey,
        PROVIDERDIRECTORY.officeid,
        ADDRESSLINE1TEXT,
        object_construct('addressLine1', ADDRESSLINE1TEXT, 'addressLine2', ADDRESSLINE2TEXT, 'city', CITYNAME, 'stateAbbreviation', STATEABBREVIATIONNAME, 'countryName', COUNTRYNAME, 'zipCode', PROVIDERDIRECTORY.ZIPCODENBR, 'countyName', COUNTYNAME, 'location', locationjson) as addressJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW as PROVIDERDIRECTORY
    left join LOCATION
        on LOCATION.id = PROVIDERDIRECTORY.id 
        and LOCATION.officeid = PROVIDERDIRECTORY.officeid
        and PROVIDERDIRECTORY.ZIPCODENBR = LOCATION.ZIPCODENBR
        and PROVIDERDIRECTORY.COORDINATES = LOCATION.COORDINATES
    group by
        PROVIDERDIRECTORY.id,
        networkid,
        providerkey,
        PROVIDERDIRECTORY.officeid,
        PROVIDERDIRECTORY.officeid,
        ADDRESSLINE1TEXT,
        ADDRESSLINE2TEXT,
        CITYNAME,
        STATEABBREVIATIONNAME,
        COUNTRYNAME,
        PROVIDERDIRECTORY.ZIPCODENBR,
        COUNTYNAME,
        locationjson
),
CONTRACTS as
(--providerAddresses.contracts array construction
--outermost contracts array construction
    select 
        src.providerAddressRelKey,
        src.provDirNetworkId,
        array_agg(distinct (object_construct('providerContractId', src.providerAddressRelKey || '|' || src.provDirNetworkId, 'subProductKey', src.provDirH2SubproductKey,
            'leveledPlanIndicator', src.LEVELEDSUBPRODUCTIND, 'contractLevel', src.CONTRACTLEVELCODE, 'restrictionDescription', src.PROVDIRRESTRICTIONDESC,
            'acceptingNewpatientsIndicator', src.ACCEPTINGNEWPATIENTSIND, 'restrictionRank', src.RESTRICTIONRANKNBR, 'alternateNetworkName', src.alternateNetworkName)))
        within group (order by object_construct('providerContractId', src.providerAddressRelKey || '|' || src.provDirNetworkId, 'subProductKey', src.provDirH2SubproductKey,
            'leveledPlanIndicator', src.LEVELEDSUBPRODUCTIND, 'contractLevel', src.CONTRACTLEVELCODE, 'restrictionDescription', src.PROVDIRRESTRICTIONDESC,
            'acceptingNewpatientsIndicator', src.ACCEPTINGNEWPATIENTSIND, 'restrictionRank', src.RESTRICTIONRANKNBR, 'alternateNetworkName', src.alternateNetworkName)) as contractsJSON
    from 
    (
        --Selection of Minimum contractlevelcode  
        select
            a.ProviderAddressRelKey,
            a.PROVDIRNETWORKID,
            a.PROVDIRH2SUBPRODUCTKEY,
            a.LeveledSubproductInd,
            a.PROVDIRRESTRICTIONDESC,
            a.ACCEPTINGNEWPATIENTSIND,
            b.RESTRICTIONRANKNBR, 
            a.alternateNetworkName, min(a.CONTRACTLEVELCODE) as CONTRACTLEVELCODE
        from PROVIDER_DIRECTORY.providers_contract_vw a
        --lookup to calculate ranked RestrictionRankNbr
        inner join 
            (
                SELECT 
                    providers_contract_vw.PROVDIRRESTRICTIONDESC,
                    dense_rank() over (partition by ProviderAddressRelKey, PROVDIRNETWORKID order by RestrictionRanknbr::integer asc, PROVDIRH2SUBPRODUCTKEY::integer) AS RestrictionRankNbr, 
                    providers_contract_vw.PROVIDERADDRESSRELKEY,
                    providers_contract_vw.PROVDIRH2SUBPRODUCTKEY, 
                    providers_contract_vw.PROVDIRNETWORKID,
                    providers_contract_vw.ACCEPTINGNEWPATIENTSIND
                FROM PROVIDER_DIRECTORY.providers_contract_vw 
                ORDER BY 
                    PROVIDERADDRESSRELKEY,
                    PROVDIRH2SUBPRODUCTKEY,
                    PROVDIRNETWORKID,
                    RestrictionRankNbr ASC
            ) b
         on a.ProviderAddressRelKey = b.ProviderAddressRelKey 
         and a.PROVDIRNETWORKID = b.PROVDIRNETWORKID 
         and a.PROVDIRH2SUBPRODUCTKEY = b.PROVDIRH2SUBPRODUCTKEY
         --group by for Minimum contractlevelcode     
        group by 
            a.ProviderAddressRelKey,
            a.PROVDIRNETWORKID,
            a.PROVDIRH2SUBPRODUCTKEY,
            a.LeveledSubproductInd,
            a.PROVDIRRESTRICTIONDESC,
            a.ACCEPTINGNEWPATIENTSIND,
            b.RESTRICTIONRANKNBR,
            a.alternateNetworkName
    ) src
    --group by for outermost array_agg function
    group by 
        src.providerAddressRelKey,
        src.provDirNetworkId
    order by 
        src.providerAddressRelKey,
        src.provDirNetworkId,
        contractsJSON
),
PROVIDERADDRESS as 
(--providerAddresses array construction
    select
        PROVIDER_DIRECTORY_VW.id,
        PROVIDER_DIRECTORY_VW.networkid,
        PROVIDER_DIRECTORY_VW.providerkey,
        array_agg(distinct object_construct('officeId', PROVIDER_DIRECTORY_VW.officeId, 'dataSource', dataSourcename, 'officeName', officeName, 'primaryPhoneNumber', primaryPhoneNbr,
            'faxNumber', faxNbr, 'handicapAccessIndicator', handicapAccessInd, 'teleHealthIndicator', teleHealthInd, 'contracts', contracts.contractsJSON,
            'virtualCareModelIndicator', virtualCareModelInd, 'maSuperPCPInd', maSuperPCPInd, 'upmcOwnedLocationIndicator', UPMCOwnedLocationIndicator,
            'taxIdentificationNumber', taxidnbr, 'vCode', vcode, 'facilityType', facilityType,'weekendScheduleHoursIndicator', WEEKENDSCHEDULEHOURSINDICATOR,
            'eveningScheduleHoursIndicator', EVENINGSCHEDULEHOURSINDICATOR, 'officeLanguages', officeLanguagesJSON, 'providerSchedules', providerSchedulesJSON,
            'serviceareas', serviceareas.serviceareasJSON, 'providerSpecialties', providerSpecialtiesJSON, 'address', address.addressJSON, 
            'officeNameSearch', UPPER(REGEXP_REPLACE(officeName , '([^$a-zA-Z0-9])',''))))
        within group (order by object_construct('officeId', PROVIDER_DIRECTORY_VW.officeId, 'dataSource', dataSourcename, 'officeName', officeName, 'primaryPhoneNumber', primaryPhoneNbr,
            'faxNumber', faxNbr, 'handicapAccessIndicator', handicapAccessInd, 'teleHealthIndicator', teleHealthInd, 'contracts', contracts.contractsJSON,
            'virtualCareModelIndicator', virtualCareModelInd, 'maSuperPCPInd', maSuperPCPInd, 'upmcOwnedLocationIndicator', UPMCOwnedLocationIndicator,
            'taxIdentificationNumber', taxidnbr, 'vCode', vcode, 'facilityType', facilityType,'weekendScheduleHoursIndicator', WEEKENDSCHEDULEHOURSINDICATOR,
            'eveningScheduleHoursIndicator', EVENINGSCHEDULEHOURSINDICATOR, 'officeLanguages', officeLanguagesJSON, 'providerSchedules', providerSchedulesJSON,
            'serviceareas', serviceareas.serviceareasJSON, 'providerSpecialties', providerSpecialtiesJSON, 'address', address.addressJSON, 
            'officeNameSearch', UPPER(REGEXP_REPLACE(officeName , '([^$a-zA-Z0-9])','')))) as providerAddress
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    left join contracts 
        on (contracts.providerAddressRelKey||'|'||contracts.provDirNetworkId) = PROVIDER_DIRECTORY_VW.providercontractId
    left join serviceareas 
        on serviceareas.id = PROVIDER_DIRECTORY_VW.id
        and serviceareas.networkid = PROVIDER_DIRECTORY_VW.networkid
        and serviceareas.providerkey = PROVIDER_DIRECTORY_VW.providerkey
        and serviceareas.officeid = PROVIDER_DIRECTORY_VW.officeid
    left join providerSchedules 
        on providerSchedules.id = PROVIDER_DIRECTORY_VW.id
        and providerSchedules.networkid = PROVIDER_DIRECTORY_VW.networkid
        and providerSchedules.providerkey = PROVIDER_DIRECTORY_VW.providerkey
        and providerSchedules.officeid = PROVIDER_DIRECTORY_VW.officeid
    left join officeLanguages 
        on officeLanguages.id = PROVIDER_DIRECTORY_VW.id 
        and officeLanguages.networkid = PROVIDER_DIRECTORY_VW.networkid
        and officeLanguages.providerkey = PROVIDER_DIRECTORY_VW.providerkey
        and officeLanguages.officeid = PROVIDER_DIRECTORY_VW.officeid
    left join providerSpecialties 
        on providerSpecialties.id = PROVIDER_DIRECTORY_VW.id
        and providerSpecialties.networkid = PROVIDER_DIRECTORY_VW.networkid
        and providerSpecialties.providerkey = PROVIDER_DIRECTORY_VW.providerkey
        and providerSpecialties.officeid = PROVIDER_DIRECTORY_VW.officeid
    left join address 
        on address.id = PROVIDER_DIRECTORY_VW.id
        and address.networkid = PROVIDER_DIRECTORY_VW.networkid
        and address.providerkey = PROVIDER_DIRECTORY_VW.providerkey
        and address.officeid = PROVIDER_DIRECTORY_VW.officeid
        and address.ADDRESSLINE1TEXT = PROVIDER_DIRECTORY_VW.ADDRESSLINE1TEXT
    group by 
        PROVIDER_DIRECTORY_VW.id,
        PROVIDER_DIRECTORY_VW.networkid,
        PROVIDER_DIRECTORY_VW.providerkey
    order by
        PROVIDER_DIRECTORY_VW.id,
        PROVIDER_DIRECTORY_VW.networkid,
        PROVIDER_DIRECTORY_VW.providerkey,
        providerAddress
),
FACILITYCONTRACT as
(--providerAffiliations.facilityContract array construction
    select
        providerKey || provDirNetworkId as providerAffiliationId,
        array_agg(distinct object_construct('facilitySubproductKey', PROVDIRH2SUBPRODUCTKEY, 'facilityContractLevel', contractLevelCode, 'leveledSubproductInd', leveledsubproductInd)) 
            within group (order by object_construct('facilitySubproductKey', PROVDIRH2SUBPRODUCTKEY, 'facilityContractLevel', contractLevelCode, 'leveledSubproductInd', leveledsubproductInd)) as facilityContractJSON
    from PROVIDER_DIRECTORY.PROVIDER_AFFILIATIONS_VW 
    group by 
        providerKey || provDirNetworkId
    order by 
        providerKey || provDirNetworkId,
        facilityContractJSON
),
providerAffiliations as
(--providerAffiliations array construction
    select 
        PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId as providerAffiliationId,
        array_agg(distinct object_construct('providerAffiliationId', PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId, 'facilityName', PROVIDER_AFFILIATIONS_VW.facilityName, 'upmcHosp', PROVIDER_AFFILIATIONS_VW.admitHospOwnedStatus, 'facilityContract', facilityContract.facilityContractJSON)) 
            within group (order by object_construct('providerAffiliationId', PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId, 'facilityName', PROVIDER_AFFILIATIONS_VW.facilityName,'upmcHosp', PROVIDER_AFFILIATIONS_VW.admitHospOwnedStatus, 'facilityContract', facilityContract.facilityContractJSON)) as providerAffiliationsJSON
    from PROVIDER_DIRECTORY.PROVIDER_AFFILIATIONS_VW 
    left join facilityContract 
        on PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId = facilityContract.providerAffiliationId
    group by 
        PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId
    order by 
        PROVIDER_AFFILIATIONS_VW.providerKey || PROVIDER_AFFILIATIONS_VW.provDirNetworkId, 
        providerAffiliationsJSON
),
BOARDCERTIFICATION as 
(--boardCertifications array constructions
    select
        id,
        networkid,
        providerkey, 
        array_agg(distinct object_construct('boardCertificationName', boardcertification))
            within group (order by object_construct('boardCertificationName', boardcertification)) as boardcertificationJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    where boardcertification is not null
    group by
        id,
        networkid,
        providerkey
    order by
        id,
        networkid,
        providerkey,
        boardcertificationJSON
),
LANGUAGENAME as 
(--providerLanguages array construction
    select 
        id,
        networkid,
        providerkey, 
        array_agg(distinct object_construct('languageName', LanguageName))
            within group (order by object_construct('languageName', LanguageName))as LanguageNameJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    where languageName is not null
    group by
        id,
        networkid,
        providerkey
    order by
        id,
        networkid,
        providerkey,
        LanguageNameJSON
),
ACCREDITATIONS as 
(--accreditations array construction
    select
        id,
        networkid,
        providerkey,
        array_agg(distinct object_construct('accreditationAgencyName', AccreditationAgencyName, 'accreditationAgencyURL', accreditationAgencyURL, 'iconFileName', IconFileText, 'programDescription', programDescription, 'programLink', ProgramLinkText))
            within group (order by object_construct('accreditationAgencyName', AccreditationAgencyName, 'accreditationAgencyURL', accreditationAgencyURL, 'iconFileName', IconFileText, 'programDescription', programDescription, 'programLink', ProgramLinkText)) as accreditationsJSON
    from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
    where accreditationAgencyName is not null
    group by
        id,
        networkid,
        providerkey
    order by
        id,
        networkid,
        providerkey,
        accreditationsJSON
)
--Final JSON document construction
select distinct PROVIDER_DIRECTORY_VW.id, 
    PROVIDER_DIRECTORY_VW.networkid,
    PROVIDER_DIRECTORY_VW.providerkey, 
    object_construct(
        'id', PROVIDER_DIRECTORY_VW.id, 
        'providerKey', PROVIDER_DIRECTORY_VW.providerkey,
        'networkId', PROVIDER_DIRECTORY_VW.clientid||PROVIDER_DIRECTORY_VW.tpaid||PROVIDER_DIRECTORY_VW.tpadivid||PROVIDER_DIRECTORY_VW.networkid, 
        'isLogicalDelete', 0, 
        'isOfficeUpdated', PROVIDER_DIRECTORY_OFFICE_LIST.OFFICE_ID_CHANGE_IND,
        'sourceProviderNumber', providernbr, 
        'emailAddress', EMAILADDRESSTEXT, 
        'medicaidIndicator', medicaidindicator, 
        'providerFullName', providerfullname, 
        'providerFirstName', providerFirstName, 
        'providerLastName', providerLastName, 
        'subType', PROVIDER_DIRECTORY_VW.PROVIDERSUBTYPEDESC,
        'providerFullNameSearch', UPPER(REGEXP_REPLACE(PROVIDER_DIRECTORY_VW.ProviderFullName , '([^$a-zA-Z0-9])','')),
        'gender', PRACTITIONERGENDERNAME, 'providerNPI', providerNPI, 'providerAddresses', ProviderAddress.providerAddress, 
        'boardCertifications', boardcertification.boardcertificationJSON, 
        'providerLanguages', LanguageName.LanguageNameJSON, 
        'accreditations', accreditations.accreditationsJSON, 
        'providerAffiliations', providerAffiliations.providerAffiliationsJSON 
     ) as ProvDirJSONtxt
from PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_VW
left join boardcertification 
	on boardcertification.id = PROVIDER_DIRECTORY_VW.id
	and boardcertification.networkid = PROVIDER_DIRECTORY_VW.networkid
	and boardcertification.providerkey = PROVIDER_DIRECTORY_VW.providerkey
left join LanguageName
	on LanguageName.id = PROVIDER_DIRECTORY_VW.id
	and LanguageName.networkid = PROVIDER_DIRECTORY_VW.networkid
	and LanguageName.providerkey = PROVIDER_DIRECTORY_VW.providerkey
left join accreditations 
	on accreditations.id = PROVIDER_DIRECTORY_VW.id
    and accreditations.networkid = PROVIDER_DIRECTORY_VW.networkid
    and accreditations.providerkey = PROVIDER_DIRECTORY_VW.providerkey
left join ProviderAddress 
	on ProviderAddress.id = PROVIDER_DIRECTORY_VW.id
    and ProviderAddress.networkid = PROVIDER_DIRECTORY_VW.networkid
    and ProviderAddress.providerkey = PROVIDER_DIRECTORY_VW.providerkey
left join providerAffiliations 
	on (PROVIDER_DIRECTORY_VW.providerKey || PROVIDER_DIRECTORY_VW.NetworkId) = providerAffiliations.providerAffiliationId
left join PROVIDER_DIRECTORY.PROVIDER_DIRECTORY_OFFICE_LIST
    on PROVIDER_DIRECTORY_OFFICE_LIST.ID = PROVIDER_DIRECTORY_VW.id
group by
    PROVIDER_DIRECTORY_VW.id,
    PROVIDER_DIRECTORY_VW.networkid,
    PROVIDER_DIRECTORY_VW.clientid||PROVIDER_DIRECTORY_VW.tpaid||PROVIDER_DIRECTORY_VW.tpadivid||PROVIDER_DIRECTORY_VW.networkid,
    PROVIDER_DIRECTORY_VW.providerkey,
    providernbr,
    EMAILADDRESSTEXT,
    medicaidindicator,
    providerfullname, 
    providerFirstName,
    providerLastName,
    providerNamePartition,
    PRACTITIONERGENDERNAME,
    providerNPI,
    ProviderAddress.providerAddress, 
    boardcertification.boardcertificationJSON,
    LanguageName.LanguageNameJSON,
    accreditations.accreditationsJSON,
    providerAffiliations.providerAffiliationsJSON,
    PROVIDER_DIRECTORY_OFFICE_LIST.OFFICE_ID_CHANGE_IND,
    PROVIDER_DIRECTORY_VW.PROVIDERSUBTYPEDESC
order by
    PROVIDER_DIRECTORY_VW.id,
    PROVIDER_DIRECTORY_VW.networkid,
    PROVIDER_DIRECTORY_VW.providerkey,
    ProvDirJSONtxt;