CREATE OR REPLACE FUNCTION RAWDATA.FXN_GET_CLAIM_LINE_NBR_MC400(DATA_SOURCE_NAME VARCHAR, PROCEDURE_CODE VARCHAR, PROCEDURE_MODIFIER VARCHAR, SPECIFIC_DATE_OF_SERVICE VARCHAR)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
COMMENT ='Returns the claim_line_nbr for a given claim detail record'
AS
$$
const validDataSources = ['MC400Dnt','MC400Upm'];
let claimLineNbr = null;
// Validate the data source

if (!validDataSources.includes(DATA_SOURCE_NAME))
{
    throw 'Invalid DATA_SOURCE_NAME: '+DATA_SOURCE_NAME;
}

const procedureModifier = PROCEDURE_MODIFIER.trim();
if (!procedureModifier || procedureModifier === '')
{
    claimLineNbr = PROCEDURE_CODE.trim() + SPECIFIC_DATE_OF_SERVICE;
}
else 
{
    claimLineNbr = PROCEDURE_CODE.trim() + procedureModifier + SPECIFIC_DATE_OF_SERVICE;
};

return claimLineNbr;
$$
;