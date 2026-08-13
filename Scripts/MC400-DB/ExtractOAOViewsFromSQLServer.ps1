#Will need to run the below command if you do not have sqlServer installed into powershell already
#Install-Module SQLServer -Scope CurrentUser
$source_select = @"
select
views.[name] AS ViewName
,sql_modules.[definition]
,
--SUBSTRING(sql_modules.[definition], PATINDEX('%[A-Za-z]%', sql_modules.[definition]), LEN(sql_modules.[definition])) -- remove all leading characters that are not Letters
trim(sql_modules.[definition]) AS SnowflakeSQL

from sys.views
	join sys.objects
		on (objects.object_id = views.object_id)
	join sys.schemas
		on (schemas.schema_id = objects.schema_id)
	join sys.sql_modules
		on (sql_modules.object_id = views.object_id)
where schemas.[name] = 'dbo'
order by ViewName
"@

$snowflakeSchemaName = "DWDNV_NONCLAIMS"
$snowflakeCreateStatement = "CREATE OR REPLACE VIEW " + $snowflakeSchemaName + "."

$source_SqlServerInstance = 'upmcdw.upmchp.com'
$source_databaseName = 'dwdnv_nonclaims'

$targetDirectory = 'C:\Projects\DS-Snowflake\Scripts\DBR-MC400-DB\Schemas'

$objectList = Invoke-SqlCmd -ServerInstance $source_SqlServerInstance -Database $source_databaseName -Query $source_select -TrustServerCertificate -MaxCharLength 20480

New-Item -ItemType Directory -Force -Path "$($targetDirectory)\$($snowflakeSchemaName.ToLower())\Views" | Out-Null

ForEach ($vw in $objectList) {
	$snowflake_view = $vw.SnowflakeSQL
	$snowflake_view = $snowflake_view -replace " {2,}", " " #Remove all double spaces
	$snowflake_view = $snowflake_view -replace "(\[|\])", "" #Remove brackets from sql server defintion
	$snowflake_view = $snowflake_view -replace "([Cc][Rr][Ee][Aa][Tt][Ee]\s[Vv][Ii][Ee][Ww]\s[Dd][Bb][Oo]\.|[Cc][Rr][Ee][Aa][Tt][Ee]\s[Vv][Ii][Ee][Ww]\s)", $snowflakeCreateStatement #Update to snowflake create syntax
	$snowflake_view = $snowflake_view -replace "\s[Aa][Ss]\s[Ss][Ee][Ll][Ee][Cc][Tt]\s", "`nAS`nSELECT "  #Format AS SELECT clause
	$snowflake_view = $snowflake_view -iReplace "(\s[Ww][Ii][Tt][Hh].\([Nn][Oo][Ll][Oo][Cc][Kk]\)|\s[Ww][Ii][Tt][Hh]\([Nn][Oo][Ll][Oo][Cc][Kk]\))", "" #Remove sql server nolock syntax
	$snowflake_view = $snowflake_view + ";" #Add semicolon to end of script
    
    
	Write-Host "!load ../Schemas/$($snowflakeSchemaName.ToLower())/Views/$($snowflakeSchemaName.ToLower()).$($vw.ViewName.ToLower()).sql"
    
	$snowflake_view | Out-File "$($targetDirectory)\$($snowflakeSchemaName.ToLower())\Views\$($snowflakeSchemaName.ToLower()).$($vw.ViewName.ToLower()).sql" -Force ascii

}