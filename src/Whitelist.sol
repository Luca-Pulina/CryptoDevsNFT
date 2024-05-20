// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Whitelist {
    error Whitelist__SenderHasAlreadyBeenWhitelisted();
    error Whitelist__AddressListIsFull();

    uint8 public immutable i_maxWhitelistedAddresses; // list of whitelisted addresses allowed
    mapping(address => bool) public whitelistedAddresses;
    uint8 public s_numAddressesWhitelisted; // how many addresses are whitelisted

    constructor(uint8 _maxWhitelistedAddresses) {
        i_maxWhitelistedAddresses = _maxWhitelistedAddresses;
    }

    function addAddressToWhitelist() public {
        if (whitelistedAddresses[msg.sender] == true) {
            revert Whitelist__SenderHasAlreadyBeenWhitelisted();
        }

        if (s_numAddressesWhitelisted >= i_maxWhitelistedAddresses) {
            revert Whitelist__AddressListIsFull();
        }

        whitelistedAddresses[msg.sender] = true;
        s_numAddressesWhitelisted++;
    }

    function getMaxWhitelistedAddresses() public view returns (uint256) {
        return s_numAddressesWhitelisted;
    }
}
