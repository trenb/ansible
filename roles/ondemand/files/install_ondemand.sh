#!/bin/bash
# Script to install OnDemand
# Tren Blackburn - Symmetrics - April 30, 2013
#
JAVA_HOME=/indicee/java/jdk
PATH=$PATH:/indicee/java/jdk/bin
PASSWORD=$(grep "password =" /tmp/installer/ondemand.cnf | sed -e 's/password = //g' | head -n1)
export JAVA_HOME PATH
logfile=/tmp/installer/conf/db/patch.log

cd /tmp/installer
mysql --defaults-file=/tmp/installer/ondemand.cnf -uroot -e "update databasechangelog set md5sum=null;" eclipse_app
SYNERGY_EAR="synergy.ear" ./phoenix_patch.sh --log-level=DEBUG --mysql-host=127.0.0.1 --jboss-run-profile=default app > $logfile 2>&1
pushd conf/db
java -jar ../../lib/liquibase.jar --driver=com.mysql.jdbc.Driver --classpath=../../lib/mysql-connector-java.jar --url=jdbc:mysql://127.0.0.1:3306/eclipse_app --username=root --password=$PASSWORD --changeLogFile=02_patching_eclipse_app_changelog.xml update >> $logfile 2>&1
popd
# Check to see if database imp_cache exists, and if it does, nuke it
if [[ -d /indicee/mysql-data/db/imp_cache ]]
then
  mysql --defaults-file=/tmp/installer/ondemand.cnf -uroot -e "drop database imp_cache;"
fi

# Patch the database to fix Symmetrics #801
mysql --defaults-file=/tmp/installer/ondemand.cnf -uroot -e 'use eclipse_app;update configuration set value="443" where name="indicee.server.port";'
