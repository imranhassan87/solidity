pragma solidity ^0.6.0;

contract HotelRoom {
    
    address payable public owner;
    event Occupy (address _occupent, uint _amount);
    Statuses currentStatus;
    
    constructor() public {
        owner = msg.sender;
        currentStatus = Statuses.Vacant;
    }
    
    enum Statuses {Vacant, Occupied}
    
    
    modifier checkVacant {
        require(currentStatus == Statuses.Vacant,"Sorry the room is already occupied!");
        _;
    }
    
    modifier checkPrice(uint _amount) {
        require(msg.value >= _amount,"not enough ether provided");
        _;
    }
    
    receive() external payable checkVacant checkPrice(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }
}