CREATE OR REPLACE VIEW MARKETING_PROSPECTS.PROSPECT_ADDRESS_SMARTY_SELECT_VW 
COMMENT = 'View to blob storage of all the Acxiom Smarty validated addresses'
AS 
SELECT $1::VARIANT AS JSON_DATA, 
$1:delivery_line_1::string as DELIVERY_LINE_1_SMARTY,
$1:delivery_line_2::STRING AS DELIVERY_LINE_2_SMARTY, 
$1:components:primary_number::STRING AS PRIMARY_NUMBER_SMARTY, 
$1:components:street_name::STRING AS STREET_NAME_SMARTY, 
$1:components:street_suffix::STRING AS STREET_SUFFIX_SMARTY, 
$1:components:secondary_designator::STRING AS SECONDARY_DESIGNATOR, 
$1:components:secondary_number::STRING AS SECONDARY_NBR, 
$1:components:default_city_name::STRING AS CITY_NAME_SMARTY, 
$1:components:state_abbreviation::STRING AS STATE_ABBREVIATION_SMARTY, 
$1:components:zipcode::STRING AS ZIP_CODE_SMARTY, 
$1:components:plus4_code::STRING AS ZIP_PLUS_4, 
$1:metadata:precision::STRING AS PRECISION, 
$1:components:street_predirection::STRING AS STREET_PREDIRECTION, 
$1:components:street_postdirection::STRING AS STREET_POSTDIRECTION,
$1:components:extra_secondary_number::string AS EXTRA_SECONDARY_NBR, 
$1:input_id::STRING AS ENTITY_REALID_PLACE_ID
        FROM @MARKETING_PROSPECTS.SNOWFLAKEDATA_MARKETING_PROSPECTS
            (
                FILE_FORMAT => MARKETING_PROSPECTS.PROSPECT_ADDRESS_FILE_FORMAT
                --,PATTERN => '*.json'
            )
;