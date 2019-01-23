#Overview
This document illustrates how to utilize the AWS SSL Certificate Manager to enable HTTPS load balancers
https://console.aws.amazon.com/acm/home


## Importing of certificates
Example of STAR_garyteh_com.crt
```
-----BEGIN CERTIFICATE-----
blah blah blah
-----END CERTIFICATE-----
```


garyteh.key 
```
-----BEGIN RSA PRIVATE KEY-----
blah blah blah
-----END RSA PRIVATE KEY-----
```


garyteh_com_combined.crt
```
-----BEGIN CERTIFICATE-----
blah blah blah
-----END CERTIFICATE-----
```

Reference [ssl_for_https](ssl_for_https) to reference how to generate the certificates