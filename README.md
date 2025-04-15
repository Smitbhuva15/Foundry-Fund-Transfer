# Foundry Fund Me

## Getting Started

### Requirements

- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`



  # Usage

## Deploy

```
forge script script/DeployFundMe.s.sol
```

## Testing

1. Unit
2. Integration
3. Forked
4. Staging


```
forge test
```

or 

```
// Only run test functions matching the specified regex pattern.

forge test --match-test testFunctionName
```

or

```
forge test --fork-url $SEPOLIA_RPC_URL
```

### Test Coverage

```
forge coverage
```









# Deployment to a testnet or mainnet

1. Setup environment variables
2. Get testnet ETH
3. Deploy

### scripts


```
forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY
```

After deploying to a testnet or local net, you can run the scripts. 

Using cast deployed locally example: 

```
cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
```


### Withdraw

```
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()"  --private-key <PRIVATE_KEY>
```

## Estimate gas

You can estimate how much gas things cost by running:

```
forge snapshot
```
# Formatting


To run code formatting:
```
forge fmt
```