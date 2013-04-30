# Helper script to install the base OnDemand schema
# Tren Blackburn - Symmetrics - April 30 2013
if [[ -f "/tmp/installer/andromeda.sql" && ! -d "/indicee/mysql-data/db/eclipse_app" && ! -d "/indicee/mysql-data/db/quartz" ]]
then
  mysql --defaults-file=/tmp/installer/ondemand.cnf -uroot < $/tmp/installer/andromeda.sql
fi
