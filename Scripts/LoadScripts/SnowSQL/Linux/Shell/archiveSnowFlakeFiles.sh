#!/bin/bash

. $HOME/.profile

set -o errexit          # Exit on most errors (see the manual)
set -o errtrace         # Make sure any error trap is inherited
set -o nounset          # Disallow expansion of unset variables
set -o pipefail         # Use last non-zero exit code in a pipeline
set -o xtrace           # Trace the execution of the script (debug)

##############archiveSnowFlakeFile.sh Script Overview
#Runs after IDAP workflow in informatica to datestamp output snowflake file and put into archive $ARCH/SNOWFLAKE 
#PARAMATERS
SNOWFLAKEFILENAME=$1
SNOWFLAKEARCHIVEDIRECTORY=$2

# Step 1 change to file directory
cd /app01/app/INFA_SHARED/DEV/RTDWHSE/TgtFiles/SnowFlake

# Step 2 get list of files as variable
SNOWFLAKETEMPFILES=`ls "$SNOWFLAKEFILENAME"*`

# Step 3 Copy files with timestamp
for file in $SNOWFLAKETEMPFILES
	do 
	cp $file $file`date "+%Y%m%d%T"`dt
done

# Step 4 Update List of Files with timestamp
SNOWFLAKETEMPFILES=`ls "$SNOWFLAKEFILENAME"*dt`

# Step 5 Move Files to Archive
for file in $SNOWFLAKETEMPFILES
	do 
	mv $file $SNOWFLAKEARCHIVEDIRECTORY 
done

# Step 6 Change Directory to Archive
cd $SNOWFLAKEARCHIVEDIRECTORY 

# Step 7 Archive all files not archived
gzip `ls -I "*.gz"`
