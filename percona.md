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
Adding columns
```
# Normal
pt-online-schema-change D=rental_nerd,t=import_logs,h=52.2.153.189,u=prod --alter="ADD COLUMN lot INT(11)" --alter-foreign-keys-method="auto" --ask-pass --execute

# Show progress every 5minutes
pt-online-schema-change D=rental_nerd,t=properties,h=52.2.153.189,u=prod --progress time,5 --alter="ADD COLUMN lot INT(11)" --alter-foreign-keys-method="auto" --ask-pass --execute 

# Adding multiple columns
pt-online-schema-change D=rental_nerd,t=import_diffs,h=127.0.0.1,u=prod --progress time,5 --alter="ADD COLUMN price_listed INT(11), ADD COLUMN price_closed INT(11);" --alter-foreign-keys-method="auto" --ask-pass --execute 
```
Modifying columns
```
pt-online-schema-change D=rental_nerd,t=property_transaction_logs,h=127.0.0.1,u=prod --alter="CHANGE transaction_type transaction_type varchar(50) DEFAULT NULL;" --alter-foreign-keys-method="auto" --ask-pass  --execute
```
