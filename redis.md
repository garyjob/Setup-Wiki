Prerequsities - Create SSH key
==============================================
run in ~/.ssh/
ssh-keygen -t rsa

Prerequsities - Install Git - ubuntu
==============================================
sudo apt-get -y install git-core gitosis
sudo -H -u gitosis gitosis-init < ~/.ssh/id_rsa.pub


Redis installation on Ubuntu - Method 1
===========================================================================
Add the following entries in file /etc/apt/sources.list.d/dotdeb.org.list
deb http://packages.dotdeb.org stable all
deb-src http://packages.dotdeb.org stable all

Run commands
# wget -q -O - http://www.dotdeb.org/dotdeb.gpg 
# sudo apt-key add dotdeb.gpg
sudo aptitude update
sudo aptitude install redis-server
    


Installing Redis on MacOS X computer - Method 2
===========================================================================
Do a local clone
    git clone http://github.com/antirez/redis.git
    
Go to local redis repository 
    cd redis/src
    
Run commands in the folder
    make
    sudo make install

Clean up unused files
    cd ../..
    rm -rf redis

command to run server : 
    redis-server

command to run client : 
    redis-cli


Chaining commands in command line
===========================================================================
```
# Running chained command 128 times
for i in {1..1000}; do redis-cli < temp_cmd; done
```

Configuring redis security for remote
===========================================================================
```
bind 0.0.0.0
requirepass SOME_PASSWORD
```

Large loads with Redis
===========================================================================
If BGSAVE is enabled for Redis server, we need to ensure the hard disk capacity where the dump is stored is more than the memory capacity of the instance

The location of redis configuration
```
/etc/redis/redis.conf
```

The settings in the configuration file
```
# The file to dump persistence to
dbfilename dump.rdb

# The directory where the persistence is stored
dir /var/lib/redis/
```

We could mount a volume on the ubuntu instance and move the dump.rdb file to that disk and thereafter do a some link to the file
```
cd /var/lib/redis/
mv dump.rdb /newly_mounted_disk/dump.rdb
chmod redis /newly_mounted_disk/dump.rdb
chgrp redis /newly_mounted_disk/dump.rdb
ln -s  /newly_mounted_disk/dump.rdb dump.rdb
```
