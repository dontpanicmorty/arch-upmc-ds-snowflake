--Creates MD5 Hash for concatenation of input array, with ~ as separator
CREATE OR REPLACE FUNCTION UTIL.FXN_ARRAY_HASH(INPUT VARIANT)
RETURNS VARCHAR
AS
$$
MD5(REPLACE(REPLACE(TO_CHAR(INPUT),'undefined,','"null",'),',undefined',',"null"'))
$$
;