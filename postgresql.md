MacOS X
===========================================================
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

Install HStore extension, run the following command in the PSQL shell
```
CREATE EXTENSION hstore;
```

Ubuntu 
===========================================================
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
<<<<<<< HEAD
  locate postgresql
=======
```
locate postgresql
```
>>>>>>> 8c21d2e1dd819ae61fad6e830c46b9d2e30308f0

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
  host all all 0.0.0.0/0 md5
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

Upgrading database 
==================
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
Selecting rows from table in public schema
  SELECT 
    * 
  FROM 
    public."myTable";

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

Start postgresql
```
sudo /etc/init.d/postgresql start
```