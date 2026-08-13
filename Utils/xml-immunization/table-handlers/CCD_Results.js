const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Results') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const resultsEntryXpath =
      xpaths.entry +
      `[
        contains(
          ./hl7:organizer/hl7:component/hl7:observation/hl7:text/hl7:reference/@value, 
          'results'
        )
      ]`;

    let entries = select(resultsEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.org.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.org.documentId, entry);

      const OrderCode = selectCSVValue(xpaths.org.codeCode, entry);
      const OrderCodeSystem = selectCSVValue(xpaths.org.codeSystem, entry);

      // Takes a bit more logic to populate this
      let OrderDisplayName = selectCSVValue(xpaths.org.displayName, entry, 500);
      if (!OrderDisplayName)
        OrderDisplayName = selectCSVValue(xpaths.org.originalText, entry, 500);

      const OrderStatus = selectCSVValue(xpaths.org.statusCode, entry);
      const ResultCode = selectCSVValue(xpaths.org.observationCode, entry);
      const ResultCodeSystem = selectCSVValue(
        xpaths.org.observationCodeSystem,
        entry
      );
      const ResultDisplayName = selectCSVValue(
        xpaths.org.observationDisplayName,
        entry,
        500
      );
      const ResultReferenceValue = selectCSVValue(
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
      let ResultValue = selectCSVValue(xpaths.org.observationValueValue, entry);
      if (!ResultValue)
        ResultValue = selectCSVValue(xpaths.org.observationValue, entry);
      const ResultUnits = selectCSVValue(xpaths.org.observationUnit, entry);
      const InterpretationCode = selectCSVValue(
        xpaths.org.observationInterpretationCode,
        entry
      );
      const ObservationRange = selectCSVValue(
        xpaths.org.observationRange,
        entry
      );
      const ObsLowValue = selectCSVValue(xpaths.org.observationRangeLow, entry);
      const ObsHighValue = selectCSVValue(
        xpaths.org.observationRangeHigh,
        entry
      );

      const OrderCodeSystemName = null;
      const ResultCodeSystemName = null;
      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        OrderCode,
        OrderCodeSystem,
        OrderCodeSystemName,
        OrderDisplayName,
        OrderStatus,
        ResultCode,
        ResultCodeSystem,
        ResultCodeSystemName,
        ResultDisplayName,
        ResultReferenceValue,
        ResultStatus,
        effectiveTime,
        ResultValue,
        ResultUnits,
        InterpretationCode,
        ObservationRange,
        ObsLowValue,
        ObsHighValue,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
