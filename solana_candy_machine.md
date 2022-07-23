- Over all instructions
  - Creating your Candy Machine: https://www.youtube.com/watch?v=inG53fpi_Lo
  - Creating your NFT assets: https://www.youtube.com/watch?v=6EEWFSvxFfs

- Pre-requisites:
  - NodeJS: v14.7.5

- Install ts-node
  ```
  npm install -g ts-node
  ```

- Install yarn
  ```
  npm install -g yarn
  ```


- Install solana CLI: https://github.com/garyjob/Setup-Wiki/blob/master/solana.md

- Install Metaplex CLI: 
  ```
    $ git clone https://github.com/metaplex-foundation/metaplex.git
    $ cd metaplex
    $ cd js
    $ yarn install
    $ yarn bootstrap
    $ yarn start
  ```

- Configurate Solana Cli to DevNet for testing purposes
  ```
  solana config set --url https://api.devnet.solana.com
  ```

- Preparing the configuration file for the candy machine V2 - https://docs.metaplex.com/candy-machine-v2/configuration
  ```
  {
      "price": 1.5,
      "number": 1500,
      "gatekeeper": null,
      "solTreasuryAccount": "7fHHgY6Rpx63ancGYJKUgtQ6JdzQ3SuLj991KvqHmZu5",
      "splTokenAccount": null,
      "splToken": null,
      "goLiveDate": "25 Dec 2021 00:00:00 GMT",
      "endSettings": null,
      "whitelistMintSettings": null,
      "hiddenSettings": null,
      "storage": "arweave-sol",
      "ipfsInfuraProjectId": null,
      "ipfsInfuraSecret": null,
      "nftStorageKey": null,
      "awsS3Bucket": null,
      "noRetainAuthority": false,
      "noMutable": false
  }
  ```

- Preparing your Asset - https://docs.metaplex.com/candy-machine-v2/preparing-assets
  ```
  {
      "name": "Number #0001",
      "symbol": "NB",
      "description": "Collection of 10 numbers on the blockchain. This is the number 1/10.",
      "seller_fee_basis_points": 500,
      "image": "0.png",
      "attributes": [
          {"trait_type": "Layer-1", "value": "0"},
          {"trait_type": "Layer-2", "value": "0"}, 
          {"trait_type": "Layer-3", "value": "0"},
          {"trait_type": "Layer-4", "value": "1"}
      ],
      "properties": {
          "creators": [{"address": "7fHHgY6Rpx63ancGYJKUgtQ6JdzQ3SuLj991KvqHmZu5", "share": 100}],
          "files": [{"uri": "0.png", "type": "image/png"}]
      },
      "collection": {"name": "numbers", "family": "numbers"}
  }  
  ```

- Uploading the NFT
  ```
  metaplex upload ./assets --env devnet --keypair /Users/garyjob/.config/solana/id.json --log-level trace --number 4
  ```