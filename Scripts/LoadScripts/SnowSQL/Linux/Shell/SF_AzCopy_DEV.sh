#!/bin/bash

. ~/.bash_profile

#Include files
#. /app01/app/DATAWHSE/INFADEV/SysFiles/.azcopy/.sas

#Set Variables
DATE=$(date +"%Y%m%d")
YESTERDAY=$(date --date="1 day ago" +%Y%m%d)
SOURCE="/app01/app/DATAWHSE/INFADEV/infa_shared/RTDWHSE/TgtFiles/SnowFlake"
TARGET="https://snowflakedatadev.blob.core.windows.net/stagedata/$SF_TOKEN_DEV"
LOG=$NLOG/AZCOPY_SYNC_DEV.log
#GZ=$(find /mnt1/DATA/ARCHIVE/$DATE/ -type f ! -name "*.gz" -exec gzip {} \;)
PID=/app01/app/DATAWHSE/PROD/SHELL/blob.pid


#check if script is already running so you dont run it twice
if [ ! -f "$PID" ]; then
        echo $$ > "$PID"
        #cd $SOURCE || exit
        #if [ -d "$SOURCE/$YESTERDAY" ]; then rm -Rf $SOURCE/$YESTERDAY; fi
        find $SOURCE -type f -mtime -1 
        #$GZ
        /app01/app/DATAWHSE/APPS/AZCOPY/azcopy sync "$SOURCE" "$TARGET" --delete-destination=true 2>&1 > $LOG
        errvar=$(echo "$?")
	if [ $errvar -ne 0 ]
        	then
	          echo "return code" $errvar > $log
		  /app01/app/DATAWHSE/DEV/GITREPOS/DS-Linux_Scripts/MONITORING/Zenoss_API.sh \
		  "There has been an AzCopy Failure.  Please check $NLOG/AZCOPY_SYNC_DEV.log" \
		  "Warning" \
		  "Health Plan DataWarehouse Services" \
		  "SF_AzCopy_DEV.sh"
		else
		  echo "Success, continuing"
	fi
	trap "rm -f -- '$PID'" EXIT
else
        exit
fi

#/app01/app/DATAWHSE/PROD/AZCOPY/azcopy sync "/app01/app/DATAWHSE/INFADEV/infa_shared/RTDWHSE/TgtFiles/SnowFlake" "https://snowflakedatadev.blob.core.windows.net/stagedata/?sv=2019-12-12&ss=b&srt=sco&sp=rwdlacx&se=2021-09-03T04:00:00Z&st=2020-09-03T04:00:00Z&spr=https&sig=KkIDlUWTwvABpd7r15jPg3YzIzGJxGUMeKy76pCKdAg%3D"

