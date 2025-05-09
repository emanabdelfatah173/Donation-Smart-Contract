// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

// Donation Contract

contract DonationContract {
    // Address of contract owner
    address payable public owner;

    // A variable to track total donations
    uint256 public totalDonations;

    // to store donor information
    struct Donor {
        address donorAddress;
        uint256 amount;
        uint256 timestamp;
    }

    // Array to store all donors
    Donor[] public donors;

    // Mapping to store donations per address
    mapping(address =>uint256) public donationsPerAddress;

    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    event FundsWithdrawn(address indexed owner, uint256 amount, uint256 timestamp);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this operation");
        _;
    }

    constructor() {
        owner = payable (msg.sender);
    }

    // Function to allow users to donate
    function donate() public payable {
        require(msg.value > 0, "Donation value can not be zero");

        totalDonations += msg.value;

        donationsPerAddress[msg.sender] += msg.value;

        donors.push(Donor({
            donorAddress: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        }));

        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }

    // allows direct donations
    receive() external payable {
        donate();
    }

    // Function to retrieve total number of donors
    function getDonorsCount() public view returns (uint256) {
        return donors.length;
    }

    // Function for owner to withdraw funds
    function withdraw(uint256 _amount) public onlyOwner {
        require(_amount <= address(this).balance, "not enough funds");

        // Transfer funds to owner
        owner.transfer(_amount);

        emit FundsWithdrawn(owner, _amount, block.timestamp);
    }

    // Function for owner to withdraw all funds
    function withdrawnAll() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0,"no funds");

        // Transfer all funds to owner
        owner.transfer(balance);

        emit FundsWithdrawn(owner, balance, block.timestamp);
    }

    // Function to get contract balance
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}