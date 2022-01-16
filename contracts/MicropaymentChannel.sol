//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./verification/SignatureValidator.sol";

contract MicropaymentChannel is SignatureValidator {
    
    // STATE VARIABLES
    address payable public owner;
    address payable public recipient;
    uint256 public orderTime;


    //EVENTS
    event PaymentClaimed(address indexed recipient, uint256 amount);

    constructor (address payable _recipient, uint256 _seconds) {
        require(_recipient != msg.sender && _recipient != address(0));
        owner = payable(msg.sender);
        recipient = _recipient;
        orderTime = block.timestamp + _seconds;
    }


    // MODIFIERS
    modifier onlyOwner {
        require(msg.sender == owner, "Access denied: You're not the owner");
        _;
    }

    modifier onlyRecipient {
        require(msg.sender == recipient, "Access denied: You're not the recipient");
        _;
    }

    modifier orderingExpired {
        require(block.timestamp > orderTime, "You can't claim payment at the moment");
        _;
    }
    
    
    //FUNCTIONS
    function claimPayment(bytes memory _signature, bytes32 _msgHash, uint256 _amount) public onlyRecipient orderingExpired {
        bytes32 msgBytes = getEthSignedHash(_msgHash);
        require(verify(msgBytes, _signature) == owner, "Invalid Address output");
        recipient.transfer(_amount);
        emit PaymentClaimed(msg.sender, _amount);
    }

    receive() external payable{}
}
