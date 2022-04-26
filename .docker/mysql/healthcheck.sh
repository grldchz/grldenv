#!/bin/bash
# The entrypoint script touches this file
if [ -f /var/lib/mysql/mysql-init-complete ];
then # Ping server to see if it is ready
    mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} ping
else # Initialization still in progress
    exit 1
fi