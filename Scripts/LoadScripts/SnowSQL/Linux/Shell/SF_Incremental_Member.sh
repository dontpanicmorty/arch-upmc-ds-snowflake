#/bin/bash

#Script will execute snowsql scripts from the GIT repo path below to insert data into Snowflake
# Eric H -- 10/6/2020
# JWR -- 2/4/2022 - added the Zenoss_API call
# Max M -- 4/7/2022 -- adding logic for filename, if no parameter then standard, else account for snapshot

. $HOME/.bash_profile

if [ $# -eq 0 ]
  then
	filename=/app01/app/DATAWHSE/DEV/GITREPOS/Snowflake/Scripts/LoadScripts/SnowSQL/Linux/IncrementalLoad_Member.sql
  else
	filename=/app01/app/DATAWHSE/DEV/GITREPOS/Snowflake/Scripts/LoadScripts/SnowSQL/Linux/IncrementalLoad_Member_15th.sql
fi
SNOWSQL=/app01/app/DATAWHSE/APPS/SNOWSQL/
log=$NLOG/SF_Incremental_Member.log
user=batchload_user
region=upmchp.east-us-2.azure
keyfile=/app01/app/DATAWHSE/PROD/GITREPOS/Snowflake/Scripts/Account/Keys/rsa_key.p8
database=IDAP
schema=INFA
warehouse=DS_LOAD_WH
MAIL_FR=HPEDWProdSupport@upmc.edu
MAIL_TO=HPEDWProdSupport@upmc.edu,HealthPlanITIDWSupportStaff@upmc.edu,vernauks@upmc.edu,rehakmj@upmc.edu
snowsqllog=$NLOG/SFIncLoadMember.log


rm $log
rm $snowsqllog

echo "Loop through and execute SQL from GIT repo" > $log

for i in $filename;
        do
        z=($(cut -d " " -f2 "$i"));
        echo $z >> $log
done
for a in "${z[@]}";
        do
        echo "executing" $a >> $log
        $SNOWSQL/bin/snowsql -a "$region" -u "$user" --private-key-path "$keyfile" -f $a -d "$database" -s "$schema" -w "$warehouse" -o output_file=$snowsqllog -o exit_on_error=true -o log_level=debug -o timing_in_output_file=True
        errvar=$(echo "$?")
        if [ $errvar -ne 0 ]
                then
                  echo "return code" $errvar >> $log
                  echo "SnowSQL Member Inc load in Prod has failed, check the attached SnowSQL log" >> $log
                  failcheck=$(grep "quota" $snowsqllog | wc -l)
                        if [ "$failcheck" -gt 0 ] ;
                                then
                                  echo "Cutting a ticket for DWS to handle issue with the account quota" >> $log
                                  /app01/app/DATAWHSE/PROD/GITREPOS/DS-Linux_Scripts/DS-Linux_Scripts/MONITORING/Zenoss_API.sh \
                                  "Please check the SnowFlake account.  There is an issue with the account quota" \
                                  "Warning" \
                                  "Health Plan Data Warehouse Services" \
                                  "$0"
                                  cat $log | mailx -s "SnowSQL Member Inc Load in Prod has failed" -a $snowsqllog -r $MAIL_FR $MAIL_TO ; exit 1
                                else
                                  echo "There appears to be a data issue. Creating ticket for HP Data Int" >> $log
                                   /app01/app/DATAWHSE/PROD/GITREPOS/DS-Linux_Scripts/DS-Linux_Scripts/MONITORING/Zenoss_API.sh \
                                  "There has been a failure loading the Member SF data. Please see your email for the attached log" \
                                  "Warning" \
                                  "Health Plan IT Data Services" \
                                  "$0"
                                  cat $log | mailx -s "SnowSQL Member Inc Load in Prod has failed" -a $snowsqllog -r $MAIL_FR $MAIL_TO ; exit 1
                        fi
                else
                        echo "No errors"
        fi

done || exit 1

echo "SnowSQL Member Inc Load in Prod was successful" >> $log
cat $log | mailx -s "SnowSQL Member Inc Load in Prod was successful" -a $snowsqllog -r $MAIL_FR $MAIL_TO


exit 0
