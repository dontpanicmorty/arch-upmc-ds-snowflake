const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Medications') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const medicatEntryXpath =
      xpaths.entry +
      `[
        contains(
          ./hl7:substanceAdministration/hl7:text/hl7:reference/@value, 
          'medi'
        )
      ]`;

    let entries = select(medicatEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const statusCode = selectCSVValue(xpaths.sa.statusCode, entry); //statusCode = MedStatus

      const RootId = selectCSVValue(xpaths.sa.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.sa.documentId, entry);
      const MedicationReferenceValue = selectCSVValue(
        xpaths.sa.referenceValue,
        entry
      );
      const MedicationStartDate = selectCSVValue(xpaths.sa.startDate, entry);
      const MedicationEndDate = selectCSVValue(xpaths.sa.endDate, entry);
      const Code = selectCSVValue(xpaths.sa.materialCode, entry);
      const CodeSystem = selectCSVValue(xpaths.sa.materialCodeSystem, entry);
      const DisplayName = selectCSVValue(
        xpaths.sa.materialDisplayName,
        entry,
        500
      );
      const RouteDisplayName = selectCSVValue(
        xpaths.sa.routeDisplayName,
        entry,
        500
      );
      const doseQuantity = selectCSVValue(xpaths.sa.doseQuantity, entry);
      const doseUnit = selectCSVValue(xpaths.sa.doseUnit, entry);
      const TimeValue = selectCSVValue(xpaths.sa.timeValue, entry);
      const UnitValue = selectCSVValue(xpaths.sa.unitValue, entry);
      const CodeSystemName = null; //place holder
      const MessageTypeId = null; //place holder

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        MedicationReferenceValue,
        MedicationStartDate,
        MedicationEndDate,
        Code,
        CodeSystem,
        CodeSystemName,
        DisplayName,
        RouteDisplayName,
        doseQuantity,
        doseUnit,
        TimeValue,
        UnitValue,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
