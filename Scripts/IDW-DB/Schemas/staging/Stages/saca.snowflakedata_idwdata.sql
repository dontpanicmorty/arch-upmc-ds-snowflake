CREATE OR REPLACE STAGE SACA.SNOWFLAKEDATA_IDWDATA
	storage_integration = SNOWFLAKEDATA_INTEGRATION
	url = 'azure://snowflakedataprd.blob.core.windows.net/idwdata/saca'
	;