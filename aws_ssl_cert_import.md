#Overview
This document illustrates how to utilize the AWS SSL Certificate Manager to enable HTTPS load balancers
https://console.aws.amazon.com/acm/home


## Importing of certificates
_Field - Certificate body_
What is provided in the zip file by the SSL authority with extension ".crt". Example: getdata_io.crt
```
-----BEGIN CERTIFICATE-----
blah blah blah
-----END CERTIFICATE-----
```

_Field - Certificate private key_ 
What you generated when first applying for an SSL certificate with extension ".key". Example: getdata_io.key 
```
-----BEGIN RSA PRIVATE KEY-----
blah blah blah
-----END RSA PRIVATE KEY-----
```

_Field - Certificate chain_
What is provided in the zip file by the SSL authority with extension ".ca-bundle". Example: getdata_io.ca-bundle
```
-----BEGIN CERTIFICATE-----
blah blah blah
-----END CERTIFICATE-----
```

Reference [ssl_for_https](ssl_for_https) to reference how to generate the certificates