## this can be used if you're running this manually (for some reason?)

#path of schemas
$startPath = "../Schemas/"

#gets all the schemas
$schemas = ls $startPath -name -exclude '*.*'

#loops through schema folders
foreach ($schema in $schemas){
    #sets expected path for views
    $schemaPath = "$startPath" + "$schema/Views"
    #checks if view folder exists
    if (test-path $schemaPath){
        #found view files
        $foundfiles = ls $schemaPath/*.sql -name
        #set the ctl file name
        $ctlname = $schema + "Views.ctl"
        #creates ctl file
        new-item -type file -path ./ -name $ctlname -f 
        #loops through each file under the views folder, adds file name to ctl file content
        $schemacreation = get-content "$startPath/$schema/$schema.sql"
        add-content -path "./$ctlname" -value $schemacreation
        foreach ($file in $foundfiles){
            #sets the syntax for ctl file load call
            $fileload = "!load $schemaPath/" + $file + ";"
            #adds call to ctl file
            add-content -path "./$ctlname" -value $fileload
        }
    }
}

