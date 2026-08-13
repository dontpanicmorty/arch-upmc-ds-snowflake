const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Vital Signs') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const vitalsEntryXpath =
      xpaths.entry +
      `[
          contains(
            ./hl7:organizer/hl7:component/hl7:observation/hl7:text/hl7:reference/@value, 
            'vital'
          )
        ]`;

    let entries = select(vitalsEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.org.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.org.documentId, entry);

      const ObservationCode = selectCSVValue(xpaths.org.observationCode, entry);
      const CodeSystem = selectCSVValue(
        xpaths.org.observationCodeSystem,
        entry
      );
      const ObservationDisplayName = selectCSVValue(
        xpaths.org.observationDisplayName,
        entry,
        500
      );
      const VitalsReferenceValue = selectCSVValue(
        xpaths.org.observationReferenceValue,
        entry
      );
      const ResultStatus = selectCSVValue(
        xpaths.org.observationStatusCode,
        entry
      );
      const effectiveTime = selectCSVValue(
        xpaths.org.observationEffectiveTime,
        entry
      );
      const ResultValue = selectCSVValue(
        xpaths.org.observationValueValue,
        entry
      );
      const ResultUnits = selectCSVValue(xpaths.org.observationUnit, entry);
      const codeSystemName = null;
      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        ObservationCode,
        CodeSystem,
        codeSystemName,
        ObservationDisplayName,
        VitalsReferenceValue,
        ResultStatus,
        effectiveTime,
        ResultValue,
        ResultUnits,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
