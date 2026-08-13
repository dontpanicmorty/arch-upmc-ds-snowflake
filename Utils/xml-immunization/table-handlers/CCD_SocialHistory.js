const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);

  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Social History') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const socialHistoryEntryXpath =
      xpaths.entry +
      `[
          contains(
            ./hl7:observation/hl7:text/hl7:reference/@value, 
            '#socialHistory'
          )
        ]`;

    let entries = select(socialHistoryEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      const RootId = selectCSVValue(xpaths.obs.rootId, entry);
      const DocumentId = selectCSVValue(xpaths.obs.documentId, entry);
      const referenceValue = selectCSVValue(xpaths.obs.referenceValue, entry);
      const Status = selectCSVValue(xpaths.obs.statusCode, entry);
      const effectiveTime = selectCSVValue(xpaths.obs.effectiveTime, entry);

      let SocialHistoryCode;
      let SocialHistoryCodeSystem;
      let displayName;
      if (selectCSVValue(xpaths.obs.codeNullFlavor, entry) === 'OTH') {
        SocialHistoryCode = selectCSVValue(
          xpaths.obs.codeTranslationCode,
          entry
        );
        SocialHistoryCodeSystem = selectCSVValue(
          xpaths.obs.codeSystemTranslation,
          entry
        );
        displayName = selectCSVValue(
          xpaths.obs.displayNameTranslation,
          entry,
          500
        );
      } else {
        SocialHistoryCode = selectCSVValue(xpaths.obs.codeCode, entry);
        SocialHistoryCodeSystem = selectCSVValue(xpaths.obs.codeSystem, entry);
        displayName = selectCSVValue(xpaths.obs.displayName, entry, 500);
      }
      const CodeSystemName = null;
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
        SocialHistoryCode,
        SocialHistoryCodeSystem,
        CodeSystemName,
        displayName,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
