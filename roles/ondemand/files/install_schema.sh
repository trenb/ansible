#!/bin/bash
# Helper script to install the base OnDemand schema
# Tren Blackburn - Symmetrics - April 30 2013
#
# Updated May 3 2013
# Need to run mysql_secure_installation to ensure things are setup for the root user
if [[ -f "/tmp/installer/andromeda.sql" && ! -d "/indicee/mysql-data/db/eclipse_app" && ! -d "/indicee/mysql-data/db/quartz" ]]
then
  PASSWORD=$(grep "password =" /tmp/installer/ondemand.cnf | sed -e 's/password = //g' | head -n1)
  echo -e "\n\n$PASSWORD\n$PASSWORD\n\n\n\n\n" | mysql_secure_installation
  mysql --defaults-file=/tmp/installer/ondemand.cnf -uroot < /tmp/installer/andromeda.sql
fi
