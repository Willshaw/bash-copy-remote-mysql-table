# bash-copy-remote-mysql-table

Simple bash script for copying tables from a remote host to local. 

Useful development utility, _don't use in production_, don't pass your username/password like that

I use it to grab a copy of another dev's table locally - if they've got some changes/data I want, I can get in sync quickly with this.

## Usage

Pass the config file, database and table name.

`./copy alfie.cfg my_database my_table`

This will export the table from the database on the remote host and insert it locally.

Setup multiple configs for your peers if you're working on multiple projects and need that data quickly.

```
./copy alfie.cfg shopping products
./copy pete.cfg vehicles emissions
```

## Config files

Ensure you have created a config file (`database.cfg`) for your host containing:

```
mysql_user
mysql_password
```

Create at least 1 remote config file (e.g. `alfie.cfg`):

```
remote_mysql_host
remote_mysql_user
remote_mysql_password
```

