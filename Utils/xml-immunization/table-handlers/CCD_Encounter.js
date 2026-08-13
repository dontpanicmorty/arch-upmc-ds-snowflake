const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  // cross apply XmlContent.nodes('//*:ClinicalDocument/*:component/*:structuredBody/*:component') x(y)
  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Encounters') continue; // no-op, don't want these

    // cross apply a(b)
    let entries = select(xpaths.entry, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.enc.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.enc.documentId, entry);

      let encounterCode, CodeSystem;
      if (selectCSVValue(xpaths.enc.codeNullFlavor, entry) === 'OTH') {
        CodeSystem = selectCSVValue(xpaths.enc.codeTranslationCode, entry);
        encounterCode = selectCSVValue(
          xpaths.enc.codeTranslationCodeSystem,
          entry
        );
      } else {
        CodeSystem = selectCSVValue(xpaths.enc.codeCode, entry);
        encounterCode = selectCSVValue(xpaths.enc.codeSystem, entry);
      }

      const encounterCodeDisplayName = selectCSVValue(
        xpaths.enc.displayName,
        entry
      );
      const encounterReferenceValue = selectCSVValue(
        xpaths.enc.referenceValue,
        entry
      );
      const EncounterDate = selectCSVValue(xpaths.enc.encounterDate, entry);

      const RenderingNPI = selectCSVValue(xpaths.enc.renderingNPI, entry);
      const RenderingName = selectCSVValue(xpaths.enc.renderingName, entry);
      const MessageTypeId = null; //client wants all columns
      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        encounterCode,
        CodeSystem,
        null /* codeSystemName */,
        encounterCodeDisplayName,
        encounterReferenceValue,
        EncounterDate,
        RenderingNPI,
        RenderingName,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
