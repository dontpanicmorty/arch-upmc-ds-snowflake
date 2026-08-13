/*----------------------------------------------------------------------------------------------------------
 This is the master deployment procedure for the database. Only the items in this script will be 
 deployed to the target database.
 
 Connection options for deployment via SnowSQL:
 -f IDAP_Deployment.sql 
 --variable build_number="<your build number>" 
 --variable environment="<DEV, TST, PRD>" 
 -o log_level=debug 
 -o timing=false 
 -o header=false 
 -o echo=true 
 -o exit_on_error=true 
 -o output_file=IDAP_Deployment.log
 ----------------------------------------------------------------------------------------------------------*/
--***************************************************************************
--***** This sets the SnowSQL variables that are used for cross db queries
!set variable_substitution=true;
!load &{tokenFilePath}

--***************************************************************************
-- Create deployment shell database
CREATE OR REPLACE DATABASE &{sourceDB} 
DATA_RETENTION_TIME_IN_DAYS=0 
COMMENT='CLI CI/CD Deployment Compare Database for build.'
;
--***************************************************************************
--***** THE ORDER OF EXECUTION IS BASED OFF OF DATABASE DEPENDENCIES!! ******
--***************************************************************************
----------------------------------------------------------------------------------------------------------
-- Schemas
----------------------------------------------------------------------------------------------------------
!load ../DatabaseLevelObjects/Schemas/load.schema.sql;
!load ../DatabaseLevelObjects/Schemas/archive.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

--!load ../Schemas/DatabaseLevelObjects/<schemaname>.schema.sql;

----------------------------------------------------------------------------------------------------------
-- Stages  (These will need added in, just need to figure out how to update storage locations as part of build)
----------------------------------------------------------------------------------------------------------
-- None to Run
----------------------------------------------------------------------------------------------------------
-- File Formats
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- Sequences
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- Tables
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- FUNCTIONS
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- VIEWS
-- archive
!load ../Schemas/archive/views/archive.claimcodes_vw.sql;
!load ../Schemas/archive/views/archive.claimlines_vw.sql;
!load ../Schemas/archive/views/archive.claimprovidertypes_vw.sql;
!load ../Schemas/archive/views/archive.claims_vw.sql;
--load
!load ../Schemas/load/views/load.claimcodes_all_vw.sql;
!load ../Schemas/load/views/load.claimcodes_vw.sql;
!load ../Schemas/load/views/load.claimlines_all_vw.sql;
!load ../Schemas/load/views/load.claimlines_vw.sql;
!load ../Schemas/load/views/load.claimprovidertypes_all_vw.sql;
!load ../Schemas/load/views/load.claimprovidertypes_vw.sql;
!load ../Schemas/load/views/load.claims_all_vw.sql;
!load ../Schemas/load/views/load.claims_vw.sql;
!load ../Schemas/load/views/load.edm_exclude_claim_filter_vw.sql;
!load ../Schemas/load/views/load.edm_include_claim_filter_vw.sql;
!load ../Schemas/load/views/load.membercobpayers_vw.sql;
!load ../Schemas/load/views/load.memberplans_vw.sql;
!load ../Schemas/load/views/load.members_vw.sql;
!load ../Schemas/load/views/load.provideraddresses_vw.sql;
!load ../Schemas/load/views/load.providers_vw.sql;
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
----------------------------------------------------------------------------------------------------------
-- STORED PROCEDURES
----------------------------------------------------------------------------------------------------------
--<schemaname>
--<schemaname>
--<schemaname>
--<schemaname>
!set variable_substitution=false;
!exit