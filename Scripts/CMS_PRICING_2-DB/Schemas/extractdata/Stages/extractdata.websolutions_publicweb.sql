!set variable_substitution=true;
CREATE OR REPLACE STAGE EXTRACTDATA.WEBSOLUTIONS_PUBLICWEB
	storage_integration = WEBSOLUTIONS_CDN_INTEGRATION
	url = 'azure://&{websolutionsstorageaccount}.blob.core.windows.net/publicweb'
;
	
!set variable_substitution=false;