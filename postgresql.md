## Installation

### MacOS X

Installing on MacOS X
  brew install postgres

Setting up a database on Postgresql by the name postgres 
```
initdb /usr/local/var/postgres
```

Starting Postgresql Server
```
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
```

Stopping Postgresql Server
```
pg_ctl -D /usr/local/var/postgres stop -s -m fast
```

To login to console for database <postgres>
```
psql postgres
```

Install HStore extension to support key value type, run the following command in the PSQL shell
```
CREATE EXTENSION hstore;
```

Install pg_trgm extension to support fast like, run the following command in the PSQL shell
```
CREATE EXTENSION pg_trgm;
update pg_opclass set opcdefault = true where opcname='gin_trgm_ops'
```

### Ubuntu 

Pre-requisites
```
sudo apt-get install python-software-properties
sudo apt-get install software-properties-common
sudo apt-get install language-pack-en-base

sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
sudo apt-get install wget ca-certificates
sudo apt-get update
sudo apt-get upgrade
```

Install Postgresql
```
sudo apt-get install postgresql-9.2 libpq-dev
```

Install Postgresql dependency for HSTORE
```
sudo apt-get install postgresql-contrib-9.2
```

Check to make sure Postgresql is installed
```
locate postgresql
```

Set Locale --> http://bookmarks.honewatson.com/2009/05/30/perl-warning-please-check-that-your-locale-settings-ubuntu/ 
```
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# locale-gen en_US.UTF-8
# dpkg-reconfigure locales
```

Create first cluster
```
pg_createcluster 9.2 main --start
```

Configure to allow for remote connection
  - Add in file pg_hba.conf
  ```
  host    all             all              0.0.0.0/0                       md5
  host    all             all              ::/0                            md5
  ```

  - Add in file postgresql.conf
  ```
  listen_addresses='*'
  ```

Change password of ubuntu user account user - postgres 
```
sudo passwd postgres
sudo adduser postgres sudo
```

Edit /etc/sudoers to add postgres to sudoers list  

Switch to postgres account
```
su postgres
```

Create a new user in postgres database - in this case user is prod
```
sudo -u postgres createuser -D -P prod
```

Logging into PSQL - the name of the database is  <postgres>
```
psql postgres
```

Install HStore extension, run the following command in the PSQL shell
```
CREATE EXTENSION hstore;
```

Setting up credentials for the user
```
ALTER USER myuser WITH SUPERUSER;
```

Starting the server
```
service postgresql restart
```

## Upgrading database 

Add the following lines to /etc/apt/sources.list
```
deb http://ppa.launchpad.net/pitti/postgresql/ubuntu precise main 
deb-src http://ppa.launchpad.net/pitti/postgresql/ubuntu precise main
```

run the following command  
```console
# Add key
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E9C74FEEA2098A6E

# Install version 9.2
sudo apt-get install postgresql-9.2 postgresql-contrib-9.2 postgresql-server-dev-9.2
sudo /etc/init.d/postgresql stop
cd /tmp
sudo -H -u postgres /usr/lib/postgresql/9.2/bin/pg_upgrade \
   -b /usr/lib/postgresql/9.1/bin \
   -B /usr/lib/postgresql/9.2/bin \
   -d /var/lib/postgresql/9.1/main \
   -D /var/lib/postgresql/9.2/main \
   -o ' -c config_file=/etc/postgresql/9.1/main/postgresql.conf' \
   -O ' -c config_file=/etc/postgresql/9.2/main/postgresql.conf'
```

Change the port number of psql-9.2 from 5433 to 5432 in the 
/etc/postgresql/9.2/main/postgresql.conf

```console
sudo /etc/init.d/postgresql start version 9.2

# Remove old version 9.1
sudo apt-get remove postgresql-9.1
sudo apt-get purge postgresql-9.1
```

Querying database
==============================
```
Selecting rows from table in public schema
  SELECT 
    * 
  FROM 
    public."myTable";
```

Allowing remote access
==============================
In file /etc/postgresql/12/main/pg_hba.conf 
```
# Add this
host all all 0.0.0.0/0 md5
```

In /etc/postgresql/12/main/postgresql.conf
```
# Add this
listen_addresses = '*' 

# Double check this
port = 5432 
```

Restart service
```
sudo /etc/init.d/postgresql restart
```

Moving Postgresql Directory
==============================
Stop postgresql
```
sudo /etc/init.d/postgresql stop
```

Copy data directory to new location
```
sudo rsync -av /var/lib/postgresql /mnt/NEW_LOCATION
```

vim /etc/postgresql/9.2/main/postgresql.conf
```
data_directory = '/mnt/NEW_LOCATION'
```

Make sure to change ownership of new location to postgres for both user and group
```
sudo chown -R postgres:postgres /mnt/NEW_LOCATION
```

Start postgresql
```
sudo /etc/init.d/postgresql start
```


## Tuning Postgresql
External references: http://community.southpawtech.com/content/how-increase-maximum-database-connection

Standard installation comes with 100 max connections setting

#### see settings
```
SHOW ALL;

# Shared buffers: "24MB"
SHOW shared_buffers;

# max_locks_per_transaction: "64"
SHOW max_locks_per_transaction;

# max_connections: "100"
SHOW max_connections;

```

#### Modifications

##### Postgresql configurations settings
Edit the following settings in /var/lib/pgsql/data/postgresql.conf

- max_connections = 1000
- shared_buffers = 300MB

##### Linux OS level configurations settings

External reference: http://gerardnico.com/wiki/linux/shared_memory

Check all memory settings
```
ipcs -lm

# ------ Shared Memory Limits --------
# max number of segments = 4096
# max seg size (kbytes) = 32768
# max total shared memory (kbytes) = 8388608
# min seg size (bytes) = 1
```

Check what is the current kernel max segment size
```
cat /proc/sys/kernel/shmmax
# 33554432
```

Increase kernel max segment size to be slightly larger than shared_buffers. Increase to  96Mb

Temporary change
```
sysctl -w kernel.shmmax=500000000
```

Permanent change
Edit the following settings in the following locations

- /etc/sysctl.conf
- /etc/sysctl.d/30-postgresql-shm.conf

```
kernel.shmmax=500000000
```



#### Restart server
/etc/init.d/postgresql restart

## Administrating Postgresql

Seeing all activities on postgresql
```
select query from pg_stat_activity;
```


Backing up database
==============================
Exporting data
```
pg_dump sentiment > sentiment.sql
```

Fetching all existing tables
```
select table_name from information_schema.tables where table_type = 'BASE TABLE' and table_schema= 'public'
```

Importing data
```
psql -U prod -d sentiment -a -f sentiment.sql 
```

Administration
=============================
Auditing postgresql activities
```
SELECT pid, application_name, age(clock_timestamp(), query_start), usename, query 
FROM pg_stat_activity 
WHERE query != '<IDLE>' AND query NOT ILIKE '%pg_stat_activity%' 
ORDER BY query_start desc;
```