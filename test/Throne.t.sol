// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/Throne.sol";

contract ThroneTest is Test {
    Throne public throne;
    Attack public attack;

    function setUp() public {
        throne = new Throne();
        attack = new Attack(throne);
    }

    function testAttack() public {  
        address alice = address(1);
        vm.startPrank(alice);
        vm.deal(alice, 1 ether);
        attack.attack{value: 1 ether}();
        console.log("king = ", throne.king());
        console.log("balance = ", throne.balance());

        address bob = address(2);
        vm.startPrank(bob);
        vm.deal(bob, 2 ether);
        throne.claimThrone{value : 2 ether}();
        console.log("king = ", throne.king());
        console.log("balance = ", throne.balance());
    }
}
