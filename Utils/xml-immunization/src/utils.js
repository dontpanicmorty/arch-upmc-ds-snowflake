const fs = require('fs');
const path = require('path');

// Fonto version used instead, but this one kept for reference
// const xpath = require('xpath');
const {evaluateXPath} = require('fontoxpath');
const {DOMParser} = require('@xmldom/xmldom');

const {DefaultAzureCredential} = require('@azure/identity');
const {BlobServiceClient} = require('@azure/storage-blob');
const {managedIdentity} = require('./config.js');

// Init parser
const parser = new DOMParser();

// The base XPath for selecting certain objects. The equivalent of most of the
// `cross apply` calls.
const namespaceLookup = {hl7: 'urn:hl7-org:v3'};
const select = (xpath, node) =>
  evaluateXPath(xpath, node, null, null, null, {
    namespaceResolver: (ns) => namespaceLookup[ns]
  });

// The XPath you should be using when you're trying to select something to be
// written to a CSV. Proxies to `select` but takes the first value found and
// substrings it. The equivalent of what's used for most view columns.
function selectCSVValue(xpath, node, maxLength = 100) {
  const res = select(xpath, node);

  // found nothing, return nothing in an easier-to-handle way
  if (!res || (Array.isArray(res) && res.length === 0)) return null;

  let el = Array.isArray(res) ? res[0] : res;

  let value;
  // Attributes returned by xpath
  if (res.constructor.name === 'Attr') value = res[0].value;
  // Elements
  else if (res.constructor.name === 'Element') {
    value = res.textContent;
  }
  // Raw strings
  else if (res.constructor.name === 'String') {
    value = res;
  } else console.log(`unexpected node type found: ${res.constructor.name}`);

  // substrings are because there are in-DB JOINs on max-length varchar cols
  return value.substring(0, maxLength);
}

async function* getFiles(dir) {
  const dirents = await fs.promises.readdir(dir, {withFileTypes: true});
  for (const dirent of dirents) {
    const res = path.resolve(dir, dirent.name);
    if (dirent.isDirectory()) {
      yield* getFiles(res);
    } else {
      yield res;
    }
  }
}

function getBlobClient(account, container) {
  const serviceClient = new BlobServiceClient(
    `https://${account}.blob.core.windows.net`,
    new DefaultAzureCredential({
      managedIdentityClientId: managedIdentity
    })
  );

  return serviceClient.getContainerClient(container);
}

// Only works reliably for blob streams
async function streamToText(readable) {
  readable.setEncoding('utf8');
  let data = '';
  for await (const chunk of readable) {
    data += chunk;
  }
  return data;
}

