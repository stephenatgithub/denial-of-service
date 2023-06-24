// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/NewThrone.sol";

contract NewThroneTest is Test {
    NewThrone public newThrone;
    Attack public attack;

    function setUp() public {
        newThrone = new NewThrone();
        attack = new Attack(newThrone);
    }

    function testAttack() public {  
        address alice = address(1);
        vm.startPrank(alice);
        vm.deal(alice, 1 ether);
        attack.attack{value: 1 ether}();
        console.log("king = ", newThrone.king());
        console.log("balance = ", newThrone.balance());

        address bob = address(2);
        vm.startPrank(bob);
        vm.deal(bob, 2 ether);
        newThrone.claimThrone{value : 2 ether}();
        console.log("king = ", newThrone.king());
        console.log("balance = ", newThrone.balance());
    }
}
