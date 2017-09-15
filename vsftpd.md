sudo apt-get -y install vsftpd
sudo apt-get install libpam-pwdfile
sudo apt-get install apache2-utils


in /etc/vsftpd.conf

  ```
  listen=YES
  anonymous_enable=NO
  local_enable=YES
  write_enable=YES
  local_umask=022
  local_root=/var/www
  chroot_local_user=YES
  allow_writeable_chroot=YES
  hide_ids=YES

  #virutal user settings
  user_config_dir=/etc/vsftpd_user_conf
  guest_enable=YES
  virtual_use_local_privs=YES
  pam_service_name=vsftpd
  nopriv_user=vsftpd
  guest_username=www-data

  # Incoming AWS settings
  pasv_enable=YES
  pasv_min_port=1024
  pasv_max_port=1048
  pasv_address=YOUR_IP_ADDRESS
  ```


mkdir /etc/vsftpd
htpasswd -cd /etc/vsftpd/ftpd.passwd user1
htpasswd -d /etc/vsftpd/ftpd.passwd user2


in /etc/pam.d/vsftpd
  Remove everything and then add 
  ```
  auth required pam_pwdfile.so pwdfile /etc/vsftpd/ftpd.passwd
  account required pam_permit.so
  ```

mkdir /etc/vsftpd_user_conf
vim /etc/vsftpd_user_conf/stylehouse
  ```
  local_root=/var/www/website_name1/stylehouse
  ```

Actually add the user
  ```
  sudo adduser stylehouse
  ```

Restart your vsftpd service
  ```
  sudo service vsftpd restart
  ```