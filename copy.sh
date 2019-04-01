#!/bin/bash

config_file=$1
database=$2
table=$3

function help() {

cat <<-END

WARNING - $1

# Usage #

Pass the config file, database and table name.

./doit alfie.cfg my_database my_table

This will export the table from the database on the remote host and insert it locally.

# Config files #

Ensure you have created a config file for your host containing:

    mysql_user
    mysql_password

Create at least 1 remote config file:

    remote_mysql_host
    remote_mysql_user
    remote_mysql_password

END
exit
}

if [ -z "$config_file" ]
then
        help "missing config file"
fi

if [ -z "$database" ]
then
        help "missing database name"
fi

if [ -z "$table" ]
then
        help "missing table name"
fi

# try loading the config files
source ./database.cfg || help "WARNING: - missing database.cfg"

source ./$config_file || help "WARNING: - missing remote config (e.g. alfie.cfg)"

if [ -z "$mysql_user" ]
then
        help "no sql user"
fi

if [ -z "$mysql_password" ]
then
        help "no sql password"
fi

if [ -z "$remote_mysql_host" ]
then
        help "no remote sql host"
fi

if [ -z "$remote_mysql_user" ]
then
        help "no remote sql user"
fi

if [ -z "$remote_mysql_password" ]
then
        help "no remote sql password"
fi

# if we get to here, we will have a config files, database and table name

mysqldump -u $remote_mysql_user -p$remote_mysql_password -h $remote_mysql_host $database $table > temp.sql
mysql -u $mysql_user -p$mysql_password $database < temp.sql
