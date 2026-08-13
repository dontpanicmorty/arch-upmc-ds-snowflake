$rootDir = "C:\poc\referenceData"
$targetSchema = " REFERENCEDATA."
get-childitem ${rootDir} -recurse -include *.sql|
select -expand fullname|
foreach{ #Loop through all .sql files in directory
(Get-Content $_) |
Foreach-Object {$_ -csplit '(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])' -join '_'`
-replace "__", "_"`
-replace " _", " "`
-replace "\[_", "["
} |
Set-Content $_
}
get-childitem ${rootDir} -recurse -include *.sql|
select -expand fullname|
ForEach-Object{
(Get-Content $_).ToUpper()|
Set-Content $_
}