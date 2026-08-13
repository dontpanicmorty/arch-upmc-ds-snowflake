const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.title, component);
    const patientEntryTitle = entryTitle.toString();
    //entryTitle has 2 values Patient Summarization (C-CDA 2.1 CCD) & Patient Summarization Differential
    //only want these titles so do a substring check
    if (patientEntryTitle.substring(0, 21) !== 'Patient Summarization')
      continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const patientEntryXpath =
      xpaths.entry +
      `[
          contains(
            //hl7:ClinicalDocument/hl7:title, 
            'Patient Summari'
          )
        ]`;
    let entries = select(patientEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const FirstName = selectCSVValue(xpaths.pr.firstName, entry);
      const LastName = selectCSVValue(xpaths.pr.lastName, entry);
      const BirthDate = selectCSVValue(xpaths.pr.birthDate, entry);
      const GenderCode = selectCSVValue(xpaths.pr.genderCode, entry);
      const GenderCodeSystem = selectCSVValue(
        xpaths.pr.genderCodeSystem,
        entry
      );
      const MaritalStatusCode = selectCSVValue(
        xpaths.pr.maritalStatusCode,
        entry
      );
      const MaritalStatusCodeSystem = selectCSVValue(
        xpaths.pr.maritalStatusCodeSystem,
        entry
      );
      const RaceCode = selectCSVValue(xpaths.pr.raceCode, entry);
      const RaceCodeSystem = selectCSVValue(xpaths.pr.raceCodeSystem, entry);
      const RaceDisplay = selectCSVValue(xpaths.pr.raceDisplay, entry);
      const EthnicGroupCode = selectCSVValue(xpaths.pr.ethnicGroupCode, entry);
      const EthnicGroupCodeSystem = selectCSVValue(
        xpaths.pr.ethnicGroupCodeSystem,
        entry
      );
      const EthnicDisplay = selectCSVValue(xpaths.pr.ethnicDisplay, entry);
      const LanguageCode = selectCSVValue(xpaths.pr.languageCode, entry);
      const ReligiousAffiliationCode = selectCSVValue(
        xpaths.pr.religiousAffiliationCode,
        entry
      );
      const ReligiousAffiliationCodeSystem = selectCSVValue(
        xpaths.pr.religiousAffiliationCodeSystem,
        entry
      );
      const StreetAddress = selectCSVValue(xpaths.pr.streetAddress, entry);
      const City = selectCSVValue(xpaths.pr.city, entry);
      const State = selectCSVValue(xpaths.pr.state, entry);
      const PostalCode = selectCSVValue(xpaths.pr.postalCode, entry);
      const Country = selectCSVValue(xpaths.pr.country, entry);
      const PhoneType = selectCSVValue(xpaths.pr.phoneType, entry);
      const PhoneNumber = selectCSVValue(xpaths.pr.phoneNumber, entry);
      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        entryTitle,
        FirstName,
        LastName,
        BirthDate,
        GenderCode,
        GenderCodeSystem,
        MaritalStatusCode,
        MaritalStatusCodeSystem,
        RaceCode,
        RaceCodeSystem,
        RaceDisplay,
        EthnicGroupCode,
        EthnicGroupCodeSystem,
        EthnicDisplay,
        LanguageCode,
        ReligiousAffiliationCode,
        ReligiousAffiliationCodeSystem,
        StreetAddress,
        City,
        State,
        PostalCode,
        Country,
        PhoneType,
        PhoneNumber,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
