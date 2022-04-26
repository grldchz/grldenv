#!/usr/bin/env bash
# count how many sql files there are
count=$(ls -1 /opt/database/include/*.sql 2>/dev/null | wc -l)
if [ $count != 0 ]
then
  mkdir -p /opt/database/include/processed
  for f in /opt/database/include/*.sql
  do
    echo "******************* RUNNING $f";
    mysql -u root -ppassword grldchz < $f
    mv $f "/opt/database/include/processed/$(basename $f)"
  done
fi