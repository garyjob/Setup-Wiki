# Overview
This document shows step by step how to setup an Ethereum Private Network using the Proof of Authority concensus engine.
Geth is the Golang implementation of an EVM node. This will be what we use.

## Interacting with the Ethereum Network - command line

### Connecting to the private Network - Geth console
Connect client to the network
```
cd node1/
geth attach geth.ipc  
```

Checking how many peers are connected with this Node
```
net.peerCount    
```

Checking balance of account
```
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")
eth.getBalance("0x839efe40d4cae883d8455c36a02c15681d0a9df0")

```

Creating a new account on the private network
```
# 0x839efe40d4cae883d8455c36a02c15681d0a9df0
personal.newAccount()
```

List all accounts with key stored on the current node
```
personal.listAccounts
```

Unlock an account
```
personal.unlockAccount("6cfe9e52e96bfa9758e47f95a50568f5852b9785", "12345678")
```

Send coins from one account to another 
  - if genesis.son file "clique"."period" is set to 0 
    - then will see the following error="signed recently, must wait for others"
    - All signers are not allowed to sign two consecutive blocks. 
    - https://stackoverflow.com/questions/50003230/clique-proof-of-authority-consensus-for-private-blockchain
    - https://github.com/ethereum/go-ethereum/issues/16406
```
# Personal accounts
personal.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7", value: 1000, gas: 100000, gasPrice: 2 }, '12345678')

# Via Ethereum Network
eth.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7", value: 100000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")


eth.sendTransaction({from: "0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7", to: "0x28f7e81f697255c5ef43a1297f743818e8d19306", value: 4000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")

eth.sendTransaction({from: "0x28f7e81f697255c5ef43a1297f743818e8d19306", to: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", value: 5000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")

## eth.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", value: 0, gas: 1000000, gasPrice: 2, data: "Hello World" })

```

Checking the status
```
eth.getTransaction("0xc4d845cfd77e6af5b5ac5025d86674ab421f06150d204375569adce6f973c9c5") 
eth.getTransactionReceipt("0xc4d845cfd77e6af5b5ac5025d86674ab421f06150d204375569adce6f973c9c5") 
```


### Connecting to private Network - JSON RPC
```
curl --data '{"jsonrpc":"2.0","method":"eth_getBalance", "params": ["0x6cFE9E52E96BFa9758E47f95a50568f5852B9785", "latest"], "id":2}' -H "Content-Type: application/json" localhost:8547
```

## Troubleshooting
Checking Node Info
```
admin.nodeInfo
```

Manually adding peers
```
admin.addPeer("Argument") 
```

Check list of peers
```
admin.peers
```

Getting the list of signers
```
clique.getSigners()
```


## Running the private Ethereum Network

https://www.c-sharpcorner.com/article/setup-your-private-ethereum-network-with-geth2/
https://geth.ethereum.org/docs/getting-started


Command to start various nodes
  
  Start in folder node1
  ```
  # Node 1 - make sure to replace the address with the one associated with this node
    # output will be self=enode://a8ebbdc7fa145363820751d032a654a19ff84d002f7337b5dc749e3aa01f88d5dddd5d6a366f8e939714e87193bd153e6644b72505bd8bf380f621264feab170@127.0.0.1:30310
  geth --nodiscover --nousb --datadir=$pwd --syncmode 'full' --port 30310 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8545 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x6cFE9E52E96BFa9758E47f95a50568f5852B9785" --password password.txt  
  ```

  Start in folder node2
  ```
  # Node 2 - make sure to replace the address with the one associated with this node
    # output will be self=enode://0b2e2bb0c524e70b920db2c6c443cba011d1111dcb18a6570d7dd5518dae6bcd0c2e5794fa536fbb08ab62a9bbd1f739590b06bd75c86cac2a1f14fdaf271867@127.0.0.1:30311
  geth --nodiscover --nousb --datadir=$pwd --syncmode 'full' --port 30311 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8546 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x36792a0ECCc9fccD8A8c82029d13BD14CC61d3d7" --password password.txt  
  ```

  Start in folder node3
  ```
  # Node 3 - make sure to replace the address with the one associated with this node
    # output will be self=enode://04dd1e0b4bac727d6bf019eb4ecf414b39a395456dc65130f449f5ebca77fd851fa616f87ff2b75f4576fd0849fd58ff8513e273b6fb36086aa2763542af26af@127.0.0.1:30312
  geth --nodiscover --nousb --datadir=$pwd --syncmode 'full' --port 30312 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8547 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock --unlock "0x28f7E81f697255C5EF43a1297F743818e8d19306" --password password.txt  

  ```



### Syncing up the clients
```
touch static-nodes.json
```

and add the following contents. The enodes are declared 
```
  [       
    "enode://a8ebbdc7fa145363820751d032a654a19ff84d002f7337b5dc749e3aa01f88d5dddd5d6a366f8e939714e87193bd153e6644b72505bd8bf380f621264feab170@127.0.0.1:30310",    
        
    "enode://0b2e2bb0c524e70b920db2c6c443cba011d1111dcb18a6570d7dd5518dae6bcd0c2e5794fa536fbb08ab62a9bbd1f739590b06bd75c86cac2a1f14fdaf271867@127.0.0.1:30311",    
        
    "enode://04dd1e0b4bac727d6bf019eb4ecf414b39a395456dc65130f449f5ebca77fd851fa616f87ff2b75f4576fd0849fd58ff8513e273b6fb36086aa2763542af26af@127.0.0.1:30312"    
  ]   
```

copy this views to 
```
  cp static-nodes.json ./node1/
  cp static-nodes.json ./node2/
  cp static-nodes.json ./node3/
```


## Installing a Geth Node
https://www.quicknode.com/guides/infrastructure/how-to-install-and-run-a-geth-node


MacOS
```
 brew install ethereum
```

## Setting up a Private POA Ethereum Network

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
