const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  // cross apply XmlContent.nodes('//*:ClinicalDocument/*:component/*:structuredBody/*:component') x(y)
  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Immunizations') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const immunizEntryXpath =
      xpaths.entry +
      `[
        contains(
          ./hl7:substanceAdministration/hl7:text/hl7:reference/@value, 
          'immuniz'
        )
      ]`;

    // cross apply a(b)
    let entries = select(immunizEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const statusCode = selectCSVValue(xpaths.sa.statusCode, entry);

      const RootId = selectCSVValue(xpaths.sa.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.sa.documentId, entry);

      const ImmunizationReferenceValue = selectCSVValue(
        xpaths.sa.referenceValue,
        entry
      );
      const ImmunizationDate = selectCSVValue(
        xpaths.sa.administrationDate,
        entry
      );

      const Code = selectCSVValue(xpaths.sa.materialCode, entry);
      const CodeSystem = selectCSVValue(xpaths.sa.materialCodeSystem, entry);

      // Takes a bit more logic to populate this
      const nullFlavor = selectCSVValue(xpaths.sa.materialNullFlavor, entry);
      const DisplayName =
        nullFlavor === 'OTH' || nullFlavor === 'NI'
          ? selectCSVValue(xpaths.sa.materialText, entry)
          : selectCSVValue(xpaths.sa.materialDisplayName, entry, 500);

      const MoodCode = selectCSVValue(xpaths.sa.statusCode, entry);
      const MessageTypeId = null; //client wants all columns
      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        ImmunizationReferenceValue,
        ImmunizationDate,
        Code,
        CodeSystem,
        null /* codeSystemName */,
        DisplayName,
        MessageTypeId,
        MoodCode
      ]);
    }
  }

  return returnArray;
};
