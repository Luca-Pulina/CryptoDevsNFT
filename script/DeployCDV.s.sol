// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Whitelist} from "../src/Whitelist.sol";
import {CryptoDevs} from "../src/CryptoDevs.sol";

contract DeployCDV is Script {
    uint8 constant MAX_WITHELIST_ADDRESSES = 2;

    function run() external returns (Whitelist, CryptoDevs) {
        vm.startBroadcast();
        Whitelist _whitelist = new Whitelist(MAX_WITHELIST_ADDRESSES);
        CryptoDevs _cryptoDevs = new CryptoDevs(address(_whitelist));
        vm.stopBroadcast();
        return (_whitelist, _cryptoDevs);
    }
}
