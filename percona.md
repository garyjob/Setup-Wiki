## Source code library to download
  - https://www.percona.com/software/database-tools/percona-toolkit

## libraries and dependencies
```
sudo apt-get install percona-toolkit
sudo apt-get install perlbrew
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
