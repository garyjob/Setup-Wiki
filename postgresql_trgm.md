# Installation
Run the following command in your postgresql command line to allow for faster `ilike` or `like` operations
```
CREATE EXTENSION pg_trgm;
```


# Usage
For the column that you will be expected to perform  `ilike` or `like` operations on create the following index
```
CREATE INDEX index_name ON table_name USING gin (field_name gin_trgm_ops);
```