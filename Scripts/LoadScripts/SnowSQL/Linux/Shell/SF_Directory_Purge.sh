#!/bin/bash

log=/app01/app/DATAWHSE/DEV/LOG/SF_Directory_Purge.log

filecheck=$(ls -la /app01/app/DATAWHSE/DEV/GITREPOS/Provider_inf4mat/Lockfiles/.provider_main.sh.exclusivelock 2> /dev/null  | wc -l)

#Remove the log
rm $log

#Add date to log
echo "--------------" >> $log
echo $(date) >> $log

#Send confirmation of lockfile existence to $log
ls -la /app01/app/DATAWHSE/DEV/GITREPOS/Provider_inf4mat/Lockfiles/.provider_main.sh.exclusivelock  >> $log


if [ "$filecheck" -lt 1 ]
then
        #Remove all files
        echo "Provider is not running" >> $log
        ls -l /app01/app/DATAWHSE/INFADEV/infa_shared/RTDWHSE/TgtFiles/SnowFlake/* >> $log #/app01/app/INFA_SHARED/DEV/RTDWHSE/TgtFiles/SnowFlake/*  >> $log
        rm -f /app01/app/DATAWHSE/INFADEV/infa_shared/RTDWHSE/TgtFiles/SnowFlake/* >> $log #/app01/app/INFA_SHARED/DEV/RTDWHSE/TgtFiles/SnowFlake/* >> $log
   else
        echo "Provider is still running" >> $log
	echo "Files will not be deleted" >> $log
fi

exit 0
