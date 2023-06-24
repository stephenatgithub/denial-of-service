// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract NewThrone {
    address public king;
    uint public balance;
    mapping(address => uint) public balances;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");

        balances[king] += balance;

        balance = msg.value;
        king = msg.sender;
    }

    function withdraw() public {
        require(msg.sender != king, "Current king cannot withdraw");

        uint amount = balances[msg.sender];

        // to protect from reentrancy attack
        // update balance = 0 before external call 
        balances[msg.sender] = 0;

        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}


contract Attack {
    NewThrone newThrone;

    constructor(NewThrone _newThrone) {
        newThrone = NewThrone(_newThrone);
    }

    function attack() public payable {
        newThrone.claimThrone{value: msg.value}();
    }
}