const xpaths = {
  // top-level elements
  mmi: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:id[@root="2.16.840.1.113883.3.552.1.3.11.100.100"]/@extension)[1]`,
  summary: `(//hl7:ClinicalDocument/hl7:id/@extension)[1]`,

  // cross apply x(y)
  component: `//hl7:ClinicalDocument/hl7:component/hl7:structuredBody/hl7:component`,

  // nodes under hl7:component
  componentTitle: `(./hl7:section/hl7:title)[1]`, //entryTitle for majority

  // cross apply a(b)
  entry: `(.//hl7:section/hl7:entry)`,
  title: `(//hl7:ClinicalDocument/hl7:title)[1]`, //entryTitle for patientRole

  // substanceAdministration nodes under hl7:entry
  sa: {
    rootId: `(./hl7:substanceAdministration/hl7:id/@root)[1]`,
    documentId: `(./hl7:substanceAdministration/hl7:id/@extension)[1]`,
    statusCode: `(./hl7:substanceAdministration/hl7:statusCode/@code)[1]`,
    moodCode: `(./hl7:substanceAdministration/@moodCode)[1]`,
    referenceValue: `(./hl7:substanceAdministration/hl7:text/hl7:reference/@value)[1]`,
    administrationDate: `(./hl7:substanceAdministration/hl7:effectiveTime//@value)[1]`,
    materialCode: `(./hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code/@code)[1]`,
    materialCodeSystem: `(./hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code/@codeSystem)[1]`,
    materialNullFlavor: `(./hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code/@nullFlavor)[1]`,
    materialText: `(./hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code/hl7:originalText)[1]`,
    materialDisplayName: `(./hl7:substanceAdministration/hl7:consumable/hl7:manufacturedProduct/hl7:manufacturedMaterial/hl7:code/@displayName)[1]`,
    startDate: `(./hl7:substanceAdministration/hl7:effectiveTime/hl7:low/@value)[1]`,
    endDate: `(./hl7:substanceAdministration/hl7:effectiveTime/hl7:high/@value)[1]`,
    routeDisplayName: `(./hl7:substanceAdministration/hl7:routeCode/@displayName)[1]`,
    doseQuantity: `(./hl7:substanceAdministration/hl7:doseQuantity/@value)[1]`,
    doseUnit: `(./hl7:substanceAdministration/hl7:doseQuantity/@unit)[1] `,
    timeValue: `(./hl7:substanceAdministration/hl7:effectiveTime/hl7:period/@value)[1]`,
    unitValue: `(./hl7:substanceAdministration/hl7:effectiveTime/hl7:period/@unit)[1] `
  },

  // encounter nodes under hl7:entry
  enc: {
    rootId: `(./hl7:encounter/hl7:id/@root)[1]`,
    documentId: `(./hl7:encounter/hl7:id/@extension)[1]`,
    codeNullFlavor: `(./hl7:encounter/hl7:code/@nullFlavor)[1]`,
    codeTranslationCode: `(./hl7:encounter/hl7:code/hl7:translation/@code)[1]`,
    codeCode: `(./hl7:encounter/hl7:code/@code)[1]`,
    codeTranslationCodeSystem: `(./hl7:encounter/hl7:code/hl7:translation/@codeSystem)[1]`,
    codeSystem: `(./hl7:encounter/hl7:code/@codeSystem)[1]`,
    displayName: `(./hl7:encounter/hl7:code/@displayName)[1]`,
    referenceValue: `(./hl7:encounter/hl7:code/hl7:originalText/hl7:reference/@value)[1]`,
    // variant on the case statement in the original that selects the first
    // valid value from these two
    encounterDate: `(./hl7:encounter/hl7:effectiveTime/@value, ./hl7:encounter/hl7:effectiveTime/hl7:low/@value)[1]`,

    renderingNPI: `(./hl7:encounter/hl7:performer/hl7:assignedEntity/hl7:id/@extension)[1]`,
    // weird text stuff makes it look like it currently is in the DB
    renderingName: `string-join((./hl7:encounter/hl7:performer/hl7:assignedEntity/hl7:assignedPerson/hl7:name)[1]/hl7:*//text())`
  },
  // more specific ClinicalDocument nodes for patientRole under hl7:entry
  pr: {
    firstName: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:name/hl7:given)[1]`,
    lastName: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:name/hl7:family)[1]`,
    birthDate: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:birthTime/@value)[1]`,
    genderCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@code)[1]`,
    genderCodeSystem: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:administrativeGenderCode/@codeSystem)[1]`,
    maritalStatusCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:maritalStatusCode/@code)[1]`,
    maritalStatusCodeSystem: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:maritalStatusCode/@codeSystem)[1]`,
    raceCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:raceCode/@code)[1]`,
    raceCodeSystem: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:raceCode/@codeSystem)[1]`,
    raceDisplay: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:raceCode/@displayName)[1]`,
    ethnicGroupCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:ethnicGroupCode/@code)[1]`,
    ethnicGroupCodeSystem: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:ethnicGroupCode/@codeSystem)[1]`,
    ethnicDisplay: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:ethnicGroupCode/@displayName)[1]`,
    languageCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:languageCommunication/hl7:languageCode/@code)[1]`,
    religiousAffiliationCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:religiousAffiliationCode/@code)[1]`,
    religiousAffiliationCodeSystem: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:patient/hl7:religiousAffiliationCode/@codeSystem)[1]`,
    streetAddress: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:streetAddressLine)[1]`,
    city: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:city)[1]`,
    state: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:state)[1]`,
    postalCode: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:postalCode)[1]`,
    country: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:addr/hl7:country)[1]`,
    phoneType: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:telecom/@use)[1]`,
    phoneNumber: `(//hl7:ClinicalDocument/hl7:recordTarget/hl7:patientRole/hl7:telecom/@value)[1]`
  },
  //observation nodes under hl7:entry
  obs: {
    rootId: `(./hl7:observation/hl7:id/@root)[1]`,
    documentId: `(./hl7:observation/hl7:id/@extension)[1]`,
    referenceValue: `(./hl7:observation/hl7:text/hl7:reference/@value)[1]`,
    statusCode: `(./hl7:observation/hl7:statusCode/@code)[1]`,
    effectiveTime: `(./hl7:observation/hl7:effectiveTime/@value)[1]`,
    codeNullFlavor: `(./hl7:observation/hl7:code/@nullFlavor)[1]`,
    codeTranslationCode: `(./hl7:observation/hl7:code/hl7:translation/@code)[1]`,
    codeSystemTranslation: `(./hl7:observation/hl7:code/hl7:translation/@codeSystem)[1]`,
    displayNameTranslation: `(./hl7:observation/hl7:code/hl7:translation/@displayName)[1]`,
    codeCode: `(./hl7:observation/hl7:code/@code)[1]`,
    codeSystem: `(./hl7:observation/hl7:code/@codeSystem)[1]`,
    displayName: `(./hl7:observation/hl7:code/@displayName)[1]`,
    classCode: `(./hl7:observation/@classCode)[1]`,
    originalTextReferenceValue: `(./hl7:observation/hl7:code/hl7:originalText/hl7:reference/@value)[1]`,
    assignedEntity: `(./hl7:observation/hl7:performer/hl7:assignedEntity/hl7:id/@extension)[1]`,
    assignedPerson: `(./hl7:observation/hl7:performer/hl7:assignedEntity/hl7:assignedPerson/hl7:name)[1]`
  },
  //entryRelationship nodes under hl7:entry
  er: {
    rootId: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:id/@root)[1]`,
    documentId: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:id/@extension)[1]`,
    referenceValue: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:text/hl7:reference/@value)[1]`,
    onsetDate: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:effectiveTime/hl7:low/@value)[1]`,
    resolutionDate: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:effectiveTime/hl7:high/@value)[1]`,
    codeNullFlavor: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/@nullFlavor)[1]`,
    codeTranslationCode: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/hl7:translation/@code)[1]`,
    codeTranslationSystem: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/hl7:translation/@codeSystem)[1]`,
    displayNameTranslation: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/hl7:translation/@displayName)[1]`,
    codeCode: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/@code)[1]`,
    codeSystem: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/@codeSystem)[1]`,
    displayName: `(./hl7:act/hl7:entryRelationship/hl7:observation/hl7:value/@displayName)[1]`
  },
  //procedure nodes under hl7:entry
  proc: {
    rootId: `(./hl7:procedure/hl7:id/@root)[1]`,
    documentId: `(./hl7:procedure/hl7:id/@extension)[1]`,
    classCode: `(./hl7:procedure/@classCode)[1]`,
    codeCode: `(./hl7:procedure/hl7:code/@code)[1]`,
    codeSystem: `(./hl7:procedure/hl7:code/@codeSystem)[1]`,
    originalTextReferenceValue: `(./hl7:procedure/hl7:code/hl7:originalText/hl7:reference/@value)[1]`,
    displayName: `(./hl7:procedure/hl7:code/@displayName)[1]`,
    effectiveTime: `(./hl7:procedure/hl7:effectiveTime/@value)[1]`,
    statusCode: `(./hl7:procedure/hl7:statusCode/@code)[1]`,
    assignedEntity: `(./hl7:procedure/hl7:performer/hl7:assignedEntity/hl7:id/@extension)[1]`,
    assignedPerson: `(./hl7:procedure/hl7:performer/hl7:assignedEntity/hl7:assignedPerson/hl7:name)[1]`
  },
  //organizer nodes under hl7:entry
  org: {
    rootId: `(./hl7:organizer/hl7:component/hl7:observation/hl7:id/@root)[1]`,
    documentId: `(./hl7:organizer/hl7:component/hl7:observation/hl7:id/@extension)[1]`,
    codeCode: `(./hl7:organizer/hl7:code/@code)[1]`,
    codeSystem: `(./hl7:organizer/hl7:code/@codeSystem)[1]`,
    statusCode: `(./hl7:organizer/hl7:statusCode/@code)[1]`,
    displayName: `(./hl7:organizer/hl7:code/@displayName)[1]`,
    originalText: `(./hl7:organizer/hl7:code/hl7:originalText)[1]`,
    observationCode: `(./hl7:organizer/hl7:component/hl7:observation/hl7:code/@code)[1]`,
    observationCodeSystem: `(./hl7:organizer/hl7:component/hl7:observation/hl7:code/@codeSystem)[1]`,
    observationDisplayName: `(./hl7:organizer/hl7:component/hl7:observation/hl7:code/@displayName)[1]`,
    observationReferenceValue: `(./hl7:organizer/hl7:component/hl7:observation/hl7:text/hl7:reference/@value)[1]`,
    observationStatusCode: `(./hl7:organizer/hl7:component/hl7:observation/hl7:statusCode/@code)[1]`,
    observationEffectiveTime: `(./hl7:organizer/hl7:component/hl7:observation/hl7:effectiveTime/@value)[1]`,
    observationValueValue: `(./hl7:organizer/hl7:component/hl7:observation/hl7:value/@value)[1]`,
    observationValue: `(./hl7:organizer/hl7:component/hl7:observation/hl7:value)[1]`,
    observationUnit: `(./hl7:organizer/hl7:component/hl7:observation/hl7:value/@unit)[1]`,
    observationInterpretationCode: `(./hl7:organizer/hl7:component/hl7:observation/hl7:interpretationCode/@code)[1]`,
    observationRange: `(./hl7:organizer/hl7:component/hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:text)[1]`,
    observationRangeLow: `(./hl7:organizer/hl7:component/hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:value/hl7:low/@value)[1]`,
    observationRangeHigh: `(./hl7:organizer/hl7:component/hl7:observation/hl7:referenceRange/hl7:observationRange/hl7:value/hl7:high/@value)[1]`
  }
};

// Parent folder we're writing to for this batch
const timestampFolder = new Date().getTime().toString();
const outputFolder = path.join('output', timestampFolder);

module.exports = {
  parser,
  select,
  selectCSVValue,
  xpaths,
  getFiles,
  getBlobClient,
  outputFolder,
  streamToText
};
