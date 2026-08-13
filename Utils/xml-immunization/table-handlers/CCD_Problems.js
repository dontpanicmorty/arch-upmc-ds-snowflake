const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Problems') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const probEntryXpath =
      xpaths.entry +
      `[
        contains(
          ./hl7:act/hl7:entryRelationship/hl7:observation/hl7:text/hl7:reference/@value, 
          'prob'
        )
      ]`;

    let entries = select(probEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.er.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.er.documentId, entry);

      const ProblemReferenceValue = selectCSVValue(
        xpaths.er.referenceValue,
        entry
      );
      const OnsetDate = selectCSVValue(xpaths.er.onsetDate, entry);
      const ResolutionDate = selectCSVValue(xpaths.er.resolutionDate, entry);

      // Takes a bit more logic to populate this
      let Code;
      let CodeSystem;
      let DisplayName;
      const nullFlavor = selectCSVValue(xpaths.er.codeNullFlavor, entry);
      if (nullFlavor === 'OTH') {
        Code = selectCSVValue(xpaths.er.codeTranslationCode, entry);
        CodeSytem = selectCSVValue(xpaths.er.codeTranslationSystem, entry);
        DisplayName = selectCSVValue(
          xpaths.er.displayNameTranslation,
          entry,
          500
        );
      } else {
        Code = selectCSVValue(xpaths.er.codeCode, entry);
        CodeSytem = selectCSVValue(xpaths.er.codeSystem, entry);
        DisplayName = selectCSVValue(xpaths.er.displayName, entry, 500);
      }
      const codeSystemName = null;
      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        ProblemReferenceValue,
        OnsetDate,
        ResolutionDate,
        Code,
        CodeSystem,
        codeSystemName,
        DisplayName,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
