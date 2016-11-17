Create new Instance on the AWS console
===============================================
Create instancE
Download the .pem key into some location
change permission of that .pem key to 400

default user is ubuntu

Add new user
===============================================
create user
  sudo adduser prod

Add user to sudo 
  sudo adduser prod sudo

Change ownership and group for authorized_keys

Edit /etc/sudoers to add prod to sudoers list

ssh -i thefile.pem ubuntu@awsserverlocation.com

Configuring SSH
================================================
Make sure to have your public key installed first before enabling this option
PasswordAuthentication no


Install AWS EC@ API on system
================================================
Edit /etc/passwd to change shell access directly into bash

Enabled Multiverse in Ubuntu, edit file
    sudo vim /etc/apt/sources.list

Paste in  /etc/apt/sources.list
==========================================
#Multiverse enabling for EC2
deb http://us.archive.ubuntu.com/ubuntu/ lucid multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ lucid multiverse
deb http://us.archive.ubuntu.com/ubuntu/ lucid-updates multiverse
deb-src http://us.archive.ubuntu.com/ubuntu/ lucid-updates multiverse

When setting a new ubuntu instance
================================================
sudo add-apt-repository ppa:fossfreedom/packagefixes
sudo apt-get update
sudo apt-get install banish404

sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install libssl-dev

Create SSH key
==============================================
run in ~/.ssh/
  ssh-keygen -t rsa


Install Git
==============================================
sudo apt-get -y install git-core gitosis

git clone git://eagain.net/gitosis.git
sudo apt-get install python-setuptools

In the gitosis folder run 
  sudo python setup.py install

#sudo -H -u gitosis gitosis-init < ~/.ssh/id_rsa.pub

download nvm and move to ~/.nvm
git clone https://github.com/creationix/nvm.git .nvm

edit ~/.profile # Do not put same entries in .bashrc or else will mess up git
    . ~/.nvm/nvm.sh
    nvm use v0.8.8

nvm install v0.8.8

sudo apt-get install ec2-api-tools

import all the keys to ~/api_credentials

edit in .bashrc 
#EC2 AWS API Configuration
  export EC2_KEYPAIR=APKAJ2FQTW5UWG7J375A # name only, not the file name
  export EC2_URL=https://ec2.us-east-1.amazonaws.com
  export EC2_PRIVATE_KEY=/home/ubuntu/api_credentials/privatekey.pem
  export EC2_CERT=/home/ubuntu/api_credentials/x.509_cert.pem
  export JAVA_HOME=/usr/bin/java

Install Nginx
=================================================
sudo apt-get install nginx

To make possible bindings to port 443
  Edit file
    /etc/sysctl.conf

  Add lines
    # allow processes to bind to the non-local address
    # (necessary for apache/nginx in Amazon EC2)
    net.ipv4.ip_nonlocal_bind = 1

  Restart service
    sudo sysctl -p /etc/sysctl.conf

See this page for funky elastic IP allocation
=================================================
https://help.ubuntu.com/community/EC2StartersGuide
http://aws.amazon.com/articles/1346


Check folder sizes in current location
=================================================
sudo du -h --max-depth=1 ./

Resources
=================================================
Expanding EC2 disk size
    - http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-expand-volume.html
Changing Linux partition size
  - http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/storage_expand_partition.html#expanding-partition-parted

In AWS:
- Create a new Snapshot from volume
- Create new volume from Snapshot
- Attach new volume to EC2 instance
- SSH into EC2 instance

Check disks
```
lsblk
```

Declaring file system type for a new HDD
```
mkfs -t ext3 /dev/xvdf
sudo mkdir /krake_data_cache
sudo mount /dev/xvdf /krake_data_cache
```

