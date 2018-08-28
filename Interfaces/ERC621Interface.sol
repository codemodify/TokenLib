pragma solidity ^0.4.24;

interface ERC621Interface {

    // ~~~~ ~~~~ ~~~~ REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~

    // Increases total supply by minting new tokens and transferring them to a desired address
    function increaseSupply(uint value, address to) external returns (bool);

    // Decreases total supply by subtracting from desired address
    function decreaseSupply(uint value, address from) external returns (bool);
}