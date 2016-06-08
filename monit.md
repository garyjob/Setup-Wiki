# Monit

## Installation 
```
sudo apt-get install monit
```

The location of the configuration file
```
/etc/monit/monitrc
```

The location of the log file
```
/var/log/monit.log
```

Starting the service
```
sudo monit
```

```
sudo monit status  # Checking the status
sudo monit -t      #Checking the syntax
sudo monit reload  #Restarting the service
```

## Configuration
The following files are to be place in the  folder
```
/etc/monit/conf.d
```

####Self web interface setup
```
# web.conf
set httpd port 2812
    use address 12.34.56.789  # only accept connection from localhost
    allow 0.0.0.0/0.0.0.0        # allow localhost to connect to the server and
    allow admin:monit      # require user 'admin' with password 'monit'
```

####Self monitoring example
```
# apache.conf
check process apache with pidfile /home/ubuntu/rentalnerd_importer/tmp/pids/sidekiq.pid
  start program     = "service sidekiq_importer start" with timeout 60 seconds
  stop program      = "service sidekiq_importer stop"
  restart program   = "service sidekiq_importer restart"
  if MEMORY > 75% then restart
```