const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Plan of Treatment') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const planOfTreatEntryXpath =
      xpaths.entry +
      `[
          contains(
            ./hl7:observation/hl7:text/hl7:reference/@value, 
            'planof'
          )
        ]`;

    let entries = select(planOfTreatEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.obs.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.obs.documentId, entry);
      const referenceValue = selectCSVValue(xpaths.obs.referenceValue, entry);
      const Status = selectCSVValue(xpaths.obs.statusCode, entry);
      const effectiveTime = selectCSVValue(xpaths.obs.effectiveTime, entry);

      let PlanOfTreatmentCode;
      let PlanOfTreatmentCodeSystem;
      let PlanOfTreatmentDisplayName;
      if (selectCSVValue(xpaths.obs.codeNullFlavor, entry) === 'OTH') {
        PlanOfTreatmentCode = selectCSVValue(
          xpaths.obs.codeTranslationCode,
          entry
        );
        PlanOfTreatmentCodeSystem = selectCSVValue(
          xpaths.obs.codeSystemTranslation,
          entry
        );
        PlanOfTreatmentDisplayName = selectCSVValue(
          xpaths.obs.displayNameTranslation,
          entry,
          500
        );
      } else {
        PlanOfTreatmentCode = selectCSVValue(xpaths.obs.codeCode, entry);
        PlanOfTreatmentCodeSystem = selectCSVValue(
          xpaths.obs.codeSystem,
          entry
        );
        PlanOfTreatmentDisplayName = selectCSVValue(
          xpaths.obs.displayName,
          entry,
          500
        );
      }
      const PlanOfTreatmentCodeSystemName = null;
      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        referenceValue,
        Status,
        effectiveTime,
        PlanOfTreatmentCode,
        PlanOfTreatmentCodeSystem,
        PlanOfTreatmentCodeSystemName,
        PlanOfTreatmentDisplayName,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
