// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {CryptoDevs} from "../src/CryptoDevs.sol";
import {Whitelist} from "../src/Whitelist.sol";

import {DeployCDV} from "../script/DeployCDV.s.sol";

contract CryptoDevsTest is Test {
    CryptoDevs public cryptoDevs;
    Whitelist public whitelist;
    address public owner;
    address public PLAYER_1 = makeAddr("player1");
    address public PLAYER_2 = makeAddr("player2");
    address public PLAYER_3 = makeAddr("player3");

    function setUp() public {
        owner = address(this);

        whitelist = new Whitelist(2);
        cryptoDevs = new CryptoDevs(address(whitelist));
        vm.deal(PLAYER_1, 2 ether);
        vm.deal(PLAYER_3, 2 ether);
        vm.prank(PLAYER_1);
        whitelist.addAddressToWhitelist();
        vm.prank(PLAYER_2);
        whitelist.addAddressToWhitelist();
    }

    function testMint() public {
        // user1 mints a token
        vm.prank(PLAYER_1);
        cryptoDevs.mint{value: 0.01 ether}();

        assertEq(cryptoDevs.balanceOf(PLAYER_1), 1);
        assertEq(cryptoDevs.totalSupply(), 1);
    }

    function testMintAlreadyOwned() public {
        // user1 mints a token
        vm.prank(PLAYER_1);
        cryptoDevs.mint{value: 0.01 ether}();

        // user1 tries to mint again and should fail
        vm.prank(PLAYER_1);
        vm.expectRevert(CryptoDevs.CryptoDevs__AlreadyOwned.selector);
        cryptoDevs.mint{value: 0.01 ether}();
    }

    function testMintNotEnoughEther() public {
        // user1 tries to mint without enough ether
        vm.prank(PLAYER_3);
        vm.expectRevert(CryptoDevs.CryptoDevs__NotEhoughEther.selector);
        cryptoDevs.mint{value: 0.005 ether}();
    }

    function testMintExceededMaxSupply() public {
        for (uint256 i = 0; i < 20; i++) {
            address user = address(uint160(i + 0x10));
            vm.deal(user, 1 ether);
            vm.prank(user);
            whitelist.addAddressToWhitelist();
            cryptoDevs.mint{value: 0.01 ether}();
        }

        // Next mint should fail
        vm.prank(PLAYER_1);
        vm.expectRevert(CryptoDevs.CryptoDevs__ExceededMaxSupply.selector);
        cryptoDevs.mint{value: 0.01 ether}();
    }

    function testWithdrawNotOwner() public {
        // user1 mints a token
        vm.prank(PLAYER_1);
        cryptoDevs.mint{value: 0.01 ether}();

        // user2 tries to withdraw and should fail
        vm.prank(PLAYER_2);
        vm.expectRevert("Ownable: caller is not the owner");
        cryptoDevs.withdraw();
    }
}
