# Setting up

## Ubuntu
```
 curl -sSf https://raw.githubusercontent.com/solana-labs/solana/v1.1.10/install/solana-install-init.sh | sh -s - v1.8.10
```

## MacOS
Install rust
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install solana tool kit
```
sh -c "$(curl -sSfL https://release.solana.com/v1.9.0/install)"
```

Install spl-token utility
```
cargo install spl-token-cli
```

add command to path
```
. "$HOME/.cargo/env"
export PATH="/Users/garyjob/.local/share/solana/install/active_release/bin:$PATH"
```

Check configuration
```
solana config get
```

Change configuration 
- DevNet
```
solana config set --url https://api.devnet.solana.com
```

- MainNet
```
solana config set --url https://api.mainnet-beta.solana.com
```

  MainNet output
  ```
  RPC URL: https://api.mainnet-beta.solana.com 
  WebSocket URL: wss://api.mainnet-beta.solana.com/ (computed)
  Keypair Path: /Users/garyjob/.config/solana/id.json 
  ```

  Devnet output
  ```
  solana-keygen recover 'prompt:?key=0/0' --outfile ~/.config/solana/id.json
  ```


# Setting up wallets

## Connecting to the phantom wallet
Connect to a wallet - when prompted insert 12 word phrase from your wallet
```
solana-keygen recover 'prompt:?key=0/0' --outfile ~/.config/solana/id.json
```

Check balance of solana in connected wallet
```
solana balance
```

Check what is your public key
```
solana-keygen pubkey
```


Verify your public key
```
solana-keygen verify INSERT_YOUR_PUBLIC_KEY_HERE
```

## Creating a new wallet and connecting to to
Creating a new wallet
```
solana-keygen new --no-passphrase -so "signer-1.json"
```

Get public key 
```
solana-keygen pubkey "signer-1.json"
```

Air drop some solana
```
solana airdrop 100
```


# Minting tokens 
Creating new token
```
spl-token create-token
```

Check the total supply of tokens of a DAO
```
# Local Mint Address = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token supply 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq

```

Create a new account to hold DAO tokens
```
# Local Mint Address = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token create-account 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq

# New account to hold token that got created HnTCXboCyGpFkvMERcg8x92ysHkpNeEWnqnRKH5gHc4x
```

Check the balance of DAO tokens in the account of the attached wallet
```
# Local Mint Address = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token balance 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
```

Minting tokens to account
```
# Local Mint Address = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token mint 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq 100
```

Transferring tokens
```
# Local Mint Value = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
# Number of tokens = 500
# Destination account for token = BWxAEUCX9E27FGKtqHc2J88pk2CAjDpTjbzHo8d97Z4D
spl-token transfer 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq 100 J2QDpPWz28C4z7rAGxiC2dV9whyMThT3dBbGKQeD3SW  --allow-unfunded-recipient --fund-recipient
```

List all the accounts for this token
```
# Local Mint Value = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token accounts 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq -v
```

List supply of all these tokens
```
# Local Mint Value = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
 spl-token supply 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
```

Disable future minting
```
# Local Mint Value = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
spl-token authorize 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq mint --disable
```

Set token authorization to the follow account
```
# Local Mint Value = 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq
# Public key of the account holder
spl-token authorize 438LPQa9NqL3WrRiDHjRh78DbtmDthLWD6QtZx7LM1hq mint 48xsMyMx4nDfgxyB8AspumVaeART3cQWzFwYE82UZsFg
```

# Minting tokens 

Publishing token on MainNet
https://learn.figment.io/tutorials/sol-mint-token?fbclid=IwAR272uyLOxPXKpHcBhtuI-kRIybRGLGeSewva91PXBmugi7v2usvSkLb8cI

Creating a market id for token on Serum
- https://trade.dexlab.space/#/minting-lab/new-markets

Listing market on an exchange
https://trade.dexlab.space/#/minting-lab/add-markets