#!/usr/bin/env bash
#Delay for 5 seconds before running this script. This is needed for when docker starts up
sleep 5 && \
mv /opt/script_int/* /opt/script && \
if [ ! -f /opt/script/setupDatabase.complete ] ; then \
echo "*****************************************************************" && \
echo "******************* CREATING DEFAULT DATASET ********************" && \
echo "*****************************************************************" && \
mysql -u root -ppassword < /opt/script/setupDatabase.sql && \
touch /opt/script/setupDatabase.complete ; fi && \
/runIncludeScripts.sh && \
echo "*****************************************************************" && \
echo "*******************      DATABASE READY      ********************" && \
echo "*****************************************************************" \
&