
# Crypto Devs NFT Collection

Crypto Devs is an exclusive NFT collection that offers early supporters guaranteed access to the NFT mint. This project consists of two smart contracts: `Whitelist.sol` and `CryptoDevs.sol`.

[Learnweb3](https://learnweb3.io/) Exercise

## Features

1. **Limited Supply**: There are a total of 20 Crypto Devs NFTs that can ever exist.
2. **Whitelisting**: Early supporters can join the whitelist to get guaranteed access to the NFT mint.
3. **Free Minting for Whitelisted Users**: Whitelisted users can mint one NFT per transaction for free.
4. **Paid Minting for Non-Whitelisted Users**: Non-whitelisted users need to pay 0.01 ETH to mint one NFT per transaction.
5. **One NFT per Transaction**: Users are allowed to mint only one NFT per transaction.

## Contracts

### Whitelist.sol

The `Whitelist.sol` contract manages the whitelisting process. It allows users to add their addresses to the whitelist, subject to a maximum limit set during deployment. The contract keeps track of the number of whitelisted addresses and provides a function to check if an address is whitelisted.

### CryptoDevs.sol

The `CryptoDevs.sol` contract inherits from the `ERC721Enumerable` and `Ownable` contracts from OpenZeppelin. It manages the minting and ownership of the Crypto Devs NFTs. The contract interacts with the `Whitelist.sol` contract to check if a user is whitelisted and applies the corresponding minting rules.

## Getting Started

To use this project, you'll need to deploy both the `Whitelist.sol` and `CryptoDevs.sol` contracts. During the deployment of `CryptoDevs.sol`, you'll need to provide the address of the deployed `Whitelist.sol` contract.

Before the NFT mint, users can join the whitelist by calling the `addAddressToWhitelist` function in `Whitelist.sol`.

During the NFT mint, whitelisted users can call the `mint` function in `CryptoDevs.sol` without sending any ETH, while non-whitelisted users need to send 0.01 ETH along with the `mint` function call.

The project owner can withdraw the accumulated ETH from the `CryptoDevs.sol` contract by calling the `withdraw` function.

## Requirements

This project requires the following:

- Solidity ^0.8.24
- OpenZeppelin contracts: `ERC721Enumerable.sol` and `Ownable.sol`

## License

This project is licensed under the MIT License.

## About


### Addresses
Whitelist Sepolia Address: 0xDE5264Da32661A72398b36c620F77D30A192F345
