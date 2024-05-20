// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import {Whitelist} from "../src/Whitelist.sol";

contract DeployWhitelist is Script {
    uint8 constant MAX_WITHELIST_ADDRESSES = 2;

    function run() external returns (Whitelist) {
        vm.startBroadcast();
        Whitelist _whitelist = new Whitelist(MAX_WITHELIST_ADDRESSES);
        vm.stopBroadcast();
        return _whitelist;
    }
}
