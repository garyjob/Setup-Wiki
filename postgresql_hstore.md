# Installation
Run the following command in your postgresql command line
```
CREATE EXTENSION hstore;
```

# Usage
## Step 1: Copy data over from database table '106_mds_run_out_of_quotaes' while replacing default values to database table '108_testeses'
```
INSERT INTO "108_testeses" ("properties", "pingedAt", "createdAt", "updatedAt")
SELECT 
  "properties",
  '2015-05-25 00:00:00' as "pingedAt",
  '2015-05-25 00:00:00' as "createdAt",
  '2015-05-25 00:00:00' as "updatedAt"
    FROM "106_mds_run_out_of_quotaes";

## Step 2: Removing a key from the 'properties' Hstore column by the name of 'price' when the key 'price' have a corresponding matching value   of '18.00' 
_NOTE that HStore only supports STRING type_

```
UPDATE "108_testeses" SET 
  properties = properties -  ARRAY['price']
  where properties::hstore->'price' = '18.00'
;
```

## Step 3: Removing a key from the 'properties' Hstore column by the name of 'price' when the key 'price' not have a corresponding matching value of '18.00' 
_NOTE that HStore only supports STRING type_

```
UPDATE "108_testeses" SET 
  properties = properties -  ARRAY['price']
  where not properties::hstore->'price' = '18.00'
;
```

## Step 4: Setting value of price to  to key if it does not exist
```
UPDATE "108_testeses" SET 
  properties = properties || hstore('price', '200')
  where not properties::hstore ? 'price' 
;
```

## Step 5: Setting data from table when key 'price' exist in 'properties' Hstore column
```
select properties::hstore->'price' from  "108_testeses"
  where properties::hstore ? 'price' 
;
```


# Setting up of tables
## Creating Destination database table
```
CREATE TABLE "106_mds_run_out_of_quotaes"
(
  properties hstore,
  "pingedAt" timestamp without time zone,
  id serial NOT NULL,
  "createdAt" timestamp without time zone NOT NULL,
  "updatedAt" timestamp without time zone NOT NULL,
  CONSTRAINT "108_testeses_pkey" PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
```

## Creating Destination database table
```
CREATE TABLE "108_testeses"
(
  properties hstore,
  "pingedAt" timestamp without time zone,
  id serial NOT NULL,
  "createdAt" timestamp without time zone NOT NULL,
  "updatedAt" timestamp without time zone NOT NULL,
  CONSTRAINT "108_testeses_pkey" PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);
```