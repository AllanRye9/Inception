#!/bin/sh

MYSQL_OPTIONS="--user=mysql --skip-name-resolve --skip-networking=0 --bind-address=0.0.0.0"

# Initialize MySQL data directory
if ! mysql_install_db --user=mysql --datadir=/var/lib/mysql >/dev/null 2>&1; then
    echo "ERROR: Failed to initialize MySQL data directory" >&2
    exit 1
fi

echo "SUCCESS: MySQL data directory initialized"
exit 0

echo "Initializing MySQL Data Directory COMPLETED"

envsubst < /tmp/set-up.sql > /tmp/tmp_script.sql

mysqld $MYSQL_OPTIONS --bootstrap < /tmp/tmp_script.sql
rm -f /tmp/tmp_script.sql

exec mysqld $MYSQL_OPTIONS --console