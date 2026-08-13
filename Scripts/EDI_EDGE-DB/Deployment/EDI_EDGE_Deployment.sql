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
!load ../DatabaseLevelObjects/Schemas/gpsupport.schema.sql;

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
--gpsupport
!load ../Schemas/gpsupport/views/gpsupport.aca_pharmacy_submitted_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.aca_pharmacy_submitted_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.aca_pharmacy_submitted_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.aca_pharmacystatus_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.aca_pharmacystatus_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_filtered_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_filtered_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_filtered_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_interim_bills_submitted_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_interim_bills_submitted_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_interim_bills_submitted_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_status_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_status_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_status_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_submitted_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_submitted_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaims_submitted_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaimsdetail_submitted_2022_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaimsdetail_submitted_2023_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.acaclaimsdetail_submitted_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.invalid_cpt_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.invalid_diags_vw.sql;
!load ../Schemas/gpsupport/views/gpsupport.invalid_modifiers_vw.sql;
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