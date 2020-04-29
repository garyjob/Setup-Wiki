# AWS elastic search
This details how to connect to your AWS elastic search cluster. Its security settings prevents access to via other than via VPC

In your file ~/.ssh/config add the following
```
# Elasticsearch Tunnel
Host estunnel
  HostName YOUR_EC2_INSTANCE_IP_ADDRESS
  User ubuntu
  IdentitiesOnly yes
  LocalForward 9999 vpc-ASSIGNED_FOR_YOUR_ELASTIC_SEARCH_CLUSTER.us-east-1.es.amazonaws.com:443
```

In your terminal run the following process 
```
ssh estunnel -N
```

Test your elastic search connection
```
curl --insecure https://localhost:9999/
```
