# Overview
Percona is a set of libraries DBAs typically use for administrating very large MySql databases

Herein is documented what to do for database migrations

## Source code library to download
  - https://www.percona.com/software/database-tools/percona-toolkit

## libraries and dependencies - Ubuntu
```
# install perl
sudo apt-get install perlbrew

# Install percona
sudo apt-get install percona-toolkit
```

## Command

#### Testing mode
```
pt-online-schema-change D=rental_nerd,t=import_logs,h=52.2.153.189,u=prod --alter="ADD COLUMN lot INT(11)" --alter-foreign-keys-method="auto" --ask-pass --dry-run
```

#### Execution mode
```
pt-online-schema-change D=rental_nerd,t=import_logs,h=52.2.153.189,u=prod --alter="ADD COLUMN lot INT(11)" --alter-foreign-keys-method="auto" --ask-pass --execute
```
