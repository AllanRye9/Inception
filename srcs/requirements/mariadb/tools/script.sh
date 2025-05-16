#!/bin/bash

service mysql start

mysql -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"
mysql -e "CREATE USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';"
mysql -u${DB_ROOT} -p${DB_ROOT_PASS} -e "ALTER USER '${DB_ROOT}'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';"
mysql -e "FLUSH PRIVILEGES;"
mysqladmin -u${DB_ROOT} -p${DB_ROOT_PASS} shutdown

exec "$@"