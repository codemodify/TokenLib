pragma solidity ^0.4.24;

interface ERC233Interface {

    // ~~~~ ~~~~ ~~~~ REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    function transfer(address to, uint256 value, bytes data ) public returns (bool);


    // ~~~~ ~~~~ ~~~~ REQUIRED Events ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    event Transfer(address indexed from, address indexed to, uint256 value, bytes data);
}

interface ERC233TokenReceiverInterface {
    function tokenFallback(address from, uint256 value, bytes data) public;
}