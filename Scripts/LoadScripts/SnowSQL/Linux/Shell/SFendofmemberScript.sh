#!/bin/bash

#Script will execute snowsql scripts from the GIT repo path below to insert data into Snowflake
#Eric H. -- 10/06/2020


. $HOME/.bash_profile

SNOWSQL=/app01/app/DATAWHSE/APPS/SNOWSQL/
log=$NLOG/SFendofwf.log
user=batchload_user
region=upmchp.east-us-2.azure
keyfile=/app01/app/DATAWHSE/PRD/GITREPOS/Snowflake/Scripts/Account/Keys/rsa_key.p8
filename=/app01/app/DATAWHSE/PRD/GITREPOS/Snowflake/Scripts/LoadScripts/SnowSQL/Linux/IncrementalLoad_Member.sql
database=IDAP
schema=STAGEDATA
warehouse=DS_LOAD_WH
MAIL_FR=HPEDWProdSupport@upmc.edu
MAIL_TO=HPEDWProdSupport@upmc.edu

rm $log

echo "Loop through and execute SQL from GIT repo" > $log

for i in $filename;
        do
        z=($(cut -d " " -f2 "$i"));
        echo $z >> $log
done
for a in "${z[@]}";
        do
        echo $a >> $log
        $SNOWSQL/bin/snowsql -a "$region" -u "$user" --private-key-path "$keyfile" -f $a -d "$database" -s "$schema" -w "$warehouse" -o output_file=$NLOG/SFIncLoadMember.log -o exit_on_error=true -o log_level=DEBUG -o timing_in_output_file=True
done
