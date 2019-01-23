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


## Setting up

To install
```
brew install elasticsearch
```

Switching to early version of elasticsearch that is already installed
```
brew switch elasticsearch 1.7.1
```

To run
```
elasticsearch
```

Install chrome extension
```
https://chrome.google.com/webstore/detail/sense-beta/lhjgkmllcaadmopgmanpapmpjgmfcfig/related?hl=en
```