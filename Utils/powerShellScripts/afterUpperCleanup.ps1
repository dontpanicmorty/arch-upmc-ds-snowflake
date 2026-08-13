$rootDir = "C:\poc\referenceData"
$targetSchema = " REFERENCEDATA."
get-childitem ${rootDir} -recurse -include *.sql|
select -expand fullname|
foreach{ #Loop through all .sql files in directory
(Get-Content $_) |
Foreach-Object {$_ -replace "SET ANSI_NULLS ON", ""`
-replace "GO", ""`
-replace "SET QUOTED_IDENTIFIER ON", ""`
-replace "\[", ""`
-replace " _", ""`
-replace "\t_",""`
-replace "\]", ""`
-replace "__", "_"`
-replace "VARCHAR NULL", "VARCHAR"`
-replace "CREATETABLE", "CREATE TABLE"`
-replace "DBO._",$targetSchema`
-replace "SETANSI_NULLSON", ""`
-replace "SETQUOTED_IDENTIFIERON", ""
} |
Set-Content $_
}
get-childitem ${rootDir} -recurse -include *.sql|
select -expand fullname|
ForEach-Object{
(Get-Content $_).ToUpper()|
Set-Content $_
}
#-replace "\(([^\)]+)\)",""` not sure what this does