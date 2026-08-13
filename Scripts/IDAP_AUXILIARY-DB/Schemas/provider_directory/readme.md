Taking notes in here so they don't get lost

1. Note that we need to export files from SQL that are delimited by ~ because the data has pipes
2. Initial deployment of this schema and associated objects assumes that we didn't want or need to persist incoming data as tables
   - Testing indicated we could shave as much as 24 mins from the providers JSON build if we opted for tables instead
   - thought process at the time was that we may never want tables in Snowflake for this if/when ODS is here the views could be repoitned there
3. Renamed things in tables persisting in Snowflake to following NAMING_CONVENTIONS. Anything referencing staging files is still camelCase
4. Logic implemented in views & sprocs as of 1/20/2023 was from Rohit Mande's POC work in mid 2022 and needs validated/tweaked for any changes since then

   - scope of initial setup here is to wire up an end to end example to be polished then repeated as necessary for other Cosmos targets
     https://dev.azure.com/ITPayerApplications/Data%20Services/_workitems/edit/389760

5. ADF stuff is in: POC_testing_connections branch --> "testing" folder -> PD_Pipelines -> loadFindCare
6. ADF doesn't make it easy to hard delete so for now we're going to Upsert a dummy document with netowrkId / id / deleteTimestamp.

- if we need to physically remove those at some point from the DB, a Cosmos TTL or some other process will need to be configured

6.  Process Flow
    a. Data is loaded to blob files / if we use tables then maybe another step is needed to copy, for now it's not
    b. on-prem .sh script calls ADF via REST to start the back half of the pipeline
    c. ADF calls master sproc which then calls one for each of these:

    1. reload the \_PREV table
    2. load office_list
    3. load the new \_JSON table
    4. validate tables

       - check for dupes, not sure what else we need yet?

    5. clear out the target blob folder
    6. unload new data to outbound/providers/
    7. unload deletes to outbount/providers/deletes\*
       d. ADF copies /providers/ into Cosmos
       e. success or failure email

TODO:

- greg & bax are also checking to see if we can write straight to the tables which would simplify a few steps along the way
- expand validation beyond dupe checks
- if we need to hard delete from OfficeList, that's not being done yet

ToDo list of tables used by IICS today:
Database.Table
ProviderDirectory.ProviderDirectory_OfficeList_Cigna
ProviderDirectory.ProviderDirectory_Cigna
ReferenceData.MemberNetwork_Network_Templates
ReferenceData.ProvDir_ServiceAreaSubProduct
ReferenceData.ProvDir_ServiceAreaProduct
ReferenceData.Provider_Network_Crosswalk
ReferenceData.Provdir_BehavioralHealthVendor_Crosswalk

Done
ProviderDirectory.ProviderAffiliations
ProviderDirectory.ProvidersContract
ProviderDirectory.ProviderDirectory
ProviderDirectory.ProviderDirectory_OfficeList
ProviderDirectory.MemberNetworks
