## SQL Server camelCase to Snowflake DDL converting

A few powershell scripts can help speed this process up. Lots of room for optimization, but also way better than manually editing

1. Extract your SQL DDLs into individual files (DBeaver is good for this) then convert to Snowflake equivalent using roboquery or equivalent
2. Modify top level path & schema in "camelToUpper.ps1" then run it
   "PlanTypeCode varchar(10) ," beceomes "\_PLAN_TYPE_CODE VARCHAR(10) ,"
3. Modify top level path & schema in "afterUpperCleanup.ps1" then run it
   "\_PLAN_TYPE_CODE VARCHAR(10) ," becomes "PLAN_TYPE_CODE VARCHAR(10) ," ..other formatting is also applied
4. Use notepad ++ (or write more powershell if you're up for it) to regex find and replace in all the relevant files using: (VARCHAR\(\d{2})\)
   -- replace the 2 inside the {} as 1, 2, 3, etc depending on how big your varchars are so you get "VARCHAR(10)" --> "VARCHAR"
