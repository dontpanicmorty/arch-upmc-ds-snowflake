const {select, selectCSVValue, xpaths} = require('../src/utils.js');

module.exports.handler = function (xml) {
  const returnArray = [];

  // top-level things
  let MMI = selectCSVValue(xpaths.mmi, xml);
  let SummaryId = selectCSVValue(xpaths.summary, xml);
  //THIS ONE USES BOTH OBS AND PROC HL7- sometimes the observation is checked first for null and sometimes the procedure
  //is checked first for null.  Use caution to determine which exact hl7 data is used from observations and procedures
  //this needs logic for almost every item
  for (const component of select(xpaths.component, xml)) {
    const entryTitle = selectCSVValue(xpaths.componentTitle, component);
    if (entryTitle !== 'Procedures') continue; // no-op, don't want these

    // Append the `WHERE` restriction from the query to save us some cycles
    const procedureEntryXpath =
      xpaths.entry +
      `[
        contains(
          ./hl7:procedure/hl7:code/hl7:originalText/hl7:reference/@value, 
          '#proc') || 
        contains(./hl7:observation/hl7:code/hl7:originalText/hl7:reference/@value,'#proc')
      ]`;
    //console.log('***PAM  ' + procedureEntryXpath);
    let entries = select(procedureEntryXpath, component);
    if (!Array.isArray(entries)) entries = [entries]; // because it doesn't always return as an array if it's 1-length
    for (const entry of entries) {
      let RootId = selectCSVValue(xpaths.obs.rootId, entry); //obs first
      if (!RootId) RootId = selectCSVValue(xpaths.proc.rootId, entry);

      let DocumentId = selectCSVValue(xpaths.obs.documentId, entry); //obs first
      if (!DocumentId)
        DocumentId = selectCSVValue(xpaths.proc.documentId, entry);

      let ProcedureClassCode = selectCSVValue(xpaths.proc.classCode, entry); //procedure first
      if (!ProcedureClassCode)
        ProcedureClassCode = selectCSVValue(xpaths.obs.classCode, entry);

      let ProcedureObsCode = selectCSVValue(xpaths.proc.codeCode, entry); //procedure first
      if (!ProcedureObsCode)
        ProcedureObsCode = selectCSVValue(xpaths.obs.codeCode, entry);

      let ProcedureObsCodeSystem = selectCSVValue(xpaths.obs.codeSystem, entry); //obs first
      if (!ProcedureObsCodeSystem)
        ProcedureObsCodeSystem = selectCSVValue(xpaths.proc.codeSystem, entry);

      let ProcedureReferenceValue = selectCSVValue(
        xpaths.proc.originalTextReferenceValue,
        entry
      ); //procedure first
      if (!ProcedureReferenceValue)
        ProcedureReferenceValue = selectCSVValue(
          xpaths.obs.originalTextReferenceValue,
          entry
        );

      let ProcedureDisplayName = selectCSVValue(
        xpaths.proc.displayName,
        entry,
        500
      ); //procedure first
      if (!ProcedureDisplayName)
        ProcedureDisplayName = selectCSVValue(
          xpaths.obs.displayName,
          entry,
          500
        );

      let ProcedureDate = selectCSVValue(xpaths.proc.effectiveTime, entry); //procedure first
      if (!ProcedureDate)
        ProcedureDate = selectCSVValue(xpaths.obs.effectiveTime, entry);

      let ProcedureStatus = selectCSVValue(xpaths.proc.statusCode, entry); //procedure first
      if (!ProcedureStatus)
        ProcedureStatus = selectCSVValue(xpaths.obs.statusCode, entry);

      let AssignedPersonNPI = selectCSVValue(xpaths.proc.assignedEntity, entry); //procedure first
      if (!AssignedPersonNPI)
        AssignedPersonNPI = selectCSVValue(xpaths.obs.assignedEntity, entry);

      let AssignedPerson = selectCSVValue(xpaths.proc.assignedPerson, entry); //procedure first
      if (!AssignedPerson)
        AssignedPerson = selectCSVValue(xpaths.obs.assignedPerson, entry);

      const MessageTypeId = null;

      // Colums in original order
      returnArray.push([
        MMI,
        SummaryId,
        RootId,
        DocumentId,
        entryTitle,
        ProcedureClassCode,
        ProcedureObsCode,
        ProcedureObsCodeSystem,
        ProcedureReferenceValue,
        ProcedureDisplayName,
        ProcedureDate,
        ProcedureStatus,
        AssignedPersonNPI,
        AssignedPerson,
        MessageTypeId
      ]);
    }
  }

  return returnArray;
};
