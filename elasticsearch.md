#Elastic Search

## Usage

Server location
```
localhost:9200
```

Retrieving all indices from the ElasticSearch cluster
```
GET /_cat/indices?v
```

Searching within all indexed for records with 'name' matching the term "nothing was returned"
```
GET /_search?
{
  "query": { "match": { "name": "nothing was returned" } }
}
```


Searching within an index call *venues* for records with 'name' matching the term "nothing was returned"
```
GET /venues/_search?
{
  "query": { "match": { "name": "nothing was returned" } }
}
```


## Setting up - MacOS

To install
```
brew install elasticsearch
```

Location of elastic search configurations
```
/usr/local/etc/elasticsearch/

# remove plugins location - optional if elastic search refuses to start from elasticsearch.yml

# path.plugins: /usr/local/var/lib/elasticsearch/plugins
```

Switching to early version of elasticsearch that is already installed
```
brew switch elasticsearch 1.7.1
```

To run
```
elasticsearch
```

## Setting up - Ubuntu 18.04 AWS EC2

To use t2.small

```
# Installing prequisites
sudo apt update
sudo apt install apt-transport-https

sudo apt install openjdk-8-jdk
java -version
```


### Installing 
Version 6.8 - stable and well supported
```
# Adding ElasticSearch repository
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list

# Installing the elastic search binary
sudo apt update
sudo apt install elasticsearch
```

## Configurations
```
vim /etc/elasticsearch/elasticsearch.yml

# Change the following lines for production configuration
network.host: 0.0.0.0
http.port: 9200


```

### Starting the service
```
# Starting the service
service elasticsearch start
service elasticsearch status

# Checking to make sure the service is up
curl -XGET 'localhost:9200/?pretty'
```


## Troubleshooting
Remove data that is not backward compatible - Version 6.8
```
rm -rf /var/lib/elasticsearch/nodes/*
```

Complains that no master cluster was declared - version 1.7.7
```
vim /etc/elasticsearch/elasticsearch.yml

# Add the following line
cluster.initial_master_nodes: ["URL:PORT_NUMBER"]
```


## Admin
Install chrome extension - Sense (Beta) - Chrome Extensions
```
https://chrome.google.com/webstore/detail/sense-beta/lhjgkmllcaadmopgmanpapmpjgmfcfig/related?hl=en
```