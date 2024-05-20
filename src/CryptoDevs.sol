// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

import {Whitelist} from "./Whitelist.sol";

contract CryptoDevs is ERC721Enumerable, Ownable {
    error CryptoDevs__ExceededMaxSupply();
    error CryptoDevs__AlreadyOwned();
    error CryptoDevs__NotEhoughEther();
    error CryptoDevs__FailedToWithdraw();

    uint256 public constant price = 0.01 ether;
    uint256 public constant maxTokenIds = 20;

    Whitelist whitelist;

    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    constructor(address whitelistContract) ERC721("CryptoDevs", "CDV") Ownable(msg.sender) {
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.getMaxWhitelistedAddresses();
    }

    function mint() public payable {
        if (totalSupply() + reservedTokens - reservedTokensClaimed > maxTokenIds) {
            revert CryptoDevs__ExceededMaxSupply();
        }

        if (whitelist.whitelistedAddresses(msg.sender) && msg.value >= price) {
            if (balanceOf(msg.sender) > 0) {
                revert CryptoDevs__AlreadyOwned();
            } else {
                if (msg.value < price) {
                    revert CryptoDevs__NotEhoughEther();
                }
            }
            uint256 tokenId = totalSupply();
            _safeMint(msg.sender, tokenId);
        }
    }

    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent,) = _owner.call{value: amount}("");
        if (!sent) {
            revert CryptoDevs__FailedToWithdraw();
        }
    }
}
