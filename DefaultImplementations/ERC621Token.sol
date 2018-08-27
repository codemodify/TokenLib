pragma solidity ^0.4.24;

import "../Interfaces/ERC621Interface.sol";

import "./ERC20Token.sol";

//
// Spec, Credits and Inspirations
//
contract ERC621Token is ERC20Token, ERC621Interface {

    // ~~~~ ~~~~ ~~~~ ERC621Interface REQUIRED Methods ~~~~ ~~~~ ~~~~ ~~~~ ~~~~
    function increaseSupply(uint value, address to) public returns (bool) {
    }

    function decreaseSupply(uint value, address from) public returns (bool) {
    }
}
