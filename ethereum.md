# Overview
This document shows step by step how to setup an Ethereum Private Network using the Proof of Authority concensus engine.
Geth is the Golang implementation of an EVM node. This will be what we use.


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
geth --datadir node4/ init genesis.json  
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

  Start Node 4 Client mode 
  ```
  # Local Host - Allow HTTP
  geth --nodiscover --nousb --datadir=$pwd --syncmode 'full' --port 30313 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8548 --http.api admin,eth,miner,net,txpool,personal,web3 --mine --allow-insecure-unlock

  # Production - Allow HTTP
  geth --nodiscover --nousb --datadir=$pwd --syncmode 'full' --port 30313 --miner.gasprice 0 --miner.gastarget 470000000000 --http --http.addr 'localhost' --http.port 8548 --http.api admin,eth,miner,net,txpool,personal,web3 --mine
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

and then restart all your nodes


## Interacting with the Ethereum Network - command line

### Connecting to the private Network - MetaMask
https://blog.cryptostars.is/connect-geth-ethereum-private-network-to-metamask-7c58a0229eb6


Installing Web3 client
```
curl -LSs https://raw.githubusercontent.com/gochain/web3/master/install.sh | sh
```

Extracting private key from JSON file
```
 web3 account extract --keyfile "/Users/garyjob/Applications/truechain/node1/keystore/UTC--2022-07-24T22-14-45.104291000Z--9f8312a6579d2dd2984663426df3b12e2fd5d480"  --password "12345678"
```

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
# Node 1 - signer
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")

# Node 1 - accounts 
eth.getBalance("0x839efe40d4cae883d8455c36a02c15681d0a9df0")
eth.getBalance("0x9f8312a6579d2dd2984663426df3b12e2fd5d480")

# Node 2 - signer
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")

# Node 3 - signer
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")


# Node 4 - Client
eth.getBalance("0x4e971e213a98ae75e0e13cf929609636d2abc32a")
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
personal.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x9f8312a6579d2dd2984663426df3b12e2fd5d480", value: 1000, gas: 100000, gasPrice: 2 }, '12345678')

# Via Ethereum Network
eth.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x4e971e213a98ae75e0e13cf929609636d2abc32a", value: 100000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")


eth.sendTransaction({from: "0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7", to: "0x28f7e81f697255c5ef43a1297f743818e8d19306", value: 4000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x36792a0eccc9fccd8a8c82029d13bd14cc61d3d7")
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")

eth.sendTransaction({from: "0x28f7e81f697255c5ef43a1297f743818e8d19306", to: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", value: 5000, gas: 1000000, gasPrice: 2 })
eth.getBalance("0x28f7e81f697255c5ef43a1297f743818e8d19306")
eth.getBalance("0x6cfe9e52e96bfa9758e47f95a50568f5852b9785")

## eth.sendTransaction({from: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", to: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", value: 0, gas: 1000000, gasPrice: 2, data: "Hello World" })

eth.sendTransaction({from: "0x4e971e213a98ae75e0e13cf929609636d2abc32a", to: "0x6cfe9e52e96bfa9758e47f95a50568f5852b9785", value: 2000, gas: 1000000, gasPrice: 2 })

```

Checking the status
```
eth.getTransaction("0xc4d845cfd77e6af5b5ac5025d86674ab421f06150d204375569adce6f973c9c5") 
eth.getTransactionReceipt("0xc4d845cfd77e6af5b5ac5025d86674ab421f06150d204375569adce6f973c9c5") 
```


### Connecting to private Network - JSON RPC

Get Balance
```
curl --data '{"jsonrpc":"2.0","method":"eth_getBalance", "params": ["0x6cFE9E52E96BFa9758E47f95a50568f5852B9785", "latest"], "id":2}' -H "Content-Type: application/json" localhost:8547
```

Get Status of Transaction
```
curl -X POST --data '{"jsonrpc":"2.0","method":"eth_getTransactionByHash","params":["0x5bf012248579561b09101dc6590d47ca2fd36c1c5107c6af203c2a9e36dbd198"],"id":1}' -H "Content-Type: application/json" localhost:8547
```


## Setting up environment for developing smart contracts
https://medium.com/blockchainbistro/set-up-a-private-ethereum-blockchain-and-deploy-your-first-solidity-smart-contract-on-the-caa8334c343d#:~:text=Install%20the%20requisite%20software%20packages,to%20the%20private%20Ethereum%20network.

### Install NodeJs codebases
```
npm install -g truffle
```

```
npm install -g solc
```

### Creating a smart contract
Instantiate a truffle setup in your desired folder
```
truffle init 
```

See the blockchainbistro article on the following sets
- create a new smart contract in the "contracts" folder
  ```
  pragma solidity ^0.4.15;
  contract Hello {
     string public message;
     function Hello() {
     message = "Hello, World : This is a Solidity Smart Contract on the Private Ethereum Blockchain ";
     }
  }
  ```

- add a new migration in the "migrations" folder
  ```
  var Hello = artifacts.require("./Hello.sol");
  module.exports = function(deployer) {
     deployer.deploy(Hello);
  };
  ```

- Update truffle-config.js in the root folder
  ```
  module.exports = {
    rpc: {
      host:"localhost",
      port:8545
    },
    networks: {
      development: {
        host: "localhost", //our network is running on localhost
        port: 8545, // port where your blockchain is running
        network_id: "*",
        from: "0x6cFE9E52E96BFa9758E47f95a50568f5852B9785", // use the account-id generated during the setup process
        gas: 100000
      }
    }
  };
  ```

Compile the smart contract in the truffle root location
```
truffle compile
```

Deploy the smart contract in the truffle root location
  - Make sure to unlock the account being declared in the truffle-config.js via Geth before running this line to avoid error message
    - "truffle deployment failure authentication needed"
```
truffle migrate
```

### Interacting with Smart Contract

Start the console
```
truffle console
```

In the console, run the following commands to interact with the smart contract
```
var dApp
Hello.deployed().then(function(instance) { dApp = instance; })

# Get the value of the smart contract attribute
dApp.message.call()
```


## Developing on the Ethereum Network
https://www.c-sharpcorner.com/article/create-your-own-cryptocurrency-in-private-consortium-network-ethereum-azure-bloc/
