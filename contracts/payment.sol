// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MoneyTransferApp {
    mapping(address => uint256) public balances;

    event Deposit(address indexed _from, uint256 _amount);
    event Withdrawal(address indexed _to, uint256 _amount);

    // Function to deposit Ether into the contract
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Function to withdraw Ether from the contract
    function withdraw(uint256 _amount) public {
        require(_amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= _amount, "Insufficient balance");

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
        emit Withdrawal(msg.sender, _amount);
    }

    // Function to check the balance of a specific address
    function getBalance(address _address) public view returns (uint256) {
        return balances[_address];
    }
}
