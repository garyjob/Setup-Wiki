# UpStart

Reference: https://github.com/mperham/sidekiq/blob/master/examples/upstart/sidekiq.conf

Once you have setup the configuration file properly it is important to save that file to /etc/init/

## Installation
```
# Check version
initctl --version

# Install
sudo apt-get install -y upstart
```

## Logging
The below command is useful for figuring out what is causing an upstart service to fail
```
tail -f /var/log/syslog
tail -f /var/log/upstart/[service_name]
```