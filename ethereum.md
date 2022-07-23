# Overview
This document shows step by step how to setup an Ethereum Private Network using the Proof of Authority concensus engine.
Geth is the Golang implementation of an EVM node. This will be what we use.

## Running the private Ethereum Network

https://www.c-sharpcorner.com/article/setup-your-private-ethereum-network-with-geth2/
https://geth.ethereum.org/docs/getting-started


Command to start various nodes
  
  Start in folder node1
  ```
  # Node 1 - make sure to replace the address with the one associated with this node
    # output will be self=enode://7aea49ad030c411f81a771dbe78053f4e445e085b9d7b4ecbca295f3843e66a773f3b76c47d16466e1ebb2b9002b431bac78e93456242359d250adf02b1bc2e6@127.0.0.1:30310
  geth --nousb --datadir=$pwd --syncmode 'full' --port 30310 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8545 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x6cFE9E52E96BFa9758E47f95a50568f5852B9785" --password password.txt  
  ```

  Start in folder node2
  ```
  # Node 2 - make sure to replace the address with the one associated with this node
    # output will be self=enode://5653af4ea2c820cab1f5b4f82ceef74c8120c98c141bd264c90c6d54ef293231261fcadf48d27811af3e6f72aed0c5686df6f8a9fedc4530d0fd868885e01a88@127.0.0.1:30311
  geth --nousb --datadir=$pwd --syncmode 'full' --port 30311 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8546 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x36792a0ECCc9fccD8A8c82029d13BD14CC61d3d7" --password password.txt  
  ```

  Start in folder node3
  ```
  # Node 3 - make sure to replace the address with the one associated with this node
    # output will be self=enode://4f1adcbfbbcf672bbd006a1807ca25224fe83424184fe50ec9112cae7c1c99056f7102459925d3ea68f8be2c44831881797e6e620e15199c64a4cab3d74b2c11@127.0.0.1:30312
  geth --nousb --datadir=$pwd --syncmode 'full' --port 30312 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8547 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x28f7E81f697255C5EF43a1297F743818e8d19306" --password password.txt  

  ```



### Creating a client 
```
touch static-nodes.json
```

and add the following contents. The enodes are declared 
```
  [       
    "enode://7aea49ad030c411f81a771dbe78053f4e445e085b9d7b4ecbca295f3843e66a773f3b76c47d16466e1ebb2b9002b431bac78e93456242359d250adf02b1bc2e6@127.0.0.1:30310",    
        
    "enode://5653af4ea2c820cab1f5b4f82ceef74c8120c98c141bd264c90c6d54ef293231261fcadf48d27811af3e6f72aed0c5686df6f8a9fedc4530d0fd868885e01a88@127.0.0.1:30311",    
        
    "enode://4f1adcbfbbcf672bbd006a1807ca25224fe83424184fe50ec9112cae7c1c99056f7102459925d3ea68f8be2c44831881797e6e620e15199c64a4cab3d74b2c11@127.0.0.1:30312"    
  ]   
```

copy this views to 
```
  cp static-nodes.json ./node1/
  cp static-nodes.json ./node2/
  cp static-nodes.json ./node3/
```

Connect client to the network
```
cd node1/
geth attach geth.ipc  
```

Checking how many peers are connected with this Node
```
net.peerCount    
```


## Installing a Geth Node
https://www.quicknode.com/guides/infrastructure/how-to-install-and-run-a-geth-node


MacOS
```
 brew install ethere
```

Setting up a Private POA Ethereum Network
---
https://www.c-sharpcorner.com/article/setup-your-private-ethereum-network-with-geth2/


Setting up Nodes
```
# Directory to hold blockchain nodes
mkdir blockchain 

# Sub node directories
mkdir node1 node2 node3  

# Creating a new account on Node 1
  # Public address of the key:   0x6cFE9E52E96BFa9758E47f95a50568f5852B9785
  # Path of the secret key file: node1/keystore/UTC--2022-07-23T21-27-07.345283000Z--6cfe9e52e96bfa9758e47f95a50568f5852b9785

geth --datadir node1/ account new    



# Creating a new account on Node 2
  # Public address of the key:   0x36792a0ECCc9fccD8A8c82029d13BD14CC61d3d7
  # Path of the secret key file: node2/keystore/UTC--2022-07-23T21-27-43.325522000Z--36792a0eccc9fccd8a8c82029d13bd14cc61d3d7

geth --datadir node2/ account new    



# Creating a new account on Node 3
  # Public address of the key:   0x28f7E81f697255C5EF43a1297F743818e8d19306
  # Path of the secret key file: node3/keystore/UTC--2022-07-23T21-28-07.739526000Z--28f7e81f697255c5ef43a1297f743818e8d19306

geth --datadir node3/ account new     
```

Save addresses to accounts.txt file
```
echo '0x6cFE9E52E96BFa9758E47f95a50568f5852B9785' >> accounts.txt
echo '0x36792a0ECCc9fccD8A8c82029d13BD14CC61d3d7' >> accounts.txt
echo '0x28f7E81f697255C5EF43a1297F743818e8d19306' >> accounts.txt
```


save passwords to individual password.txt files
```
echo 'pwd@node1' > node1/password.txt
echo 'pwd@node2' > node2/password.txt
echo 'pwd@node3' > node3/password.txt
```


Creating a new genesis file
```
puppeth

# network   = truechain
# consensus = Clique
# Seconds per block = 15

```

Rename generated gensis file
```
 mv truechain.json genesis.json 
```

Initialize nodes
```
geth --datadir node1/ init genesis.json  
geth --datadir node2/ init genesis.json  
geth --datadir node3/ init genesis.json  
```


## Developing on the Ethereum Network
https://www.c-sharpcorner.com/article/create-your-own-cryptocurrency-in-private-consortium-network-ethereum-azure-bloc/
