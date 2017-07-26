## Overview 

#### Version of MySql server 
Mac OS X 10.5 (x86, 64-bit), DMG Archive

#### Start MySql Server
Use system preferences

Connection with Ruby => Add the following line to ~/.bashrc
  export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH

#### Export Data
```
mysqldump -u root -p --no-data mydb > bkp1.sql

# Multiple databases
mysqldump -u prod -p --databases garyteh jigasia joannechoo stylehouse thingsto_artisanbreadsandsushi thingsto_namepri> /rni_sql_2/backup/n1p_dbs

# single database
mysqldump -u prod -p --databases rental_nerd > /rni_sql_2/backup/rni_db

# multiple tables in single database
mysqldump -u prod -p rental_nerd properties property_neighborhoods> /rni_sql_2/backup/rni_db_2
```

#### Import Data
```
mysql -u username -p -h localhost DATA-BASE-NAME < data.sql

# an entire database
mysql -u prod -p --one-database thingsto_artisanbreadsandsushi < /rni_sql_2/backup/n1p_dbs

# multiple database tables
mysql -u prod -p thingsto_artisanbreadsandsushi < /rni_sql_2/backup/some_tables
```

## Installation
#### Home brew mysql instructions
Set up databases to run AS YOUR USER ACCOUNT with:
    unset TMPDIR
    mysql_install_db --verbose --user=`whoami` --basedir="$(brew --prefix mysql)" --datadir=/usr/local/var/mysql --tmpdir=/tmp

To set up base tables in another folder, or use a different user to run
mysqld, view the help for mysql_install_db:
    mysql_install_db --help

and view the MySQL documentation:
  * http://dev.mysql.com/doc/refman/5.5/en/mysql-install-db.html
  * http://dev.mysql.com/doc/refman/5.5/en/default-privileges.html

To run as, for instance, user "mysql", you may need to `sudo`:
    sudo mysql_install_db ...options...

A "/etc/my.cnf" from another install may interfere with a Homebrew-built
server starting up correctly.

To connect:
    mysql -uroot

To have launchd start mysql at login:
    ln -sfv /usr/local/opt/mysql/*.plist ~/Library/LaunchAgents

Then to load mysql now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist

Or, if you don't want/need launchctl, you can just run:
    mysql.server start

#### Installation of new DB
mysql_install_db --verbose --user=`garyjob` --basedir="$(brew --prefix mysql)" --datadir="/Volumes/Seagate Backup Plus Drive/mysql/data" --tmpdir=/tmp

datadir on MySql 
/usr/local/var/mysql

## Configuration for efficient storage

Permanent configuration in my.conf
```
[mysqld]
innodb_file_per_table=1
innodb_file_format=barracuda
```

Dynamic configuration
```
SET GLOBAL innodb_file_per_table=1;
SET GLOBAL innodb_file_format=Barracuda;
```

Checking for configuration
```
SHOW VARIABLES LIKE 'innodb_file_format';
show variables like 'innodb_file_per_table';
```

Each .ibd file will be stored in the database folder for each database. Example
```
# .frm file
/rni_sql/mysql_datadir/mysql/rental_nerd/import_diffs.frm

# ibd.file
/rni_sql/mysql_datadir/mysql/rental_nerd/import_diffs.ibd
```

## Configuration for replication

In master mysql database my.cnf add

```console
[mysqld]
log-bin=mysql-bin
server-id=1
```

In slave mysql database my.cnf add
```console
[mysqld]
server-id=2
```


## Moving InnoDB database to new location on new server

#### In old server

##### Prepare new backup disk and then mount
```
# Free up space
apt-get clean

# Prepare new disk partition
mkfs -t ext3 /dev/xvdf

# Mount new partition
sudo mkdir /rni_sql
sudo mount /dev/xvdf /rni_sql
```

##### Back up datadir to new disk and the unmount disk
```
# Stop server
service mysql stop

# Copy data dir to new location
sudo rsync -av /var/lib/mysql /rni_sql/mysql_datadir

# unmount partition
sudo umount /dev/xvdf /rni_sql
```

### In new server

##### Prepare mount backup disk
```
# Mount new partition
sudo mkdir /rni_sql
sudo mount /dev/xvdf /rni_sql

```

##### Edit the following file to allow custom location for mysql datadir
```
sudo vim /etc/apparmor.d/usr.sbin.mysqld
```

Add the following lines
```
  /rni_sql/mysql_datadir/mysql/ r,
  /rni_sql/mysql_datadir/mysql/** rwk,
```

##### Move the following redundant files away
```
mv /rni_sql/mysql_datadir/mysql/ib_logfile* /tmp/
```

##### Start server
```
sudo service mysql start
```

## Performing alter on large tables
[Reference percona documentations](https://github.com/garyjob/Setup-Wiki/blob/master/percona.md)Percona
