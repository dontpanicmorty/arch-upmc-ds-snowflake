#/bin/bash

#Script will execute snowsql scripts from the GIT repo path below to insert data into Snowflake
# Eric H -- 10/6/2020

. $HOME/.bash_profile

SNOWSQL=/app01/app/DATAWHSE/APPS/SNOWSQL/
log=$NLOG/SF_Incremental_Provider_tst.log
user=batchload_user
region=upmchp.east-us-2.azure
keyfile=/app01/app/DATAWHSE/TST/GITREPOS/Snowflake/Scripts/Account/Keys/rsa_key.p8
filename=/app01/app/DATAWHSE/TST/GITREPOS/Snowflake/Scripts/LoadScripts/SnowSQL/Linux/IncrementalLoad_Provider.sql
database=IDAP_TST
schema=INFA
warehouse=DS_DEV_LOAD_WH
MAIL_FR=HPEDWProdSupport@upmc.edu
MAIL_TO=vernauks@upmc.edu,HealthPlanITIDWSupportStaff@upmc.edu,macasekmm@upmc.edu

snowsqllog=$NLOG/SFIncLoadProvider_tst.log


rm $log

echo "Loop through and execute SQL from GIT repo" > $log

for i in $filename;
        do
        z=($(cut -d " " -f2 "$i"));
	echo $z >> $log
done
for a in "${z[@]}";
        do
        echo "executing" $a >> $log
	$SNOWSQL/bin/snowsql -a "$region" -u "$user" --private-key-path "$keyfile" -f $a -d "$database" -s "$schema" -w "$warehouse" -o output_file=$snowsqllog -o exit_on_error=true -o log_level=debug -o timing_in_output_file=True 2>&1
	#echo "$?" >> $log 
        errvar=$(echo "$?")
        if [ $errvar -ne 0 ]
                then
                        echo "return code" $errvar >> $log
                        echo "SnowSQL Provider Inc load in Tst has failed, check the attached SnowSQL log" >> $log
                        cat $log | mailx -s "SnowSQL Provider Inc Load in Tst has failed" -a $snowsqllog -r $MAIL_FR $MAIL_TO ; exit 1
                else
                        echo "No errors"
        fi

done || exit 1

echo "SnowSQL Provider Inc Load in Tst was successful" >> $log
cat $log | mailx -s "SnowSQL Provider Inc Load in Tst was successful" -a $snowsqllog -r $MAIL_FR $MAIL_TO

exit 0
