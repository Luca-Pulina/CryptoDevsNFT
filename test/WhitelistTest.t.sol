// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Whitelist} from "../src/Whitelist.sol";
import {DeployCDV} from "../script/DeployCDV.s.sol";

contract WhitelistTest is Test {
    Whitelist public whitelist;

    address public PLAYER_1 = makeAddr("player1");
    address public PLAYER_2 = makeAddr("player2");
    address public PLAYER_3 = makeAddr("player3");

    function setUp() public {
        DeployCDV deployCDV = new DeployCDV();
        (whitelist,) = deployCDV.run();
    }

    function testOnlyOnceAddress() public {
        vm.prank(PLAYER_1);
        whitelist.addAddressToWhitelist();
        vm.expectRevert(Whitelist.Whitelist__SenderHasAlreadyBeenWhitelisted.selector);
        vm.prank(PLAYER_1);
        whitelist.addAddressToWhitelist();
    }

    modifier addTwoPlayers() {
        vm.prank(PLAYER_1);
        whitelist.addAddressToWhitelist();
        vm.prank(PLAYER_2);
        whitelist.addAddressToWhitelist();
        _;
    }

    function testUpdateNumAddressesWhitelisted() public addTwoPlayers {
        uint8 expectednumAddresses = 2;
        assert(whitelist.s_numAddressesWhitelisted() == expectednumAddresses);
    }

    function testmaxPlayersInList() public addTwoPlayers {
        vm.expectRevert(Whitelist.Whitelist__AddressListIsFull.selector);
        vm.prank(PLAYER_3);
        whitelist.addAddressToWhitelist();
    }
}
